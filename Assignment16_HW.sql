-- --------------------------------------------------------------------------------
-- Name:  Habsatou War
-- Class: IT-111 
-- Abstract: Assignment 16
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE  dbSQL1;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
--						Problem #16
-- --------------------------------------------------------------------------------

-- Drop Table Statements

IF OBJECT_ID ('TOrderProducts')		IS NOT NULL DROP TABLE TOrderProducts
IF OBJECT_ID ('TOrders')			IS NOT NULL DROP TABLE TOrders
IF OBJECT_ID ('TCustomers')			IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TProducts')			IS NOT NULL DROP TABLE TProducts
IF OBJECT_ID ('TContacts')			IS NOT NULL DROP TABLE TContacts
IF OBJECT_ID ('TVendors')			IS NOT NULL DROP TABLE TVendors
IF OBJECT_ID ('TGenders')			IS NOT NULL DROP TABLE TGenders
IF OBJECT_ID ('TCities')			IS NOT NULL DROP TABLE TCities
IF OBJECT_ID ('TRaces')			    IS NOT NULL DROP TABLE TRaces
IF OBJECT_ID ('TStates')			IS NOT NULL DROP TABLE TStates
IF OBJECT_ID ('TEmails')			IS NOT NULL DROP TABLE TEmails
IF OBJECT_ID ('TStatus')			IS NOT NULL DROP TABLE TStatus
IF OBJECT_ID ('TPhones')			IS NOT NULL DROP TABLE TPhones
IF OBJECT_ID ('TCategories')	    IS NOT NULL DROP TABLE TCategories


-- --------------------------------------------------------------------------------
--	Step #1 : Create table 
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomers
(
	 intCustomerID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(255)	NOT NULL
	,strLastName			VARCHAR(255)	NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER      	NOT NULL
	,intStateID				INTEGER     	NOT NULL
	,strZip					VARCHAR(255)	NOT NULL
	,dtmDateOfBirth			DATETIME		NOT NULL
	,intRaceID				INTEGER    	    NOT NULL
	,intGenderID			INTEGER   	    NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
)

CREATE TABLE TOrders
(
	 intOrderID				INTEGER			NOT NULL
	,intCustomerID			INTEGER			NOT NULL
	,strOrderNumber			VARCHAR(255)	NOT NULL
	,intStatusID			INTEGER	NOT NULL
	,dtmOrderDate			DATETIME		NOT NULL
	,CONSTRAINT TOrders_PK PRIMARY KEY ( intOrderID )
)

CREATE TABLE TProducts
(
	 intProductID			INTEGER			NOT NULL
	,intVendorID			INTEGER			NOT NULL
	,strProductName			VARCHAR(255)	NOT NULL
	,monCostofProduct		MONEY			NOT NULL
	,monRetailCost			MONEY			NOT NULL
	,intCategoryID		    INTEGER    	NOT NULL
	,intInventory			INTEGER			NOT NULL
	,CONSTRAINT TProducts_PK PRIMARY KEY ( intProductID )
)

CREATE TABLE TVendors
(
	 intVendorID			INTEGER			NOT NULL
	,strVendorName			VARCHAR(255)	NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER 	NOT NULL
	,intStateID				INTEGER	NOT NULL
	,strZip					VARCHAR(255)	NOT NULL
	,CONSTRAINT TVendors_PK PRIMARY KEY ( intVendorID )
)

CREATE TABLE TOrderProducts
(
	 intOrderProductID		INTEGER			NOT NULL
	,intOrderID				INTEGER			NOT NULL
	,intProductID			INTEGER			NOT NULL
	,CONSTRAINT TTOrderProducts_PK PRIMARY KEY ( intOrderProductID )
)

CREATE TABLE TContacts
(
	 intContactID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(255)	NOT NULL
	,strLastName			VARCHAR(255)	NOT NULL
	,intPhoneID				INTEGER	NOT NULL
	,intEmailID				INTEGER	NOT NULL
	,intVendorID				INTEGER	NOT NULL
	
	,CONSTRAINT TContacts_PK PRIMARY KEY ( intContactID )
)

CREATE TABLE TGenders
(
	 intGenderID		INTEGER			NOT NULL
	,strGender			VARCHAR(255)	NOT NULL
	,CONSTRAINT TGenders_PK PRIMARY KEY ( intGenderID )
)

CREATE TABLE TCities
(
	 intCityID		INTEGER			NOT NULL
	,strCity			VARCHAR(255)	NOT NULL
	,CONSTRAINT TCities_PK PRIMARY KEY ( intCityID )
)

CREATE TABLE TRaces
(
	 intRaceID		INTEGER			NOT NULL
	,strRace			VARCHAR(255)	NOT NULL
	,CONSTRAINT TRaces_PK PRIMARY KEY ( intRaceID )
)

CREATE TABLE TStates
(
	 intStateID		INTEGER			NOT NULL
	,strState			VARCHAR(255)	NOT NULL
	,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID )
)

CREATE TABLE TEmails
(
	 intEmailID		INTEGER			NOT NULL
	,strEmail			VARCHAR(255)	NOT NULL
	,CONSTRAINT TEmails_PK PRIMARY KEY ( intEmailID )
)

CREATE TABLE TStatus
(
	 intStatusID		INTEGER			NOT NULL
	,strStatus			VARCHAR(255)	NOT NULL
	,CONSTRAINT TStatus_PK PRIMARY KEY ( intStatusID )
)

CREATE TABLE TPhones
(
	 intPhoneID		INTEGER			NOT NULL
	,strPhone			VARCHAR(255)	NOT NULL
	,CONSTRAINT TPhones_PK PRIMARY KEY ( intPhoneID )
)

CREATE TABLE TCategories
(
	 intCategoryID		INTEGER			NOT NULL
	,strCategory			VARCHAR(255)	NOT NULL
	,CONSTRAINT TCategories_PK PRIMARY KEY ( intCategoryID )
)

-- --------------------------------------------------------------------------------
--	Step #2 : Establish Referential Integrity 
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column
-- -	-----							------						---------
-- 1	TOrders							TCustomers					intCustomerID	
-- 2	TProducts						TVendors					intVendorID
-- 3	TOrderProducts					TOrders						intOrderID
-- 4	TOrderProducts					TProducts					intProductID
-- 5	TCustomers						TStates						intStateID
-- 6	TCustomers						TCities						intCityID
-- 7	TCustomers						TGenders					intGenderID
-- 8	TCustomers						TRaces						intRaceID
-- 9	TContacts						TPhones						intPhoneID
-- 10	TContacts						TEmails						intEmailID
-- 11	TContacts						TVendors					intVendorID
-- 12	TProducts						TCategories					intCategoryID
-- 13	TVendors						TCities					    intCityID
-- 14	TVendors						TStatus						intStateID
-- 15	TOrders							TStatus					    intStatusID	
--1
ALTER TABLE TOrders ADD CONSTRAINT TOrders_TCustomers_FK 
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )    ON DELETE CASCADE

--2
ALTER TABLE TProducts ADD CONSTRAINT TProducts_TVendors_FK 
FOREIGN KEY ( intVendorID ) REFERENCES TVendors ( intVendorID )          ON DELETE CASCADE

--3
ALTER TABLE TOrderProducts	 ADD CONSTRAINT TOrderProducts_TOrders_FK 
FOREIGN KEY ( intOrderID ) REFERENCES TOrders ( intOrderID )             ON DELETE CASCADE

--4
ALTER TABLE TOrderProducts	 ADD CONSTRAINT TOrderProducts_TProducts_FK 
FOREIGN KEY ( intProductID ) REFERENCES TProducts ( intProductID )       ON DELETE CASCADE

-- 5													
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TStates_FK 
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )             

-- 6												
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TCities_FK 
FOREIGN KEY ( intCityID ) REFERENCES TCities ( intCityID )               

-- 7											
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TGenders_FK 
FOREIGN KEY ( intGenderID ) REFERENCES TGenders ( intGenderID )           ON DELETE CASCADE

-- 8												
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TRaces_FK 
FOREIGN KEY ( intRaceID ) REFERENCES TRaces ( intRaceID )                 ON DELETE CASCADE

-- 9													
ALTER TABLE TContacts ADD CONSTRAINT TContacts_TPhones_FK 
FOREIGN KEY ( intPhoneID ) REFERENCES TPhones ( intPhoneID )               

-- 10													
ALTER TABLE TContacts ADD CONSTRAINT TContacts_TEmails_FK 
FOREIGN KEY ( intEmailID ) REFERENCES TEmails ( intEmailID )             

-- 11												
ALTER TABLE TContacts ADD CONSTRAINT TContacts_TVendors_FK 
FOREIGN KEY ( intVendorID ) REFERENCES TVendors ( intVendorID )          ON DELETE CASCADE

-- 12												
ALTER TABLE TProducts ADD CONSTRAINT TProducts_TCategories_FK 
FOREIGN KEY ( intCategoryID ) REFERENCES TCategories ( intCategoryID )   ON DELETE CASCADE

-- 13												    
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TCities_FK 
FOREIGN KEY ( intCityID ) REFERENCES TCities ( intCityID )               

-- 14													
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TStates_FK 
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )             

-- 15	TOrders												    	
ALTER TABLE TOrders ADD CONSTRAINT TOrders_TStatus_FK 
FOREIGN KEY ( intStatusID ) REFERENCES TStatus ( intStatusID )           ON DELETE CASCADE
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
				   ,(4, 'Milford')
				   ,(5, 'West Chester')

INSERT INTO TRaces( intRaceID, strRace)
VALUES				(1, 'Hispanic')
				   ,(2, 'African American')
				   ,(3, 'Cuacasion')
				   ,(4, 'Asian')

INSERT INTO TGenders( intGenderID, strGender)
VALUES				(1, 'Male')
				   ,(2, 'Female')
				   ,(3, 'Other')
INSERT INTO TStatus( intStatusID, strStatus)
VALUES				(1, 'Ordered')
				   ,(2, 'Shipped')
				   ,(3, 'Delivered')

INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, intCityID, intStateID, strZip, dtmDateOfBirth, intRaceID, intGenderID)
VALUES				  (1, 'James', 'Jones', '321 Elm St.', '1', '1', '45201', '1/1/1997', '1', '1')
					 ,(2, 'Sally', 'Smith', '987 Main St.', '3', '1', '45218', '12/1/1999', '2', '2')
					 ,(3, 'Jose', 'Hernandez', '1569 Windisch Rd.', '5', '1', '45069', '9/23/1998', '1', '1')
					 ,(4, 'Lan', 'Kim', '44561 Oak Ave.', '4', '1', '45246', '6/11/1999', '4', '1')

INSERT INTO TOrders ( intOrderID, intCustomerID, strOrderNumber, intStatusID, dtmOrderDate)
VALUES				 ( 1, 1, '10101010', '2', '8/28/2017')
					,( 2, 1, '20202020', '1', '8/28/2007')
					,( 3, 2, '30303030', '3', '6/28/2017')
					,( 4, 4, '40404040', '3', '5/28/2007')

INSERT INTO TVendors ( intVendorID, strVendorName, strAddress, intCityID, intStateID, strZip) 
VALUES                  ('1','TreesRUs','321 Elm St.','1','1','45201')
                       ,('2','ShirtRUs','987 Main St.', '3', '1', '45218')
					   ,('3','TreesRUs','1569 Windisch Rd.', '5', '1', '45069')

INSERT INTO TEmails(intEmailID, strEmail)
VALUES			           ( '1', 'Icleantooth@treesrus.com')
						  ,( '2',  'etotheright@shirtsrus.com')
						  ,( '3',  'mmetosing@toysrus.com')

INSERT INTO TPhones(intPhoneID, strPhone)
VALUES			           ( '1', '555-555-5555')
						  ,( '2', '666-666-6666')
						  ,( '3', '888-888-8888' )

INSERT INTO TContacts(intContactID, strFirstName, strLastName, intPhoneID, intEmailID,intVendorID)
VALUES			           ( '1','Iwana', 'Cleantooth', '1', '1','1')
						  ,( '2', 'Eilene', 'Totheright' , '2', '2','2')
						  ,( '3','Mike', 'Metosing', '3', '3','3')	
						  
INSERT INTO TCategories(intCategoryID, strCategory)
VALUES			           ( '1', 'Every Day')
						  ,( '2', 'Apparel')
						  ,( '3', 'Electronics' )

INSERT INTO TProducts( intProductID, intVendorID, strProductName, monCostofProduct, monRetailCost, intCategoryID, intInventory)
VALUES					   (1, 1,'Toothpicks', .10, .40, '1', 100000)
						  ,(2, 2,'T-Shirts', 5.10, 15.40, '2', 2000)
						  ,(3, 3,'uPlay', 44.10, 85.40, '3', 300)

INSERT INTO TOrderProducts ( intOrderProductID, intOrderID, intProductID)
VALUES				 ( 1, 1, 1 )
					,( 2, 1, 2 )
					,( 3, 2, 3 )
					,( 4, 3, 2 )
					,( 5, 3, 3 )
					,( 6, 4, 3 )

-- --------------------------------------------------------------------------------
--	Step #4 : SELECT INFORMATION with join
-- --------------------------------------------------------------------------------
-- 1  Show each customers name, order dates and products
---   based on custumer and order date

SELECT      TC.strFirstName, TC.strLastName, TOr.dtmOrderDate, TP.strProductName

FROM        TCustomers as TC   JOIN TOrders as TOr
            ON TC.intCustomerID = TOr.intCustomerID  
			
			JOIN TOrderProducts as TOrP
			ON TOr.intOrderID = TOrP.intOrderID  
			
			JOIN TProducts as TP 
			ON TOrP.intProductID = TP.intProductID

ORDER BY  TC.strLastName, TOr.dtmOrderDate

--2  Show products
--   Show and order vendor name , product category and retail price high to low

SELECT        TP.strProductName, TV.strVendorName, TC.strCategory, TP.monRetailCost
FROM           TProducts AS TP  JOIN TVendors as TV 
		       ON TP.intVendorID = TV.intVendorID  
			   
			   JOIN TCategories as TC 
			   ON TP.intCategoryID = TC.intCategoryID

ORDER BY       TC.strCategory,TP.monRetailCost DESC

--3  Show all products, inventory, vendors name, contact information for products
--   inventory less than 10
SELECT          TP.strProductName, TV.strVendorName, TC.strCategory, TP.intInventory, TCo.strFirstName as ContactFirstName, TCo.strLastName as ContactLastName

FROM            TProducts AS TP JOIN TVendors as TV 
                ON TP.intVendorID = TV.intVendorID 
				
				JOIN TCategories as TC 
				ON TP.intCategoryID = TC.intCategoryID  
				
				JOIN TContacts as TCo 
				ON TV.intVendorID = TCo.intVendorID

WHERE           TP.intInventory < 10

--4   Show all products, order number
--    by males older than 21
--    Order le list based on customer race

SELECT          TP.strProductName, TOr.strOrderNumber   --, Tr.strRace , TG.strGender , TC.dtmDateOfBirth

FROM            TProducts AS TP  JOIN TOrderProducts 
                ON TP.intProductID = TOrderProducts.intProductID  
				
				JOIN TOrders as TOr 
				ON TOrderProducts.intOrderID = TOr.intOrderID 
				
				JOIN TCustomers as TC
				ON  TOr.intCustomerID = TC.intCustomerID  

				JOIN TGenders as TG
				ON  TC.intGenderID = TG.intGenderID  

				JOIN TRaces as TR 
				ON  TC.intRaceID = TR.intRaceID
			
WHERE           TC.intGenderID = '1'
       AND      TC.dtmDateOfBirth > '01-01-1997'
ORDER BY        TR.strRace

--5  Show all vendors name, product name set by state
-- based on customer's state order by state

SELECT          TV.strVendorName , TP.strProductName, TS.strState  

FROM            TVendors  as TV JOIN TProducts as TP 
                ON TV.intVendorID = TP.intVendorID
				
				JOIN TOrderProducts as TOrP
				ON TOrP.intProductID = TP.intProductID
				
				JOIN TOrders as TOr 
                ON  TOrP.intOrderID = TOr.intOrderID 
				
				JOIN TCustomers as TC
				ON TC.intCustomerID = TOr.intCustomerID

				JOIN TStates as TS 
				ON  TC.intStateID = TS.intStateID 

ORDER BY        TS.strState