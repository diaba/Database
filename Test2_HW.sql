-- --------------------------------------------------------------------------------
-- Name:  
-- Class: IT-111 
-- Abstract: Test2
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbIndemnities4yallsjunk ;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
--						Problem #Test2
-- --------------------------------------------------------------------------------

-- Drop Table Statements
IF OBJECT_ID ('TClaims')			IS NOT NULL DROP TABLE TClaims
IF OBJECT_ID ('TPolicies')			IS NOT NULL DROP TABLE TPolicies
IF OBJECT_ID ('TCustomers')			IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TGenders')			IS NOT NULL DROP TABLE TGenders
IF OBJECT_ID ('TAgents')			IS NOT NULL DROP TABLE TAgents
IF OBJECT_ID ('TRiskAssesments')	IS NOT NULL DROP TABLE TRiskAssesments
IF OBJECT_ID ('TIncomeRanges')	    IS NOT NULL DROP TABLE TIncomeRanges
IF OBJECT_ID ('TMaritalStatus')		IS NOT NULL DROP TABLE TMaritalStatus
IF OBJECT_ID ('TCities')			IS NOT NULL DROP TABLE TCities
IF OBJECT_ID ('TStates')			IS NOT NULL DROP TABLE TStates
IF OBJECT_ID ('TPolicyTypes')		IS NOT NULL DROP TABLE TPolicyTypes
IF OBJECT_ID ('TClaimStatus')		IS NOT NULL DROP TABLE TClaimStatus
IF OBJECT_ID ('TClaimSpecialists')	IS NOT NULL DROP TABLE TClaimSpecialists
IF OBJECT_ID ('TRanks')			    IS NOT NULL DROP TABLE TRanks

 
-- --------------------------------------------------------------------------------
--	Step #1 : Create table 
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomers
(
	 intCustomerID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(255)	NOT NULL
	,strLastName			VARCHAR(255)	NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER			NOT NULL
	,intStateID				INTEGER			NOT NULL
	,strZip					VARCHAR(255)	NOT NULL
	,dtmDateOfBirth			    DATETIME		NOT NULL
	,intGenderID			    INTEGER			NOT NULL
    ,strSSNID				    VARCHAR(255)		NOT NULL	
    ,intMaritalStatusID		    INTEGER			NOT NULL
    ,intIncomeRangeID			INTEGER			NOT NULL
    ,intRiskAssesmentID			INTEGER			NOT NULL      
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
)

CREATE TABLE TCities
(
	 intCityID			INTEGER			NOT NULL
	,strCity			VARCHAR(255)	NOT NULL
	,CONSTRAINT TCities_PK PRIMARY KEY ( intCityID )
)

CREATE TABLE TStates
(
	 intStateID			INTEGER			NOT NULL
	,strState			VARCHAR(255)	NOT NULL
	,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID )
)

CREATE TABLE TRanks
(
	 intRankID			INTEGER			NOT NULL
	,strRank			VARCHAR(255)	NOT NULL
	,CONSTRAINT TRanks_PK PRIMARY KEY ( intRankID )
)

CREATE TABLE TGenders
(
	 intGenderID		INTEGER			NOT NULL
	,strGender			VARCHAR(255)	NOT NULL
	,CONSTRAINT TGenders_PK PRIMARY KEY ( intGenderID )
)

CREATE TABLE TClaims
(
         intClaimID				INTEGER			NOT NULL
	    ,dtmClaimDate			DATETIME		NOT NULL
        ,monClaimAmountID			MONEY			NOT NULL
	    ,strClaimRaison		VARCHAR(255)	NOT NULL
	    ,intClaimSpecialistID			INTEGER			NOT NULL
        ,intClaimStatusID			INTEGER			NOT NULL
        ,intPolicyID			INTEGER			NOT NULL
	
	,CONSTRAINT TClaims_PK PRIMARY KEY ( intClaimID )
)

CREATE TABLE TClaimStatus
(
	 intClaimStatusID			INTEGER			NOT NULL
	,strClaimStatus				VARCHAR(255)	NOT NULL
	,CONSTRAINT TClaimStatus_PK PRIMARY KEY ( intClaimStatusID )
)

CREATE TABLE TPolicies
(
	 intPolicyID			INTEGER			NOT NULL
	,intPolicyTypeID		INTEGER			NOT NULL
	,strPolicyNumber		VARCHAR(255)	NOT NULL
	,dtmPurchaseDate		DATETIME			NOT NULL
	,monPremium	            MONEY			NOT NULL
	,intCustomerID			INTEGER			NOT NULL
    ,intAgentID			    INTEGER			NOT NULL
	,CONSTRAINT TPolicies_PK PRIMARY KEY ( intPolicyID )
)

CREATE TABLE TAgents	
(
	 intAgentID	INTEGER			NOT NULL
    ,strFirstName			VARCHAR(255)	NOT NULL
	,strLastName			VARCHAR(255)	NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER			NOT NULL
	,intStateID				INTEGER			NOT NULL
	,strZip					VARCHAR(255)	NOT NULL
	,dtmHireDate			        DATETIME		NOT NULL
	,intGenderID			INTEGER			NOT NULL
	,intRankID		   INTEGER        	NOT NULL
	,CONSTRAINT TAgents_PK PRIMARY KEY ( intAgentID )
)

CREATE TABLE TRiskAssesments
(
	 intRiskAssesmentID			INTEGER			NOT NULL
	,strRiskAssesment			VARCHAR(255)	NOT NULL	
	,CONSTRAINT TVendors_PK PRIMARY KEY ( intRiskAssesmentID )
)

CREATE TABLE TIncomeRanges
(
	 intIncomeRangeID			INTEGER			NOT NULL
	,strIncomeRange			VARCHAR(255)	NOT NULL	
	,CONSTRAINT TRiskAssesments_PK PRIMARY KEY ( intIncomeRangeID )
)

CREATE TABLE TMaritalStatus
(
	 intMaritalStatusID			INTEGER			NOT NULL
	,strMaritalStatus			VARCHAR(255)	NOT NULL	
	,CONSTRAINT TMaritalStatus_PK PRIMARY KEY ( intMaritalStatusID )
)

CREATE TABLE TPolicyTypes
(
	 intPolicyTypeID			INTEGER			NOT NULL
	,strPolicyType			VARCHAR(255)	NOT NULL	
	,CONSTRAINT TPolicyTypes_PK PRIMARY KEY ( intPolicyTypeID )
)

CREATE TABLE TClaimSpecialists
(
	 intClaimSpecialistID			INTEGER			NOT NULL
	,strSpecialistFirstName			VARCHAR(255)	NOT NULL
	,strSpecialistLastName			VARCHAR(255)	NOT NULL
	,CONSTRAINT TClaimSpecialists_PK PRIMARY KEY ( intClaimSpecialistID )
)

-- --------------------------------------------------------------------------------
--	Step #2 : Establish Referential Integrity 
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column
-- -	-----							------						---------
-- 1	TAgents							TRanks					    intRankID	
-- 2	TAgents						    TStates					    intStateID
-- 3 	TAgents						    TCities						intCityID
-- 4	TCustomers						TStates						intStateID
-- 5	TCustomers						TCities						intCityID
-- 6	TCustomers						TGenders					intGenderID
-- 7	TCustomers						TMaritalStatus	            intMaritalStatusID
-- 8	TCustomers						TIncomeRanges				intIncomeRangeID
-- 9	TCustomers						TRiskAssesments				intRiskAssesmentID
-- 10	TClaims							TClaimStatus  			    intClaimStatusID
-- 11	TClaims							TClaimSpecialists  			intClaimSpecialistID
-- 12	TClaims							TPolicies  			        intPolicyID
-- 13	TPolicies						TPolicyTypes			    intPolicyTypeID
-- 14	TPolicies						TAgents				        intAgentID
-- 15	TPolicies						TCustomers				    intCustomerID

-- 1													    	
ALTER TABLE TAgents ADD CONSTRAINT TAgents_TRanks_FK 
FOREIGN KEY ( intRankID ) REFERENCES TRanks ( intRankID )
-- 2							    					    
ALTER TABLE TAgents ADD CONSTRAINT TAgents_TStates_FK 
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )
-- 3 							    						
ALTER TABLE TAgents ADD CONSTRAINT TAgents_TCities_FK 
FOREIGN KEY ( intCityID ) REFERENCES TCities ( intCityID )
-- 4													
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TStates_FK 
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )
-- 5													
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TCities_FK 
FOREIGN KEY ( intCityID ) REFERENCES TCities ( intCityID )
-- 6												
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TGenders_FK 
FOREIGN KEY ( intGenderID ) REFERENCES TGenders ( intGenderID )
-- 7								            
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TMaritalStatus_FK 
FOREIGN KEY ( intMaritalStatusID ) REFERENCES TMaritalStatus ( intMaritalStatusID )
-- 8											
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TIncomeRanges_FK 
FOREIGN KEY ( intIncomeRangeID ) REFERENCES TIncomeRanges ( intIncomeRangeID )
-- 9											
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TCustomers_FK 
FOREIGN KEY ( intRiskAssesmentID ) REFERENCES TRiskAssesments ( intRiskAssesmentID )
-- 10								  			    
ALTER TABLE TClaims ADD CONSTRAINT TClaims_TClaimStatus_FK 
FOREIGN KEY ( intClaimStatusID ) REFERENCES TClaimStatus ( intClaimStatusID )
-- 11								  			    
ALTER TABLE TClaims ADD CONSTRAINT TClaims_TClaimSpecialists_FK 
FOREIGN KEY ( intClaimSpecialistID ) REFERENCES TClaimSpecialists ( intClaimSpecialistID )
-- 12								  			        
ALTER TABLE TClaims ADD CONSTRAINT TClaims_TPolicies_FK 
FOREIGN KEY ( intPolicyID ) REFERENCES TPolicies ( intPolicyID )
-- 13										    
ALTER TABLE TPolicies ADD CONSTRAINT TPolicies_TPolicyTypes_FK 
FOREIGN KEY ( intPolicyTypeID ) REFERENCES TPolicyTypes ( intPolicyTypeID )
-- 14											    											        
ALTER TABLE TPolicies ADD CONSTRAINT TPolicies_TAgents_FK 
FOREIGN KEY ( intAgentID ) REFERENCES TAgents ( intAgentID )
-- 15											    										    
ALTER TABLE TPolicies ADD CONSTRAINT TPolicies_TCustomers_FK 
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )
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
INSERT INTO TGenders( intGenderID, strGender)
VALUES				(1, 'Male')
				   ,(2, 'Female')
				   ,(3, 'Other')
INSERT INTO TPolicyTypes( intPolicyTypeID, strPolicyType)
VALUES				(1, 'Auto')
				   ,(2, 'Boat')
				   ,(3, 'Motorcycle')
				   ,(4, 'Home')
				   ,(5, 'Renters')
INSERT INTO TIncomeRanges( intIncomeRangeID, strIncomeRange)
VALUES				(1, '0 - $25000')
				   ,(2, '$25001 - $50000')
				   ,(3, '$50001 - $100000')
				   ,(4, 'Above $100000')
INSERT INTO TRiskAssesments( intRiskAssesmentID, strRiskAssesment)
VALUES				(1, 'low')
				   ,(2, 'Average')
				   ,(3, 'High')
INSERT INTO TMaritalStatus( intMaritalStatusID, strMaritalStatus)
VALUES				(1, 'Single')
				   ,(2, 'Married')
				   ,(3, 'Divorced')
				   ,(4, 'Widowed')
INSERT INTO TRanks( intRankID, strRank)
VALUES				(1, 'Junior Sales Agent')
				   ,(2, 'Sale Agent')
				   ,(3, 'Senior Sales Agent')				   
INSERT INTO TClaimStatus( intClaimStatusID, strClaimStatus)
VALUES				(1, 'Submitted')
				   ,(2, 'In process')
				   ,(3, 'Paid')
				   ,(4, 'Rejected')				
INSERT INTO TClaimSpecialists( intClaimSpecialistID, strSpecialistFirstName,strSpecialistLastName)
VALUES				(1, 'Mike','Jordan')
				   ,(2, 'Dean','Legrand')
				   ,(3, 'Bell','Ndiaye')			
INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, intCityID, intStateID, strZip, dtmDateOfBirth, strSSNID ,intGenderID, intIncomeRangeID,intMaritalStatusID,intRiskAssesmentID)
VALUES				  (1, 'James', 'Jones', '321 Elm St.', 1, 1, '45201', '1/1/1997','123-01-1234', 1, 1,2,3)
					 ,(2, 'Sally', 'Smith', '987 Main St.', 3, 1, '45218', '12/1/1999','243-51-2434', 2, 3,1,3)
					 ,(3, 'Jose', 'Hernandez', '1569 Windisch Rd.', 5, 1, '45069', '9/23/1998','563-01-7734', 1, 1,2,2)
					 ,(4, 'Lan', 'Kim', '67 Shenendoah Dr', 2, 2, '41042', '6/11/1995','123-54-6234', 1, 1,3,3)
					 ,(5, 'Bob', 'Nields', '44561 Oak Ave.', 4, 1, '45246', '6/11/1999','263-71-9934', 1, 4,4,2)
					 ,(6, 'War', 'Habsa', '44561 Oak Ave.', 4, 1, '45246', '12/1/1989','432-71-9934', 2, 4,2,2)
INSERT INTO TAgents( intAgentID,strFirstName,strLastName,intGenderID,intRankID,strAddress,intCityID,intStateID,strZip,dtmHireDate)
VALUES				(1, 'Mike','Diop',1,1,'123 Main St',5,1,'45042','1/3/2019')
				   ,(2, 'Joe','Ba',1,2,'123 Oldview Dr',1,2,'41042','1/3/2014')
				   ,(3, 'Adama','Wade',1,3,'5 Drive Ln',4,2,'41091','1/3/2006')	
INSERT INTO TPolicies( intPolicyID, intCustomerID,intPolicyTypeID,intAgentID,monPremium,dtmPurchaseDate,strPolicyNumber)
VALUES				 (1,1,2,1,500,'2/4/2019','PL12345')
				    ,(2,2,2,2,'250','1/4/2019','PL12346')
					,(3,3,3,3,'500','4/4/2019','PL12365')
					,(4,4,1,1,'300','7/4/2019','PL12385')
					,(5,4,4,2,'600','3/5/2019','PL12335')	
					,(6,6,1,1,'600','3/3/2005','PL12435')	
INSERT INTO TClaims( intClaimID,intClaimSpecialistID,intPolicyID,intClaimStatusID,strClaimRaison,dtmClaimDate,monClaimAmountID)
VALUES				
                    (1,1,1,1,'Accident','2/3/2019',500)
				   ,(2,2,2,2,'Fire','3/5/2020',1000)
				   ,(3,3,3,3,'Accident','4/3/2019',2000)
				   ,(4,1,5,4,'Lost','4/3/2020',6000)
				   ,(5,2,6,4,'Lost','5/3/2020',10000)

 -- --------------------------------------------------------------------------------
--	Step #4 : SELECT STATEMENTS - Explicit SQL SELECT
-- --------------------------------------------------------------------------------
--a List all customers and their policies they own 
SELECT        TC.strFirstName, TC.strLastName, TP.strPolicyNumber, TP.monPremium
FROM          TCustomers AS TC INNER JOIN  TPolicies AS TP 
              ON TC.intCustomerID = TP.intCustomerID

--b List all customers who are high risk that have a claim in process. Show policy and the date of the claim
SELECT        TC.strFirstName, TC.strLastName, TP.strPolicyNumber, TP.monPremium, TCS.strClaimStatus, TCl.dtmClaimDate, TP.dtmPurchaseDate, TR.strRiskAssesment
FROM          TCustomers AS TC INNER JOIN TPolicies AS TP 
              ON TC.intCustomerID = TP.intCustomerID 
			  
			  INNER JOIN TClaims TCl 
			  ON TP.intPolicyID = TCl.intPolicyID 
			  
			  INNER JOIN TClaimStatus TCS
			  ON TCl.intClaimStatusID = TCS.intClaimStatusID 
			  
			  INNER JOIN .TRiskAssesments as TR
			  ON TC.intRiskAssesmentID = TR.intRiskAssesmentID
	AND       
	          TCS.intClaimStatusID = 2
    AND
	          TR.intRiskAssesmentID = 3

--c Show all customers who are female and married that have had a claim against their auto insurance policy
SELECT        TC.strFirstName, TC.strLastName,TG.strGender, TM.strMaritalStatus ,TPT.strPolicyType, TCl.strClaimRaison
FROM          TCustomers AS TC INNER JOIN TPolicies AS TP 
              ON TC.intCustomerID = TP.intCustomerID 
			  
			  JOIN TGenders as TG
			  ON TG.intGenderID = TC.intGenderID

			  JOIN TMaritalStatus as TM
			  ON TM.intMaritalStatusID = TC.intMaritalStatusID

			  INNER JOIN TClaims TCl 
			  ON TP.intPolicyID = TCl.intPolicyID 

			  INNER JOIN TPolicyTypes TPT 
			  ON TP.intPolicyTypeID = TPT.intPolicyTypeID 
			  
			  INNER JOIN TClaimStatus TCS
			  ON TCl.intClaimStatusID = TCS.intClaimStatusID 
	AND       
	          TG.intGenderID = 2
    AND
	          TM.intMaritalStatusID = 2
    AND
              TP.intPolicyTypeID = 1

--d Show all Junior Sales Agents policies they sold during a particular month. Show agent name, customer,
--policy and cost of policy
SELECT        TC.strFirstName, TC.strLastName, TA.strFirstName, TA.strLastName, TP.monPremium, TR.strRank ,TP.dtmPurchaseDate
FROM          TCustomers AS TC INNER JOIN TPolicies AS TP 
              ON TC.intCustomerID = TP.intCustomerID 
			  
			  INNER JOIN TAgents as TA
			  ON TP.intAgentID = TA.intAgentID 
			  
			  INNER JOIN TRanks as TR
			  ON TA.intRankID = TR.intRankID
AND  
              TR.intRankID = 1
AND
              Datename(MONTH,TP.dtmPurchaseDate) = 'July'

--e   Show all claim specialists that have rejected a claim on a policy for customers who are male and under 21 years of age.  
--         Provide the first name of the specialist, the date of the claim, the policy number, the policy date, the policy type, and
--         the customer for any claims that have been rejected. 

SELECT        TA.strFirstName AS Specialist, TCl.dtmClaimDate, TP.strPolicyNumber, TP.dtmPurchaseDate, TPT.strPolicyType, TC.strFirstName, TC.strLastName, TCl.strClaimRaison, TCST.strClaimStatus , TG.strGender, TC.dtmDateOfBirth
                           
FROM          TClaimSpecialists TCS    JOIN     TClaims as TCl
              ON TCl.intClaimSpecialistID = TCS.intClaimSpecialistID 
              
			  JOIN TClaimStatus TCST 
			  ON TCST.intClaimStatusID = TCl.intClaimStatusID 
			   
			  JOIN TPolicies AS TP 
			  ON TP.intPolicyID = TCl.intPolicyID 

			  JOIN TPolicyTypes AS TPT 
			  ON TPT.intPolicyTypeID = TP.intPolicyTypeID 

			  JOIN TCustomers AS TC 
              ON TC.intCustomerID = TP.intCustomerID
              
			  JOIN TGenders TG 
			  ON TC.intGenderID = TG.intGenderID 
		      
			  INNER JOIN TAgents AS TA 
			  ON TP.intAgentID = TA.intAgentID
			  AND
			  TCST.intClaimStatusID = 4
			  AND 
			  TG.intGenderID = 1
			  AND 
			  TC.dtmDateOfBirth <'1/1/1997'

				  
			 