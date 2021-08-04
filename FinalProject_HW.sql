-- --------------------------------------------------------------------------------
-- Name:  
-- Class: IT-111 
-- Abstract: Final Project
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbFixinyerleaks ;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
--						Problem #Final Project
-- --------------------------------------------------------------------------------

-- Drop Table Statements
IF OBJECT_ID ('TMaterialJobs')		IS NOT NULL DROP TABLE TMaterialJobs
IF OBJECT_ID ('TMaterials')			IS NOT NULL DROP TABLE TMaterials
IF OBJECT_ID ('TMaterialTypes')		IS NOT NULL DROP TABLE TMaterialTypes
IF OBJECT_ID ('TVendors')			IS NOT NULL DROP TABLE TVendors
IF OBJECT_ID ('TWorkerJobs')		IS NOT NULL DROP TABLE TWorkerJobs
IF OBJECT_ID ('TSkills')			IS NOT NULL DROP TABLE TSkills
IF OBJECT_ID ('TWorkers')			IS NOT NULL DROP TABLE TWorkers
IF OBJECT_ID ('TJobs')			    IS NOT NULL DROP TABLE TJobs
IF OBJECT_ID ('TCustomers')	        IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TStates')			IS NOT NULL DROP TABLE TStates
IF OBJECT_ID ('TStatus')		    IS NOT NULL DROP TABLE TStatus
IF OBJECT_ID ('TCompanies')		    IS NOT NULL DROP TABLE TCompanies
IF OBJECT_ID ('TCities')		    IS NOT NULL DROP TABLE TCities


 
-- --------------------------------------------------------------------------------
--	Step #1 : Create table 
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomers
( intCustomerID			    INTEGER			NOT NULL 
	,strFirstName			VARCHAR(255)	NOT NULL
	,strLastName			VARCHAR(255)	NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER	        NOT NULL
	,intStateID				INTEGER			NOT NULL
	,strZip					VARCHAR(255)	NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
)

CREATE TABLE TStatus
(
	 intStatusID			INTEGER			NOT NULL
	,strStatus  			VARCHAR(255)	NOT NULL
	,CONSTRAINT TStatus_PK PRIMARY KEY ( intStatusID )
)

CREATE TABLE TStates
(
	 intStateID			    INTEGER			NOT NULL
	,strState			    VARCHAR(255)	NOT NULL
	,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID )
)

CREATE TABLE TCities
(
	 intCityID			    INTEGER			NOT NULL
	,strCity			    VARCHAR(255)	NOT NULL
	,CONSTRAINT TCities_PK PRIMARY KEY ( intCityID )
)
CREATE TABLE TMaterialJobs
(
	 intMaterialJobID	    INTEGER		    NOT NULL
    ,intMaterialID	        INTEGER		    NOT NULL
    ,intJobID	            INTEGER		    NOT NULL
	,intQuantity    	    INTEGER		    NOT NULL
	,CONSTRAINT TMaterialJobs_PK PRIMARY KEY ( intMaterialJobID )
)

CREATE TABLE TWorkers
(
	 intWorkerID		    INTEGER			NOT NULL
	,strFirstName			VARCHAR(255)	NOT NULL
	,strLastName			VARCHAR(255)	NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER			NOT NULL
	,intStateID				INTEGER			NOT NULL
	,strZip	                VARCHAR(255)    NOT NULL
    ,dtmHireDate            DateTime        NOT NULL
    ,mntHourlyRate          MONEY           NOT NULL
	,CONSTRAINT TWorkers_PK PRIMARY KEY ( intWorkerID )
)

CREATE TABLE TJobs
(
         intJobID			INTEGER			NOT NULL
	    ,strJobDescription	VARCHAR(2000)	NOT NULL
        ,intStatusID		INTEGER			NOT NULL
        ,dtmStartDate 	    DATETIME		NOT NULL
        ,dtmEndDate 	    DATETIME		NOT NULL
        ,intCustomerID		INTEGER			NOT NULL
       
	,CONSTRAINT TJobs_PK PRIMARY KEY ( intJobID )
)
CREATE TABLE TWorkerJobs
(
         intWorkerJobID		INTEGER			NOT NULL
        ,intWorkerID		INTEGER			NOT NULL
        ,intJobID			INTEGER			NOT NULL
        ,intNumberOfHours	INTEGER			NOT NULL
        
	,CONSTRAINT TWorkerJobs_PK PRIMARY KEY ( intWorkerJobID )
)

CREATE TABLE TSkills
(
         intSkillID		INTEGER			NOT NULL
        ,strSkill		VARCHAR(255)	NOT NULL
		,intWorkerID    INTEGER         NOT NULL

	,CONSTRAINT TSkills_PK PRIMARY KEY ( intSkillID )
)

CREATE TABLE TVendors	
(
	 intVendorID	        INTEGER			NOT NULL
    ,strFirstName			VARCHAR(255)	NOT NULL
	,strLastName			VARCHAR(255)	NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER			NOT NULL
	,intStateID				INTEGER			NOT NULL
	,strZip					VARCHAR(255)	NOT NULL
	,intCompanyID			INTEGER			NOT NULL
	,CONSTRAINT TVendors_PK PRIMARY KEY ( intVendorID )
)
CREATE TABLE TCompanies
(
	 intCompanyID			 INTEGER		NOT NULL
	,strCompany          	 VARCHAR(255)	NOT NULL
	,CONSTRAINT TCompanies_PK PRIMARY KEY ( intCompanyID )
)

CREATE TABLE TMaterials
(
	 intMaterialID			  INTEGER		NOT NULL
	,strName	              VARCHAR(255)	NOT NULL
	,strDescription	          VARCHAR(255)	NOT NULL
	,mntCost                  MONEY         NOT NULL
    ,intVendorID		      INTEGER		NOT NULL
    ,intMaterialTypeID  	  INTEGER		NOT NULL
	,CONSTRAINT TMaterials_PK PRIMARY KEY ( intMaterialID )
)

CREATE TABLE TMaterialTypes
(
	 intMaterialTypeID			    INTEGER			NOT NULL
	,strMaterialTypeDescription		VARCHAR(255)	NOT NULL
	,CONSTRAINT TMaterialTypes_PK PRIMARY KEY ( intMaterialTypeID )
)

-- --------------------------------------------------------------------------------
--	Step #2 : Establish Referential Integrity 
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column
-- -	-----							------						---------
-- 1	TMaterials						TVendors					intVendorID	
-- 2	TVendors						TStates					    intStateID
-- 3 	TWorkers					    TStates						intStateID
-- 4	TCustomers						TStates						intStateID
-- 5	TVendors						TCities						intCityID
-- 6	TWorkers						TCities						intCityID
-- 7	TCustomers						TCities						intCityID
-- 8	TJobs			   			    TCustomers				    intCustomerID
-- 9	TSkills						    TWorkers				    intWorkerID
-- 10	TWorkerJobs						TWorkers				    intWorkerID
-- 11	TWorkerJobs						TJobs  			            intJobID
-- 12	TMaterialJobs					TJobs  			            intJobID
-- 13	TMaterialJobs					TMaterials  			    intMaterialID
-- 14	TMaterials						TMaterialTypes			    intMaterialTypeID
-- 15	TVendors						TCompanies				    intCompanyID
-- 16	TJobs						    TStatus				        intStatusID

-- 1													    	
ALTER TABLE TMaterials ADD CONSTRAINT TMaterials_TVendors_FK 
FOREIGN KEY ( intVendorID ) REFERENCES TVendors ( intVendorID )
-- 2							    					    
ALTER TABLE TVendors ADD CONSTRAINT TTVendors_TStates_FK 
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )
-- 3 							    						
ALTER TABLE TWorkers ADD CONSTRAINT TWorkers_TStates_FK 
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )
-- 4													
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TStates_FK 
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )
-- 5													
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TCities_FK 
FOREIGN KEY ( intCityID ) REFERENCES TCities ( intCityID )
-- 6												
ALTER TABLE TWorkers ADD CONSTRAINT TWorkers_TCities_FK 
FOREIGN KEY ( intCityID ) REFERENCES TCities ( intCityID )
-- 7								            
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TCities_FK 
FOREIGN KEY ( intCityID ) REFERENCES TCities ( intCityID )
-- 8											
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TCustomers_FK 
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )
-- 9											
ALTER TABLE TSkills ADD CONSTRAINT TSkills_TWorkers_FK 
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )
-- 10								  			    
ALTER TABLE TWorkerJobs ADD CONSTRAINT TWorkerJobs_TWorkers_FK 
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )
-- 11								  			    
ALTER TABLE TWorkerJobs ADD CONSTRAINT TWorkerJobs_TJobs_FK 
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )
-- 12								  			        
ALTER TABLE TMaterialJobs ADD CONSTRAINT TMaterialJobs_TJobs_FK 
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )
-- 13										    
ALTER TABLE TMaterialJobs ADD CONSTRAINT TMaterialJobs_TMaterials_FK 
FOREIGN KEY ( intMaterialID ) REFERENCES TMaterials ( intMaterialID )
-- 14							    				        										    											        
ALTER TABLE TMaterials ADD CONSTRAINT TMaterials_TMaterialTypes_FK 
FOREIGN KEY ( intMaterialTypeID ) REFERENCES TMaterialTypes ( intMaterialTypeID )
-- 15											    										    
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TCompanies_FK 
FOREIGN KEY ( intCompanyID ) REFERENCES TCompanies ( intCompanyID )
-- 16											    										    
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TStatus_FK 
FOREIGN KEY ( intStatusID ) REFERENCES TStatus ( intStatusID )
-- --------------------------------------------------------------------------------
--	Step #3 : Add Data - INSERTS
-- --------------------------------------------------------------------------------
INSERT INTO TStates( intStateID, strState)
VALUES				(1, 'Ohio')
				   ,(2, 'Kentucky')
				   ,(3, 'Indiana')

                   
INSERT INTO TCities( intCityID, strCity)
VALUES				(1, 'Cincinnati')
				   ,(2, 'Florence')
				   ,(3, 'Norwood')
				   ,(4, 'Union')
				   ,(5, 'West Chester')

INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, intCityID, intStateID, strZip)
VALUES				  (1, 'James', 'Jones', '321 Elm St.', 1, 1, '45201')
					 ,(2, 'Sally', 'Smith', '37 Main Street', 2, 2, '41042')
					 ,(3, 'Jose', 'Hernandez', '1569 Windisch Rd', 5, 1, '45069')
					 ,(4, 'Samba', 'Sy', '987 Main Street', 5, 1, '45218')
					 ,(5, 'Ibou', 'Ly', '1569 Windisch Rd.', 2, 2, '41099')
					 ,(6, 'Sall', 'Sene', '22 Main Street', 3, 1, '45218')
					 ,(7, 'Baba', 'Mall', '1569 Windisch Rd.', 5, 1, '45069')
					
					 

INSERT INTO TWorkers( intWorkerID,strFirstName,strLastName,strAddress,intCityID,intStateID,strZip,dtmHireDate,mntHourlyRate)
VALUES				(1, 'Mike','Diop','123 Main St',5,1,'45042','1/3/2019',30)
				   ,(2, 'Joe','Ba','123 Oldview Dr',1,2,'41042','1/3/2020',50)
				   ,(3, 'Adama','Wade','5 Drive Ln',4,2,'41091','1/3/2006',15)	

INSERT INTO TSkills( intSkillID, strSkill, intWorkerID)
VALUES				(1, 'Hand and Arm Streght',1)
				   ,(2, 'Cleaning Sewer Lines',1)
				   ,(3, 'Installing Pipe Systems',3)
                   ,(4, 'Accessing Confined Spaces',3)
                   ,(5, 'Installing Appliances',3)
                   ,(6, 'Hand and Arm Streght',3)

INSERT INTO TStatus( intStatusID, strStatus)
VALUES				(1, 'Open')
				   ,(2, 'In Process')
				   ,(3, 'Complete')
INSERT INTO TMaterialTypes( intMaterialTypeID, strMaterialTypeDescription)
VALUES				(1, 'Steel')
				   ,(2, 'Aluminum')
				   ,(3, 'Rubber')
				   ,(4, 'Cast Iron')
				   ,(5, 'Polymers')
INSERT INTO TCompanies( intCompanyID, strCompany)
VALUES				(1, 'Mueller Industries')
				   ,(2, 'Everbilt')
				                  
INSERT INTO TVendors( intVendorID,strFirstName,strLastName,strAddress,intCityID,intStateID,strZip, intCompanyID)
VALUES				(1, 'Amado','Diop','123 Main St',5,1,'45042',1)
				   ,(2, 'Coumba','War','123 Oldview Dr',1,2,'41042',2)
				   ,(3, 'Salif','Ba','5 Drive Ln',4,2,'41091',1)	

                  
INSERT INTO TMaterials( intMaterialID,strName, strDescription,mntCost, intVendorID,intMaterialTypeID)
VALUES				(1, 'adapter','Male ends having threads outside',45,1,1)
				   ,(2, 'adapter','Female ends having threads inside',50,2,1)
                   ,(3, 'adapter','Female ends having threads inside',45,3,2)
				   ,(4, 'Nipple','It connects pipes to appliances or two straight pipe runs.',50,2,1)
                   ,(5, 'Nipple','It connects pipes to appliances or two straight pipe runs.',75,2,2)
				   ,(6, 'Barb','Used to grip the inside of a tube and seal the connection.',200,1,1)
INSERT INTO TJobs( intJobID, strJobDescription,intStatusID,dtmStartDate,dtmEndDate, intCustomerID)
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
				  
INSERT INTO TWorkerJobs( intWorkerJobID,intJobID, intWorkerID,intNumberOfHours)
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

INSERT INTO TMaterialJobs( intMaterialJobID, intJobID,intMaterialID,intQuantity)
VALUES				(1,1,1,4)
				   ,(2,1,2,3)
                   ,(3,1,3,2)
                   ,(4,2,2,3)
                   ,(5,2,3,2)
				   ,(6,3,3,2)
                   ,(7,5,3,3)
                   ,(8,6,3,2)
				   ,(9,6,1,2)
                   ,(10,6,5,3)
                   ,(11,6,6,2)
				   ,(12,5,6,3)
                   ,(13,7,2,2)
				   ,(14,7,1,3)
                   ,(15,8,2,2)
				   ,(16,9,1,2)
				   ,(17,9,3,3)
                   ,(18,9,5,2)
				   ,(19,10,5,2)
				   ,(20,11,6,3)
                   ,(21,12,3,2)

 -- --------------------------------------------------------------------------------
--	Step #4 : 	Update and Deletes 
-- --------------------------------------------------------------------------------
--3.1. Create SQL to update the address for a specific customer. 
--Include a select statement before and after the update. 
SELECT * FROM TCustomers
UPDATE TCustomers
SET strAddress= 'Main Street'
WHERE intCustomerID = 2
SELECT * FROM TCustomers
--3.2. Create SQL to increase the hourly rate by $2 for each worker 
--that has been an employee for at least 1 year. Include a select before and after the update.
SELECT * FROM TWorkers
UPDATE TWorkers
SET mntHourlyRate = mntHourlyRate + 2
WHERE dtmHireDate< '12/04/2019'
SELECT * FROM TWorkers
--3.3. Create SQL to delete a specific job that has associated work hours and materials assigned to it. 
--Include a select before and after the statement(s). 
SELECT * FROM TMaterialJobs
 
--DELETE FROM TJobs
--WHERE intJobID = 3


--4.1	Write a query to list all jobs that are in process. Include the Job ID and Description, 
--Customer ID and name, and the start date. Order by the Job ID. 
SELECT        dbo.TCustomers.intCustomerID, dbo.TCustomers.strLastName, dbo.TCustomers.strFirstName, dbo.TStatus.strStatus, dbo.TJobs.dtmStartDate
FROM            dbo.TJobs INNER JOIN
                         dbo.TCustomers ON dbo.TJobs.intCustomerID = dbo.TCustomers.intCustomerID INNER JOIN
                         dbo.TStatus ON dbo.TJobs.intStatusID = dbo.TStatus.intStatusID
						 WHERE strStatus = 'In Process'
						 Order by intJobID
--4.2	Write a query to list all complete jobs for a specific customer and the materials used on each job. 
--Include the quantity, unit cost, and total cost for each material on each job. 
--Order by Job ID and material ID. Note: Select a customer that has at least 3 complete jobs and at least 1 open job and 1 in process job. 
--At least one of the complete jobs should have multiple materials. If needed, go back to your inserts and add data. 

SELECT       TJ.intJobID, TM.strDescription
			, SUM(TMJ.intQuantity * TM.mntCost) AS Price
FROM          TCustomers AS TC JOIN TJobs TJ
			  ON TC.intCustomerID = TJ.intCustomerID 
			  JOIN TMaterialJobs TMJ 
			  ON TJ.intJobID = TMJ.intJobID 
			  JOIN TMaterials TM 
			  ON TMJ.intMaterialID = TM.intMaterialID
Where          TC.intCustomerID = 1
             AND TJ.intStatusID = 3
GROUP BY       TJ.intJobID
			,  TM.strDescription 
			 
--4.3	 This step should use the same customer as in step 4.2. 
--Write a query to list the total cost for all materials for each completed job for the customer. 
--Use the data returned in step 4.2 to validate your results. 
SELECT        TJ.intJobID AS JobID
			 ,SUM(TMJ.intQuantity * TM.mntCost) AS TotalPrice

FROM          TCustomers AS TC JOIN TJobs TJ
			  ON TC.intCustomerID = TJ.intCustomerID 
			  JOIN TMaterialJobs TMJ 
			  ON TJ.intJobID = TMJ.intJobID 
			  JOIN TMaterials TM 
			  ON TMJ.intMaterialID = TM.intMaterialID
Where          TC.intCustomerID = 1
             AND TJ.intStatusID = 3
			 
GROUP BY     TJ.intJobID			
--4.4	 Write a query to list all jobs that have work entered for them. 
--Include the job ID, job description, and job status description. List the total hours worked for each job with the lowest, 
--highest, and average hourly rate. The average hourly rate should be weighted based on the number of hours worked at that rate. 
--Make sure that your data includes at least one job that does not have hours logged. This job should not be included in the query. 
--Order by highest to lowest average hourly rate. 

--4.5	 Write a query that lists all materials that have not been used on any jobs. Include Material ID and Description. 
--Order by Material ID. 
SELECT TM.intMaterialID, TM.strDescription
FROM TMaterials AS TM
WHERE TM.intMaterialID not in( SELECT        TM.intMaterialID
			FROM            TJobs AS TJ  JOIN  TMaterialJobs AS TMJ 
			                ON TJ.intJobID = TMJ.intJobID 
							JOIN TMaterials TM ON TMJ.intMaterialID = TM.intMaterialID
			GROUP BY TM.intMaterialID)

--4.6	 Create a query that lists all workers with a specific skill, their hire date, and the total number of jobs that they worked on.
-- List the Skill ID and description with each row. Order by Worker ID. 
SELECT        (Tw.strFirstName +' '+TW.strLastName) AS Name
			 ,TW.dtmHireDate  AS HireDate
			 ,COUNT(TWJ.intWorkerJobID) AS TotalJobs
			 ,TW.intWorkerID,TS.strSkill AS Description
			 ,TS.intSkillID AS SkillID
FROM            TWorkers AS TW INNER JOIN TSkills  AS TS
				ON TW.intWorkerID = TS.intWorkerID  
				JOIN TWorkerJobs TWJ 
				ON TW.intWorkerID = TWJ.intWorkerID
GROUP BY TW.dtmHireDate, Tw.strFirstName,TW.strLastName,tw.intWorkerID,TS.strSkill, TS.intSkillID
HAVING   TS.strSkill ='Hand and Arm Streght'
ORDER BY TW.intWorkerID
--4.7	 Create a query that lists all workers that worked greater than 20 hours for all jobs that they worked on. 
--Include the Worker ID and name, number of hours worked, and number of jobs that they worked on. Order by Worker ID. 
SELECT        TW.intWorkerID
			,(Tw.strFirstName +' '+TW.strLastName) AS Name
			 ,Sum(TWJ.intNumberOfHours) AS HOURSWorked
			 , Count(TJ.intJobID) AS NumberOfJobs
FROM            TWorkers AS TW  JOIN TWorkerJobs TWJ 
				ON TW.intWorkerID = TWJ.intWorkerID
				JOIN TJobs AS TJ
				ON TJ.intJobID = TWJ.intJobID
GROUP BY tw.intWorkerID,Tw.strFirstName,TW.strLastName

HAVING   Sum(TWJ.intNumberOfHours)>20
ORDER BY TW.intWorkerID
--4.08 Write a query that lists all customers who are located on 'Main Street'. Include the customer Id and full address. 
--Order by Customer ID. Make sure that you have at least three customers on 'Main Street' each with different house numbers.
-- Make sure that you also have customers that are not on 'Main Street'. 
SELECT TC.intCustomerID
	  ,TC.strAddress
	  ,TCI.strCity
	  ,TS.strState
	  ,TC.strZip
FROM TCustomers TC JOIN TStates AS TS
     ON TC.intStateID = TS.intStateID
	 JOIN TCities AS TCI 
	 ON TC.intCityID = TCI.intCityID
WHERE strAddress like '%Main Street%'

--4.09 Write a query to list completed jobs that started and ended in the same month. 
--List Job, Job Status, Start Date and End Date. 
SELECT TJ.intJobID
     , TJ.dtmStartDate
	 ,TJ.dtmEndDate
	 , DateDiff(month,TJ.dtmEndDate, TJ.dtmStartDate) 
FROM TJobs AS TJ JOIN TStatus  AS TS
       ON TJ.intStatusID= TS.intStatusID
WHERE  DateDiff(month,TJ.dtmEndDate, TJ.dtmStartDate) = 0
--4.10 Create a query to list workers that worked on three or more jobs for the same customer.
SELECT (TW.strFirstName+' '+ TW.strLastName) AS NAME
		,	TC.intCustomerID
		, COUNT(TJ.intJobID) AS JOBS
FROM TWorkers AS TW JOIN TWorkerJobs AS TWJ
              ON TWJ.intWorkerID = TW.intWorkerID
			  JOIN TJobs AS TJ
			  ON TJ.intJobID = TWJ.intJobID
			JOIN TCustomers AS TC
			ON TC.intCustomerID = TJ.intCustomerID
GROUP BY  TW.strFirstName,TW.strLastName
		,	TC.intCustomerID
		, TJ.intJobID
SELECT   
			TC.intCustomerID,TW.intWorkerID
		, COUNT(TJ.intJobID) AS JOBS
FROM TWorkers AS TW JOIN TWorkerJobs AS TWJ
              ON TWJ.intWorkerID = TW.intWorkerID
			  JOIN TJobs AS TJ
			  ON TJ.intJobID = TWJ.intJobID
			JOIN TCustomers AS TC
			ON TC.intCustomerID = TJ.intCustomerID
GROUP BY  TJ.intJobID,
			TC.intCustomerID,TW.intWorkerID
		       
--4.11 Create a query to list all workers and their total # of skills. 
--Make sure that you have workers that have multiple skills and that you have at least 1 worker with no skills. 
--The worker with no skills should be included with a total number of skills = 0. Order by Worker ID. 
SELECT TW.intWorkerID
      ,(TW.strFirstName +' '+ TW.strLastName) AS Name
     , COUNT(TS.intSkillID) AS TOTAL_SKILLS
FROM TWorkers AS TW LEFT JOIN TSkills AS TS
      ON TS.intWorkerID = TW.intWorkerID
GROUP BY TW.intWorkerID
          ,TW.strFirstName
		  ,TW.strLastName
ORDER BY COUNT(TS.intSkillID)
--4.12 Write a query to list the total Charge to the customer for each job. 
--Calculate the total charge to the customer as the total cost of materials + total Labor costs + 30% Profit. 
Select (TC.strFirstName +' '+TC.strLastName) AS Name
     , TJ.intJobID
	 ,(SUM (TW.mntHourlyRate * TWJ.intNumberOfHours) 
	 + SUM(TM.mntCost*TMJ.intQuantity) 
	 + (SUM (TW.mntHourlyRate * TWJ.intNumberOfHours) + SUM(TM.mntCost*TMJ.intQuantity)) * 0.3 ) AS TotalCharge
from TJobs AS TJ JOIN TCustomers AS TC
     ON TJ.intCustomerID = TC.intCustomerID
	 JOIN TMaterialJobs AS TMJ
	 ON TMJ.intJobID = TJ.intJobID
	 JOIN TMaterials AS TM 
	 ON TM.intMaterialID=TMJ.intMaterialID
	 JOIN TWorkerJobs AS TWJ
	 ON TWJ.intJobID = TJ.intJobID
	 JOIN TWorkers AS TW
	 ON TW.intWorkerID = TWJ.intWorkerID
GROUP BY TJ.intJobID
        ,TC.strFirstName
		,TC.strLastName

--4.13 Write a query that totals what is owed to each vendor for a particular job. 
SELECT   TV.intVendorID
        ,Sum(TM.mntCost * TMJ.intQuantity) AS Total
FROM TMaterials AS TM JOIN TVendors AS TV
       ON TM.intVendorID = TV.intVendorID
	   JOIN TMaterialJobs AS TMJ
	   ON TMJ.intMaterialID = TM.intMaterialID
AND    TMJ.intJobID = 1
GROUP by TV.intVendorID