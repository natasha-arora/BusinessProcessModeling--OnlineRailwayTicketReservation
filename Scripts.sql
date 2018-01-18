/* TABLE CREATION */


/* ############## CREATES TABLE USER_DETAILS ##############
EMAIL_ID: username of the user for login
FIRST_NAME: First name of the user
LAST_NAME: Last name of the user
GENDER: Gender of user
DOB: Date of Birth of user
CONTACT_NO: Primary cell number
PASSWRD: Password for logging in
WALLET_BALANCE: IRCTC Wallet balance

Table stores user information
*/
CREATE TABLE USER_DETAILS
        (EMAIL_ID VARCHAR2(30) PRIMARY KEY,
        FIRST_NAME VARCHAR2(20),
        LAST_NAME VARCHAR2(20)NOT NULL,
        GENDER VARCHAR2(15),
        DOB  DATE DEFAULT SYSDATE NOT NULL,
        CONTACT_NO VARCHAR2(10),
        PASSWRD VARCHAR(50) NOT NULL,
        WALLET_BALANCE NUMBER(10) NOT NULL);
        
/* ############## CREATES TABLE FARES ##############
TRAIN_TYPE: Type of train(EXPRESS or SUPERFAST)
FARE_CC: Fare of a chair car seat
FARE_AC: Fare of a Air conditioned car
FARE_SL: Fare of a Sleeper car

Table stores Fare per miles of journey for single passenger depending on chair car type and train type
*/
CREATE TABLE FARES
        (TRAIN_TYPE VARCHAR(30) PRIMARY KEY,
        FARE_CC NUMBER(10),
        FARE_AC NUMBER(10),
        FARE_SL NUMBER(10));
        
/* ############## CREATES TABLE STATIONS ##############
STATION_ID: Unique ID for each Railway station
STATION_NAME: Railway station name

Table stores station information
*/              
CREATE TABLE STATIONS
        (STATION_ID VARCHAR(20) PRIMARY KEY,
        STATION_NAME VARCHAR2(20));
        
/* ############## CREATES TABLE TRAINS ##############
TRAIN_ID: Unique ID for each train
TRAIN_NAME: Railway train name
TRAIN_TYPE: Type of train(EXPRESS or SUPERFAST)
SEATS_CC: Available seats in chair car
SEATS_AC: Available seats in Air conditioned car
SEATS_SL: Available seats in Sleeper car
SOURCE_STATION: Origin station ID of train
DESTINATION_STATION: Destination station ID of train

Table stores each Railway Train information
*/
CREATE TABLE TRAINS
        (TRAIN_ID VARCHAR2(20) PRIMARY KEY,
        TRAIN_NAME VARCHAR2(20) NOT NULL,
        TRAIN_TYPE VARCHAR2(20) CONSTRAINT TRAINS_TT_FK REFERENCES FARES(TRAIN_TYPE),
        SEATS_CC NUMBER(2) NOT NULL,
        SEATS_AC NUMBER(2) NOT NULL,
        SEATS_SL NUMBER(2) NOT NULL,
        SOURCE_STATION VARCHAR(20) NOT NULL,
        DESTINATION_STATION VARCHAR(20) NOT NULL);
        
/* ############## CREATES TABLE TRAIN_MAPS ##############
TRAIN_ID: Unique ID for each train
STATION_ID: Unique ID for each Railway station
STOP_NUMBER: Stop number of station for each train from source station  to destination station
SOURCE_DISTANCE: Distance of stop from origin location of train (relative distance)
ARRIVAL_TIME: Arrival time of train at station
DEPT_TIME: Departure time of train from station

Table store information of every train route
*/
CREATE TABLE TRAIN_ROUTE
        (TRAIN_ID VARCHAR2(20) CONSTRAINT TRAIN_ROUTE_TID_FK REFERENCES TRAINS(TRAIN_ID),
        STATION_ID VARCHAR2(20) CONSTRAINT TRAIN_ROUTE_STID_FK REFERENCES STATIONS(STATION_ID),
        STOP_NUMBER NUMBER(5) NOT NULL,
        SOURCE_DISTANCE NUMBER(10) NOT NULL,
        ARRIVAL_TIME VARCHAR(10) NOT NULL,
        DEPT_TIME VARCHAR(10) NOT NULL,
        CONSTRAINT TRAIN_ROUTE_PK PRIMARY KEY (TRAIN_ID,STATION_ID));
 
/* ############## CREATES TABLE TICKETS ##############
TICKET_NUMBER: Unique number for each ticket
EMAIL_ID: username of the user for login
TRAIN_ID: Unique ID for each train
TRAVEL_CLASS: Type of car in train(CC,AC and SL)
FARE: Fare of ticket
SOURCE_ID: Source station ID on ticket
DESTINATION_ID: Destination station ID on ticket

Table stores information of every ticket issued
*/       
CREATE TABLE TICKETS
        (TICKET_NUMBER VARCHAR2(10) PRIMARY KEY,
        EMAIL_ID VARCHAR2(20) NOT NULL CONSTRAINT TICKETS_EMAIL_FK REFERENCES USER_DETAILS(EMAIL_ID),
        TRAIN_ID VARCHAR2(20) NOT NULL CONSTRAINT TICKETS_TRAIN_FK REFERENCES TRAINS(TRAIN_ID)
        );

    
/* DATA INSERTION */

/* INSERTING DATA IN TABLE USER_DETAILS */
INSERT ALL
INTO USER_DETAILS VALUES('test1@uconn.edu','Fname1','Lname1','Male',(TO_DATE('01/01/1996', 'DD/MM/YYYY')),'9597772795','password1',4000)
INTO USER_DETAILS VALUES('test2@uconn.edu','Fname2','Lname2','Female',(TO_DATE('02/01/1996', 'DD/MM/YYYY')),'9597772789','password2',5000) 
INTO USER_DETAILS VALUES('test3@uconn.edu','Fname3','Lname3','Male',(TO_DATE('03/01/1996', 'DD/MM/YYYY')),'9597772800','password3',6000) 
INTO USER_DETAILS VALUES('test4@uconn.edu','Fname4','Lname4','Female',(TO_DATE('04/01/1996', 'DD/MM/YYYY')),'9597772803','password4',3500) 
INTO USER_DETAILS VALUES('test5@uconn.edu','Fname5','Lname5','Male',(TO_DATE('05/01/1996', 'DD/MM/YYYY')),'9597772806','password5',4500)
INTO USER_DETAILS VALUES('test6@uconn.edu','Fname6','Lname6','Male',(TO_DATE('06/01/1996', 'DD/MM/YYYY')),'9597772811','password6',3200)
INTO USER_DETAILS VALUES('test7@uconn.edu','Fname7','Lname7','Female',(TO_DATE('07/01/1996', 'DD/MM/YYYY')),'9597772817','password7',2800)
INTO USER_DETAILS VALUES('test8@uconn.edu','Fname8','Lname8','Male',(TO_DATE('05/02/1996', 'DD/MM/YYYY')),'9597772807','password8',1500) 
INTO USER_DETAILS VALUES('test9@uconn.edu','Fname9','Lname9','Female',(TO_DATE('06/02/1996', 'DD/MM/YYYY')),'9597772812','password9',8000) 
INTO USER_DETAILS VALUES('test0@uconn.edu','Fname0','Lname0','Male',(TO_DATE('07/02/1996', 'DD/MM/YYYY')),'9597772829','password0',5500)  
SELECT * FROM DUAL;

/* INSERTING DATA IN TABLE FARES */
INSERT ALL
INTO FARES VALUES ('EXPRESS',8,15,10)
INTO FARES VALUES ('SUPERFAST',12,29,14)
SELECT * FROM DUAL;

/* INSERTING DATA IN TABLE TRAINS */
INSERT ALL 
INTO TRAINS VALUES ('T1','TRAIN_1','EXPRESS',20,20,20,'ST1','ST4')
INTO TRAINS VALUES ('T2','TRAIN_2','SUPERFAST',20,20,20,'ST1','ST4')
INTO TRAINS VALUES ('T3','TRAIN_3','SUPERFAST',20,20,20,'ST4','ST1')
INTO TRAINS VALUES ('T4','TRAIN_4','EXPRESS',20,20,20,'ST4','ST1')
SELECT * FROM DUAL;

/* INSERTING DATA IN TABLE STATIONS */
INSERT ALL
INTO STATIONS VALUES ('ST1','STATION_1')
INTO STATIONS VALUES ('ST2','STATION_2')
INTO STATIONS VALUES ('ST3','STATION_3')
INTO STATIONS VALUES ('ST4','STATION_4')
SELECT * FROM DUAL;

/* INSERTING DATA IN TABLE TRAIN_MAPS */
INSERT ALL
INTO TRAIN_ROUTE VALUES ('T1','ST1',1,0,'09:00','09:10')
INTO TRAIN_ROUTE VALUES ('T1','ST2',2,120,'11:00','11:10')
INTO TRAIN_ROUTE VALUES ('T1','ST3',3,240,'13:00','13:10')
INTO TRAIN_ROUTE VALUES ('T1','ST4',4,360,'15:00','--:--')
INTO TRAIN_ROUTE VALUES ('T4','ST4',1,0,'17:00','17:10')
INTO TRAIN_ROUTE VALUES ('T4','ST3',2,120,'19:00','19:10')
INTO TRAIN_ROUTE VALUES ('T4','ST2',3,240,'21:00','21:10')
INTO TRAIN_ROUTE VALUES ('T4','ST1',4,360,'23:00','--:--')
INTO TRAIN_ROUTE VALUES ('T2','ST1',1,0,'11:00','11:10')
INTO TRAIN_ROUTE VALUES ('T2','ST4',2,360,'15:00','--:--')
INTO TRAIN_ROUTE VALUES ('T3','ST4',1,0,'23:00','23:10')
INTO TRAIN_ROUTE VALUES ('T3','ST1',2,360,'03:00','--:--')
SELECT * FROM DUAL;

/* INSERTING DATA IN TABLE TICKETS */
INSERT ALL 
INTO TICKETS VALUES ('1','test1@uconn.edu','T1')
INTO TICKETS VALUES ('2','test1@uconn.edu','T1')
INTO TICKETS VALUES ('3','test2@uconn.edu','T4')
INTO TICKETS VALUES ('4','test3@uconn.edu','T4')
INTO TICKETS VALUES ('5','test4@uconn.edu','T3')
INTO TICKETS VALUES ('6','test7@uconn.edu','T2')
SELECT * FROM DUAL;

