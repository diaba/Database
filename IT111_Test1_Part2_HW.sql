-- --------------------------------------------------------------------------------
-- Name: Habsatou War
-- Class: IT111
-- Abstract: Test1Part2
-- First create a new database name it dbClinic
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbClinic;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
--						Problem #Test1Part2
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
--	Step #9 : Drop tables
-- --------------------------------------------------------------------------------
IF OBJECT_ID ('TVisits')		IS NOT NULL DROP TABLE TVisits
IF OBJECT_ID ('TVisitNurses')	IS NOT NULL DROP TABLE TVisitNurses
IF OBJECT_ID ('TNurses')		IS NOT NULL DROP TABLE TNurses
IF OBJECT_ID ('TDoctors')		IS NOT NULL DROP TABLE TDoctors
IF OBJECT_ID ('TPatients')		IS NOT NULL DROP TABLE TPatients
--------------------------------------------------------------------------------
--	Step #9 : Create table 
-- --------------------------------------------------------------------------------
CREATE TABLE TPatients
(
	 intPatientID		        INTEGER		NOT NULL
	,strFirstName		        VARCHAR(255)	NOT NULL
	,strLastName		        VARCHAR(255)	NOT NULL
	,strAddress			VARCHAR(255)	NOT NULL
	,strCity			VARCHAR(255)	NOT NULL
	,strState			VARCHAR(255)	NOT NULL
	,strZip				VARCHAR(255)	NOT NULL
	,dtmDateOfBirth		        DATETIME	NOT NULL
	,strSSS			        VARCHAR(255)	NOT NULL
	,strInsurance			VARCHAR(255)	NOT NULL
	,strContactPhone		VARCHAR(255)	NOT NULL
       ,strContactAddress		VARCHAR(255)	NOT NULL
	,strContactEmail		VARCHAR(255)	NOT NULL
	,strEmergencyPhone		VARCHAR(255)	NOT NULL
	,CONSTRAINT TPatients_PK PRIMARY KEY ( intPatientID )
)
CREATE TABLE TVisits
(
	 intVisitID		        INTEGER		 NOT NULL
	,dtmDateOfVisit	        DATETIME	 NOT NULL
	,strRaisonOfVisit		VARCHAR(255) NOT NULL
	,strDiagnostic  		VARCHAR(255) NOT NULL
	,dtmDateOfFollowUp      DATETIME	 NOT NULL
	,intPatientID           INTEGER      NOT NULL
	,intDoctorID		    INTEGER      NOT NULL
	,CONSTRAINT TVisits_PK PRIMARY KEY ( intVisitID )
)
CREATE TABLE TVisitNurses
(
	 intVisitNurseID            INTEGER		NOT NULL
	 ,intNurseID		        INTEGER		NOT NULL
	 ,intVisitID		        INTEGER		NOT NULL	
	,CONSTRAINT TVisitNurses_PK PRIMARY KEY ( intVisitNurseID )
)

CREATE TABLE TNurses
(
	 intNurseID		           INTEGER		NOT NULL
	,strFirstName              VARCHAR(255)	NOT NULL
	,strLastName               VARCHAR(255)	NOT NULL
	,strAddress			       VARCHAR(255)	NOT NULL
	,strCity			       VARCHAR(255)	NOT NULL
	,strState			       VARCHAR(255)	NOT NULL
	,strZip				       VARCHAR(255)	NOT NULL
	,dtmDateOfTermination      DATETIME	        NULL   -- Data termination and date of bord are
	,dtmDateOfBords	           DATETIME	        NULL   -- not null : Consider when the nurse or
	,CONSTRAINT TNurses_PK PRIMARY KEY ( intNurseID )  -- the doctor are not certified or not terminated
)
CREATE TABLE TDoctors
(
	 intDoctorID		        INTEGER		    NOT NULL
	,strFirstName		        VARCHAR(255)	NOT NULL
	,strLastName		        VARCHAR(255)	NOT NULL
	,strAddress		        	VARCHAR(255)	NOT NULL
	,strCity			        VARCHAR(255)	NOT NULL
	,strState			        VARCHAR(255)	NOT NULL
	,strZip				        VARCHAR(255)	NOT NULL
	,dtmDateOfTermination       DATETIME	        NULL
	,dtmDateOfBords	            DATETIME	        NULL
	,CONSTRAINT TDoctors_PK PRIMARY KEY ( intDoctorID )
)


-- --------------------------------------------------------------------------------
--	Step #11 : Establish Referential Integrity 
-- --------------------------------------------------------------------------------
--
-- #	Child					Parent						Column
-- -	-----					------						---------
-- 1	TVisits					TPatients					intPatientID	
-- 2	TVisits					TDoctors					intDoctorID
-- 3	TVisitNurses			TVisits				        intVisitID
-- 4	TVisitNurses			TNurses						intNurseID

--1
ALTER TABLE TVisits ADD CONSTRAINT TVisits_TPatients_FK 
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID ) ON DELETE CASCADE

--2
ALTER TABLE TVisits ADD CONSTRAINT TVisits_TDoctors_FK 
FOREIGN KEY ( intDoctorID ) REFERENCES TDoctors ( intDoctorID ) ON DELETE CASCADE

--3
ALTER TABLE TVisitNurses ADD CONSTRAINT TVisitNurses_TVisits_FK 
FOREIGN KEY ( intVisitID ) REFERENCES TVisits ( intVisitID ) ON DELETE CASCADE

--4
ALTER TABLE TVisitNurses  ADD CONSTRAINT TVisitNurses_TNurses_FK 
FOREIGN KEY ( intNurseID ) REFERENCES TNurses ( intNurseID ) ON DELETE CASCADE

--------------------------------------------------------------------------------
--	Step #12 : Add Sample Data - INSERTS
-- --------------------------------------------------------------------------------
INSERT INTO [dbo].[TDoctors]
           ([intDoctorID]
           ,[strFirstName]
           ,[strLastName]
           ,[strAddress]
           ,[strCity]
           ,[strState]
           ,[strZip]
           ,[dtmDateOfTermination]
           ,[dtmDateOfBords])
     VALUES
		    ('1','Fatou','Ba','101 Street','Cincinnati','OH','45043','','01/12/1919')
		   ,('2','Baba','Tandia','1101 Main','Cincinnati','OH','45043','','')
		   ,('3','Micheal','Jackson','1031 Richmond','Cincinnati','OH','45043','01/12/1999','01/02/2020')
		   ,('4','Diaba','War','1011 Street','Union','Kentucky','41091','','01/02/2010')
		   ,('5','Aly','Simon','1013 Kaolack','Cincinnati','OH','45043','','01/02/2015')
INSERT INTO [dbo].[TNurses]
           ([intNurseID]
           ,[strFirstName]
           ,[strLastName]
           ,[strAddress]
           ,[strCity]
           ,[strState]
           ,[strZip]
           ,[dtmDateOfTermination]
           ,[dtmDateOfBords])
     VALUES
		    ('1','Mike','Ronald','101 Street','Cincinnati','OH','45043','','01/12/1919')
		   ,('2','Donald','Boh','1101 Main','Cincinnati','OH','45043','','01/01/2020')
		   ,('3','Algor','Mendi','1031 Richmond','Cincinnati','OH','45043','','')
		   ,('4','Denis','Wade','1011 Street','Union','Kentucky','41091','','01/02/2010')
		   ,('5','Demba','Dia','1013 Gabo','Cincinnati','OH','45043','','01/02/2015')
INSERT INTO [dbo].[TPatients]
           ([intPatientID]
           ,[strFirstName]
           ,[strLastName]
           ,[strAddress]
           ,[strCity]
           ,[strState]
           ,[strZip]
		   ,[dtmDateOfBirth]
		   ,[strSSS]
		   ,[strInsurance]
		   ,[strContactPhone]
		   ,[strContactAddress]
		   ,[strContactEmail]
		   ,[strEmergencyPhone]
           )
     VALUES
		    ('1','Ramata','Ba','101 Street','Cincinnati','OH','45043','01/23/1980','123456789','Aflac','8594321234','1 street California','rba@gmail.com','8591231234')
		   ,('2','Jeff','Benett','13301 Line','Cleveland','OH','46443','05/12/1967','234567891','AmeriTrac','5131234567','42 Cleveland Clinic','jben@gmail.com','5131231234')
		   ,('3','Joe','Riben','10331 Richmond','Cincinnati','OH','45043','12/12/1980','01121999','Insuforall','859948776','1 gohome Street','joreb@gmail.com','859001234')
		   ,('4','Kappi','Parki','141 Clove','Union','Kentucky','41091','11/12/1987','98664524','Aflac','8764746765','56 Apatr','kapi@yahoo.com','988766878')
		   ,('5','Tab','Secol','313 Handy','Cincinnati','OH','45043','05/08/1990','01911998','AmeriTrac','886756454','566 Habboit','tsec@aoil.com','010292015')
INSERT INTO [dbo].[TVisits]
           ([intVisitID]
           ,[dtmDateOfVisit]
		   ,[strRaisonOfVisit]
           ,[strDiagnostic]
           ,[dtmDateOfFollowUp]
           ,[intPatientID]
           ,[intDoctorID])
     VALUES
           ('1','09/11/2019','Checkup','Letf hip','04/11/2020','2','1')
		  ,('2','1/1/2019','Accident','headache','04/11/2020','3','2')
		  ,('3','09/11/2019','Followup','Broken lep Right','04/11/2020','4','4')
	      ,('4','09/11/2019','Checkup','hip','04/11/2020','1','2')
	      ,('5','04/01/2020','Followup','Legature','04/1/2020','2','3')
	      ,('6','1/11/2020','Checkup','Heart attack','04/1/2020','5','5')
	      ,('7','1/1/2020','Accident','Brain mal fonction','03/11/2020','5','3')    
INSERT INTO [dbo].[TVisitNurses]
           ([intVisitNurseID]
           ,[intNurseID]
           ,[intVisitID])
     VALUES
            ('1','1','1')
		   ,('2','3','1')
		   ,('3','3','2')
		   ,('4','4','2')
		   ,('5','2','2')
		   ,('6','1','2')
		   ,('7','4','3')
		   ,('8','5','3')
		   ,('9','2','4')
		   ,('10','4','4')
		   ,('11','5','5')
		   ,('12','4','5')
		   ,('13','3','6')
		   ,('14','5','6')
		   ,('15','1','7')
		   ,('16','5','7')
		   ,('17','4','7')
		   ,('18','3','7')
-- --------------------------------------------------------------------------------
--	Step #13 : SELECT from Sample Data 
-- --------------------------------------------------------------------------------
-- a
SELECT * FROM TPatients

-- b
SELECT * FROM TPatients
WHERE TPatients.strZip = '45043'
-- c
SELECT TP.strFirstName , TP.strLastName
FROM TPatients TP, TVisits TV
WHERE TP.intPatientID = TV.intPatientID
AND TV.dtmDateOfVisit < '1/1/2020'
-- d
SELECT TP.strFirstName, TP.strLastName 
FROM TNurses TN, TVisitNurses TVN, TVisits TV, TPatients TP
WHERE TP.intPatientID = TV.intPatientID
AND TV.intVisitID = TVN.intVisitID
And TVN.intNurseID = TN.intNurseID
AND TN.strFirstName ='Donald' AND TN.strLastName ='Boh'
-- e
SELECT  TP.strFirstName, TP.strLastName 
FROM TDoctors TD, TVisits TV, TPatients TP
WHERE TD.intDoctorID = TV.intDoctorID
AND TV.intDoctorID = TD.intDoctorID
AND TV.intPatientID = TP.intPatientID
AND TD.strFirstName ='Micheal' AND TD.strLastName ='Jackson'
-- --------------------------------------------------------------------------------
--	Step #4 : UPDATE Sample Data 
-- --------------------------------------------------------------------------------
select * from TPatients where strFirstName = 'Joe'
-- a
UPDATE  TPatients
SET strEmergencyPhone ='8592002983'
WHERE strFirstName = 'Joe'

SELECT *
FROM TPatients 
WHERE strFirstName = 'Joe'

-- --------------------------------------------------------------------------------
--	Step #5 : DELETE Sample Data 
-- --------------------------------------------------------------------------------
-- a
select * from TVisits
where TVisits.intPatientID = 2

DELETE  FROM TVisits                  -- delete first visit of patient 2
WHERE intPatientID = 2 
and intVisitID = 1

select * from TVisits
where TVisits.intPatientID = 2