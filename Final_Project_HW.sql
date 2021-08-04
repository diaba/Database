-- --------------------------------------------------------------------------------
-- Name: Habsatou War  
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
	,CONSTRAINT TCities_PK  PRIMARY KEY (  intCityID )
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
