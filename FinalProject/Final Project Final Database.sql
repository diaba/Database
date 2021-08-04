
-- --------------------------------------------------------------------------------
-- Final Project - Physical Database  
-- --------------------------------------------------------------------------------
USE dbFixinyerleak ;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors
-- --------------------------------------------------------------------------------
-- Drop Tables - 
-- --------------------------------------------------------------------------------
IF OBJECT_ID ('TJobMaterials')		IS NOT NULL DROP TABLE TJobMaterials
IF OBJECT_ID ('TMaterials')			IS NOT NULL DROP TABLE TMaterials
IF OBJECT_ID ('TVendors')			IS NOT NULL DROP TABLE TVendors
IF OBJECT_ID ('TJobWorkers')		IS NOT NULL DROP TABLE TJobWorkers
IF OBJECT_ID ('TWorkerSkills')		IS NOT NULL DROP TABLE TWorkerSkills
IF OBJECT_ID ('TSkills')			IS NOT NULL DROP TABLE TSkills
IF OBJECT_ID ('TWorkers')			IS NOT NULL DROP TABLE TWorkers
IF OBJECT_ID ('TJobs')			    IS NOT NULL DROP TABLE TJobs
IF OBJECT_ID ('TCustomers')	        IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TStates')			IS NOT NULL DROP TABLE TStates
IF OBJECT_ID ('TStatuses')		    IS NOT NULL DROP TABLE TStatuses
-- --------------------------------------------------------------------------------
-- Create Database  
-- --------------------------------------------------------------------------------

CREATE TABLE TJobs
(
	 intJobID							INTEGER				NOT NULL
	,intCustomerID						INTEGER				NOT NULL
	,intStatusID						INTEGER				NOT NULL
	,dtmStartDate						DATETIME			NOT NULL
	,dtmEndDate							DATETIME			NOT NULL
	,strJobDesc							VARCHAR(8000)		NOT NULL
	,CONSTRAINT TJobs_PK				PRIMARY KEY ( intJobID )
)

CREATE TABLE TCustomers
(
	  intCustomerID						INTEGER				NOT NULL
	 ,strFirstName						VARCHAR(255)		NOT NULL
	 ,strLastName						VARCHAR(255)		NOT NULL
	 ,strAddress						VARCHAR(255)		NOT NULL
	 ,strCity							VARCHAR(255)		NOT NULL
	 ,intStateID						INTEGER				NOT NULL
	 ,strZip							VARCHAR(255)		NOT NULL
	 ,strPhoneNumber					VARCHAR(255)		NOT NULL
	 ,CONSTRAINT TCustomer_PK			PRIMARY KEY ( intCustomerID )
)

CREATE TABLE TStatuses
(
	 intStatusID						INTEGER				NOT NULL
	,strStatus							VARCHAR(255)		NOT NULL
	,CONSTRAINT TStatuses_PK			PRIMARY KEY ( intStatusID )
)

CREATE TABLE TJobMaterials
(
	 intJobMaterialID					INTEGER				NOT NULL
	,intJobID							INTEGER				NOT NULL
	,intMaterialID						INTEGER				NOT NULL
	,intQuantity						INTEGER				NOT NULL
	,CONSTRAINT TCustomerJobMaterials_PK PRIMARY KEY ( intJobMaterialID )
)

CREATE TABLE TMaterials
(
	 intMaterialID						INTEGER				NOT NULL
	,strDescription						VARCHAR(255)		NOT NULL
	,monCost							MONEY				NOT NULL
	,intVendorID						INTEGER				NOT NULL
	,CONSTRAINT TMaterials_PK			PRIMARY KEY ( intMaterialID )
)

CREATE TABLE TVendors
(
	 intVendorID						INTEGER				NOT NULL
	,strVendorName						VARCHAR(255)		NOT NULL
	,strAddress							VARCHAR(255)		NOT NULL
	,strCity							VARCHAR(255)		NOT NULL
	,intStateID							INTEGER				NOT NULL
	,strZip								VARCHAR(255)		NOT NULL
	,strPhoneNumber						VARCHAR(255)		NOT NULL
	,CONSTRAINT TVendors_PK				PRIMARY KEY ( intVendorID )
)

CREATE TABLE TJobWorkers
(
	 intJobWorkerID						INTEGER				NOT NULL
	,intJobID							INTEGER				NOT NULL
	,intWorkerID						INTEGER				NOT NULL
	,intHoursWorked						INTEGER				NOT NULL
	,CONSTRAINT TCustomerJobWorkers_PK	PRIMARY KEY ( intJobWorkerID )
)

CREATE TABLE TWorkers
(
	 intWorkerID						INTEGER				NOT NULL
	 ,strFirstName						VARCHAR(255)		NOT NULL
	 ,strLastName						VARCHAR(255)		NOT NULL
	 ,strAddress						VARCHAR(255)		NOT NULL
	 ,strCity							VARCHAR(255)		NOT NULL
	 ,intStateID						INTEGER				NOT NULL
	 ,strZip							VARCHAR(255)		NOT NULL
	 ,strPhoneNumber					VARCHAR(255)		NOT NULL
	 ,dtmHireDate						DATETIME			NOT NULL
	 ,monHourlyRate						MONEY				NOT NULL
	 ,CONSTRAINT TWorkers_PK			PRIMARY KEY ( intWorkerID )
)

CREATE TABLE TWorkerSkills
(
	 intWorkerSkillID					INTEGER				NOT NULL
	,intWorkerID						INTEGER				NOT NULL
	,intSkillID							INTEGER				NOT NULL
	,CONSTRAINT	TWorkerSkills_PK		PRIMARY KEY ( intWorkerSkillID )
)

CREATE TABLE TSkills
(
	 intSkillID							INTEGER				NOT NULL
	,strSkill							VARCHAR(255)		NOT NULL
	,strDescription						VARCHAR(255)		NOT NULL
	,CONSTRAINT TSkills_PK				PRIMARY KEY ( intSkillID )
)

CREATE TABLE TStates
(
	 intStateID							INTEGER				NOT NULL
	,strState							VARCHAR(255)		NOT NULL
	,CONSTRAINT TStates_PK				PRIMARY KEY ( intStateID )
)

-- --------------------------------------------------------------------------------
-- Establish Referential Integrity  
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent							Column
-- -	-----							------							---------
-- 1	TJobs							TCustomers						intCustomerID    
-- 2	TJobs							TStatuses						intStatusID  

-- 3	TCustomers						TStates							intStateID  

-- 4	TJobMaterials					TJobs							intJobID 
-- 5	TJobMaterials					TMaterials						intMaterialID  

-- 6	TMaterials						TVendors						intVendorID  

-- 7	TVendors						TStates							intStateID   

-- 8	TJobWorkers						TJobs							intJobID  
-- 9	TJobWorkers						TWorkers						intWorkerID  

-- 10	TWorkers						TStates							intStateID   

-- 11	TWorkerSkills					TWorkers						intWorkerID   
-- 12	TWorkerSkills					TSkills							intSkillID   


-- 1
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TStatuses_FK
FOREIGN KEY ( intStatusID ) REFERENCES TStatuses ( intStatusID )

-- 2
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TCustomers_FK
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )

-- 3
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 4
ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TJobs_FK
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )   

-- 5
ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TMaterials_FK
FOREIGN KEY ( intMaterialID ) REFERENCES TMaterials ( intMaterialID )

-- 6
ALTER TABLE TMaterials ADD CONSTRAINT TMaterials_TVendors_FK
FOREIGN KEY ( intVendorID ) REFERENCES TVendors ( intVendorID )

-- 7
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 8
ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TJobs_FK
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )

-- 9
ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )

-- 10
ALTER TABLE TWorkers ADD CONSTRAINT TWorkers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 11
ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerskills_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )

-- 12
ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerskills_TSkills_FK
FOREIGN KEY ( intSkillID ) REFERENCES TSkills ( intSkillID )
-- --------------------------------------------------------------------------------
--	Step #3 : Add Data - INSERTS
-- --------------------------------------------------------------------------------
INSERT INTO TStates( intStateID, strState)
VALUES				(1, 'Ohio')
				   ,(2, 'Kentucky')
				   ,(3, 'Indiana')

INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, strCity, intStateID, strZip,strPhoneNumber)
VALUES				  (1, 'James', 'Jones', '321 Elm St.', 'Cincinnati', 1, '45201','8595131234')
					 ,(2, 'Sally', 'Smith', '37 Main Street', 'Florence', 2, '41042','8590001234')
					 ,(3, 'Jose', 'Hernandez', '1569 Windisch Rd', 'Norwood', 1, '45069','5130000000')
					 ,(4, 'Samba', 'Sy', '987 Main Street', 'Norwood', 1, '45218','5136561111')
					 ,(5, 'Ibou', 'Ly', '1569 Windisch Rd.', 'Union', 2, '41099','8592223333')
					 ,(6, 'Sall', 'Sene', '22 Main Street', 'Cincinnati', 1, '45218','8592223333')
					 ,(7, 'Baba', 'Mall', '1569 Windisch Rd.', 'Cincinnati', 1, '45069','7340121234')
					
					 

INSERT INTO TWorkers( intWorkerID,strFirstName,strLastName,strAddress,strCity,intStateID,strZip,dtmHireDate,monHourlyRate,strPhoneNumber)
VALUES				(1, 'Mike','Diop','123 Main St','Florence',1,'45042','1/3/2019',30,'859599234')
				   ,(2, 'Joe','Ba','123 Oldview Dr','Cincinnati',2,'41042','1/3/2020',50,'8533331234')
				   ,(3, 'Adama','Wade','5 Drive Ln','Union',2,'41091','1/3/2006',15,'859514454')	

INSERT INTO TSkills( intSkillID, strSkill, strDescription)
VALUES				(1, 'Hand and Arm Streght','Working with tigh spaces and able to manipulate small objects.')
				   ,(2, 'Installing Pipe Systems','Installing pipes system for Gas, Water, Stream and other liquids ')
				   ,(3, 'Installing Appliances',' New appliance installation like refrigerator and make it run.')
                  
INSERT INTO TWorkerSkills(intWorkerSkillID, intWorkerID,intSkillID)
VALUES                   (1,1,1)
                        ,(2,1,2) 
						,(3,1,3) 
						,(4,2,1) 
INSERT INTO TStatuses( intStatusID, strStatus)
VALUES				(1, 'Open')
				   ,(2, 'In Process')
				   ,(3, 'Complete')
				                  
INSERT INTO TVendors( intVendorID,strVendorName,strAddress,strCity,intStateID,strZip, strPhoneNumber)
VALUES				(1, 'Amado','123 Main St','Cincinnati',1,'45042','8596301234')
				   ,(2, 'Coumba','123 Oldview Dr','Florence',2,'41042','8591231234')
				   ,(3, 'Salif','5 Drive Ln','Union',2,'41091','5131231234')	

                  
INSERT INTO TMaterials( intMaterialID, strDescription,monCost, intVendorID)
VALUES				(1, 'adapter Male ends having threads outside',45,1)
				   ,(2, 'adapter Female ends having threads inside',50,1)
                   ,(3, 'adapter Female ends having threads inside steel',150,2)
				   ,(4, 'Nipple It connects pipes to appliances or two straight pipe runs.',80,2)
				   ,(5, 'Barb Used to grip the inside of a tube and seal the connection.',75,1)

INSERT INTO TJobs( intJobID, strJobDesc,intStatusID,dtmStartDate,dtmEndDate, intCustomerID)
VALUES				(1, 'Dripping faucets need to replace a new one',1,'1/1/2020','1/5/2020',1)
				   ,(2, 'Leaking pipe',2,'1/1/2020','1/2/2020',1)
				   ,(3, 'Sewer system backup',3,'1/1/2020','1/1/2020',2)
				   ,(4, 'Dripping faucets need to replace a new one',3,'1/1/2020','1/5/2020',2)
				   ,(5, 'Leaking pipe',2,'1/1/2020','1/2/2020',2)
				   ,(6, 'Sewer system backup',3,'1/1/2020','4/1/2020',1)
				   ,(7, 'Dripping faucets need to replace a new one',2,'6/1/2020','11/5/2020',3)
				   ,(8, 'Install new Dishwasher',3,'5/1/2020','1/2/2020',1)
				   ,(9, 'Sewer system backup',3,'4/1/2020','1/1/2020',4)
				   ,(10, 'Dripping faucets need to replace a new one',2,'6/1/2020','11/5/2020',5)
				   ,(11, 'Install new Dishwasher',3,'5/1/2020','1/2/2020',1)
				   ,(12, 'Sewer system backup',3,'4/1/2020','1/1/2020',6)

INSERT INTO TJobWorkers( intJobWorkerID,intJobID, intWorkerID,intHoursWorked)
VALUES				(1,1,1,4)
				   ,(2,1,2,8)
				   ,(3,2,2,3)
                   ,(4,2,3,4)
                   ,(5,3,1,6)
                   ,(6,3,2,8)
				   ,(7,3,3,3)
                   ,(8,4,3,5)
                   ,(9,5,1,6)
                   ,(10,6,2,2)
				   ,(11,7,2,2)
				   ,(12,8,2,2)
				   ,(13,9,1,2)
				   ,(14,9,2,2)
				   ,(15,9,3,2)

INSERT INTO TJobMaterials( intJobMaterialID, intJobID,intMaterialID,intQuantity)
VALUES				(1,1,1,4)
				   ,(2,1,2,3)
                   ,(3,1,3,2)
                   ,(4,2,2,3)
                   ,(5,2,3,2)
				   ,(6,3,3,2)
                   ,(7,5,3,3)
                   ,(8,6,3,2)
				   ,(9,6,1,2)
                   ,(10,7,3,3)
                   ,(11,8,1,2)
				   ,(12,8,2,3)
                   ,(13,9,1,2)
				   ,(14,10,1,3)
                   ,(15,11,2,2)
				   ,(16,12,1,2)
				  
 -- --------------------------------------------------------------------------------
--	Step #4 : 	Update and Deletes 
-- --------------------------------------------------------------------------------
--3.1. Create SQL to update the address for a specific customer. 
--Include a select statement before and after the update. 
SELECT * FROM TCustomers

UPDATE TCustomers
SET strAddress= '2 Main Street'
WHERE intCustomerID = 2

SELECT * FROM TCustomers
--3.2. Create SQL to increase the hourly rate by $2 for each worker 
--that has been an employee for at least 1 year. Include a select before and after the update.
SELECT * FROM TWorkers

UPDATE TWorkers
SET monHourlyRate = monHourlyRate + 2
WHERE dtmHireDate< '12/04/2019'

SELECT * FROM TWorkers

--3.3. Create SQL to delete a specific job that has associated work hours and materials assigned to it. 
--Include a select before and after the statement(s). 
SELECT * FROM TJobMaterials

DELETE  FROM TJobMaterials
WHERE intJobID = 6 

SELECT * FROM TJobMaterials

--4.1	Write a query to list all jobs that are in process. Include the Job ID and Description, 
--Customer ID and name, and the start date. Order by the Job ID. 
SELECT        Tj.intCustomerID, TC.strLastName, TC.strFirstName,TJ.dtmStartDate

FROM           TJobs TJ  JOIN TCustomers TC
               ON TJ.intCustomerID = TC.intCustomerID 
			   JOIN TStatuses AS TS
			   ON TJ.intStatusID = TS.intStatusID

WHERE		   strStatus = 'In Process'

ORDER BY       intJobID

--4.2	Write a query to list all complete jobs for a specific customer and the materials used on each job. 
--Include the quantity, unit cost, and total cost for each material on each job. 
--Order by Job ID and material ID. Note: Select a customer that has at least 3 complete jobs and at least 1 open job and 1 in process job. 
--At least one of the complete jobs should have multiple materials. If needed, go back to your inserts and add data. 

SELECT       TJ.intJobID
           , TM.strDescription
		   , TJM.intQuantity
		   , TM.monCost
			, (TJM.intQuantity * TM.monCost) AS TotalCost

FROM          TCustomers AS TC JOIN TJobs TJ
			  ON TC.intCustomerID = TJ.intCustomerID 
			  JOIN TJobMaterials TJM 
			  ON TJ.intJobID = TJM.intJobID 
			  JOIN TMaterials TM 
			  ON TJM.intMaterialID = TM.intMaterialID

WHERE          TC.intCustomerID = 1
             AND TJ.intStatusID = 3

GROUP BY       TJ.intJobID
			,  TM.intMaterialID 
			,  TM.strDescription
		   ,   TJM.intQuantity
		   ,   TM.monCost

ORDER BY       TJ.intJobID
		,      TM.intMaterialID 

			 
--4.3	 This step should use the same customer as in step 4.2. 
--Write a query to list the total cost for all materials for each completed job for the customer. 
--Use the data returned in step 4.2 to validate your results. 
SELECT        TJ.intJobID AS JobID
			 ,SUM(TJM.intQuantity * TM.monCost) AS TotalPrice

FROM          TCustomers AS TC JOIN TJobs TJ
			  ON TC.intCustomerID = TJ.intCustomerID 
			  JOIN TJobMaterials TJM 
			  ON TJ.intJobID = TJM.intJobID 
			  JOIN TMaterials TM 
			  ON TJM.intMaterialID = TM.intMaterialID

WHERE          TC.intCustomerID = 1
             AND TJ.intStatusID = 3
			 
GROUP BY     TJ.intJobID			

--4.4	 Write a query to list all jobs that have work entered for them. 
--Include the job ID, job description, and job status description. List the total hours worked for each job with the lowest, 
--highest, and average hourly rate. The average hourly rate should be weighted based on the number of hours worked at that rate. 
--Make sure that your data includes at least one job that does not have hours logged. This job should not be included in the query. 
--Order by highest to lowest average hourly rate. 
SELECT    Tj.intJobID
		, TJ.strJobDesc
		, TS.strStatus
		,SUM(TJW.intHoursWorked) AS TotalHoursWorked
		,MIN(TW.monHourlyRate * TJW.intHoursWorked) LowestHourlyRate
		,MAX(TW.monHourlyRate * TJW.intHoursWorked) HighestHourlyRate
		,AVG(TW.monHourlyRate * TJW.intHoursWorked) AverageHourlyRate

FROM      TJobs AS TJ  JOIN TJobWorkers AS TJW
          ON TJ.intJobID = TJW.intJobID
		  JOIN TWorkers AS TW
		  ON TW.intWorkerID = TJW.intWorkerID
		  JOIN TStatuses AS TS
		  ON TS.intStatusID= tJ.intStatusID

GROUP BY  Tj.intJobID
		, TJ.strJobDesc
		, TS.strStatus

ORDER BY  AVG(TW.monHourlyRate * TJW.intHoursWorked) DESC


--4.5	 Write a query that lists all materials that have not been used on any jobs. Include Material ID and Description. 
--Order by Material ID. 
SELECT		TM.intMaterialID, TM.strDescription
FROM		TMaterials AS TM
WHERE		TM.intMaterialID not in( SELECT        TM.intMaterialID

FROM         TJobs AS TJ  JOIN  TJobMaterials AS TJM 
			 ON TJ.intJobID = TJM.intJobID 
			 JOIN TMaterials TM ON TJM.intMaterialID = TM.intMaterialID
			
GROUP BY TM.intMaterialID)

			
--4.6	 Create a query that lists all workers with a specific skill, their hire date, and the total number of jobs that they worked on.
-- List the Skill ID and description with each row. Order by Worker ID. 
SELECT       (Tw.strFirstName +' '+TW.strLastName) AS Name
			 ,TW.dtmHireDate  AS HireDate
			 ,COUNT(TJW.intJobWorkerID) AS TotalJobs
			 ,TW.intWorkerID
			 ,TS.intSkillID AS SkillID
			 ,TS.strSkill AS Description
			 
FROM          TWorkers AS TW JOIN TWorkerSkills AS TWS
			  ON TWS.intWorkerID = TW.intWorkerID
              JOIN TSkills  AS TS
			  ON TWS.intSkillID = TS.intSkillID  
			  JOIN TJobWorkers TJW 
			  ON TW.intWorkerID = TJW.intWorkerID

GROUP BY TW.dtmHireDate, Tw.strFirstName,TW.strLastName,tw.intWorkerID,TS.strSkill, TS.intSkillID
HAVING   TS.intSkillID = 1
ORDER BY TW.intWorkerID
--4.7	 Create a query that lists all workers that worked greater than 20 hours for all jobs that they worked on. 
--Include the Worker ID and name, number of hours worked, and number of jobs that they worked on. Order by Worker ID. 
SELECT        TW.intWorkerID
			,(Tw.strFirstName +' '+TW.strLastName) AS Name
			 ,SUM(TJW.intHoursWorked) AS NumberOfHoursWorked
			 ,Count(TJ.intJobID) AS NumberOfJobs
FROM          TWorkers AS TW  JOIN TJobWorkers TJW 
			  ON TW.intWorkerID = TJW.intWorkerID
			  JOIN TJobs AS TJ
			  ON TJ.intJobID = TJW.intJobID
GROUP BY	  TW.intWorkerID
			 ,Tw.strFirstName
			 ,TW.strLastName

HAVING		  Sum(TJW.intHoursWorked)>20
ORDER BY	  TW.intWorkerID
--4.08 Write a query that lists all customers who are located on 'Main Street'. Include the customer Id and full address. 
--Order by Customer ID. Make sure that you have at least three customers on 'Main Street' each with different house numbers.
-- Make sure that you also have customers that are not on 'Main Street'. 
SELECT	TC.intCustomerID
	  ,(TC.strAddress+ ' '+TC.strCity+' '+TS.strState +' '+ TC.strZip) AS Address
FROM	TCustomers TC JOIN TStates AS TS
		ON TC.intStateID = TS.intStateID
WHERE	TC.strAddress like '%Main Street%'

--4.09 Write a query to list completed jobs that started and ended in the same month. 
--List Job, Job Status, Start Date and End Date. 
SELECT		TJ.intJobID
     ,		TS.strStatus AS JobStatus
		 ,  TJ.dtmStartDate AS StartDate
		 ,  TJ.dtmEndDate   AS EndDate
FROM	    TJobs AS TJ JOIN TStatuses  AS TS
			ON TJ.intStatusID= TS.intStatusID
WHERE  		MONTH(TJ.dtmEndDate) = MONTH(TJ.dtmStartDate)
      AND   TS.intStatusID = 3

--4.10 Create a query to list workers that worked on three or more jobs for the same customer.
SELECT     (TW.strFirstName+' '+ TW.strLastName) AS NAME
		,	TC.intCustomerID
		  , COUNT(TJ.intJobID) AS JOBS
FROM		TWorkers AS TW JOIN TJobWorkers AS TJW
            ON TJW.intWorkerID = TW.intWorkerID
		    JOIN TJobs AS TJ
		    ON TJ.intJobID = TJW.intJobID
			JOIN TCustomers AS TC
			ON TC.intCustomerID = TJ.intCustomerID

GROUP BY	TW.strFirstName,TW.strLastName
		,	TC.intCustomerID
HAVING		COUNT(TJ.intJobID) > 2

--4.11 Create a query to list all workers and their total # of skills. 
--Make sure that you have workers that have multiple skills and that you have at least 1 worker with no skills. 
--The worker with no skills should be included with a total number of skills = 0. Order by Worker ID. 
SELECT	    TW.intWorkerID
		  ,(TW.strFirstName +' '+ TW.strLastName) AS Name
		 , COUNT(TS.intSkillID) AS TOTAL_SKILLS
FROM       TWorkers AS TW LEFT JOIN TWorkerSkills AS TWS
           ON TWS.intWorkerID = TW.intWorkerID
           LEFT JOIN TSkills AS TS
		   ON TS.intSkillID = TWS.intSkillID
GROUP BY   TW.intWorkerID
          ,TW.strFirstName
		  ,TW.strLastName
ORDER BY COUNT(TS.intSkillID)

--4.12 Write a query to list the total Charge to the customer for each job. 
--Calculate the total charge to the customer as the total cost of materials + total Labor costs + 30% Profit. 


SELECT       (TC.strFirstName +' '+TC.strLastName) AS Name
			  ,TJ.intJobID
             ,( SUM(TJM.intQuantity * TM.monCost)
			 + SUM(TW.monHourlyRate * TJW.intHoursWorked)+ ( SUM(TJM.intQuantity * TM.monCost) 
             + SUM(TW.monHourlyRate * TJW.intHoursWorked) ) * 0.3 ) AS TotalCharge
			 
FROM           TCustomers AS TC  JOIN TJobs AS TJ 
			   ON TC.intCustomerID = TJ.intCustomerID 
			   JOIN TJobMaterials AS TJM 
			   ON TJ.intJobID = TJM.intJobID  
			   JOIN TJobWorkers AS TJW 
			   ON TJ.intJobID = TJW.intJobID 
			   JOIN TWorkers AS TW 
			   ON TJW.intWorkerID = TW.intWorkerID 
			   JOIN TMaterials AS TM
			   ON TJM.intMaterialID = TM.intMaterialID
GROUP BY TJ.intJobID, TC.strFirstName, TC.strLastName

--4.13 Write a query that totals what is owed to each vendor for a particular job. 
SELECT     TV.intVendorID
          ,SUM(TM.monCost * TJM.intQuantity) AS Total

FROM       TMaterials AS TM JOIN TVendors AS TV
           ON TM.intVendorID = TV.intVendorID
	       JOIN TJobMaterials AS TJM
	       ON TJM.intMaterialID = TM.intMaterialID

WHERE      TJM.intJobID = 1

GROUP BY TV.intVendorID
       
						