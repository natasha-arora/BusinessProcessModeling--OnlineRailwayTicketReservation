/* ############# SAMPLE INPUTS FOR FARE CALCULATION QUERY #############

OPTIONS FOR SUBSTITUTION VARIABLE 

Travel_Class: CC, SL and AC
Train_ID: T1, T2, T3 and T4
Source_ID: ST1, ST2, ST3 and ST4
Destination_ID: ST1, ST2, ST3 and ST4
 */
 
/* ############# TRAINS BETWEEN STATIONS #############
Will show trains running between source station and destination station.Substitution variables 
used are Source_ID and Destination_ID. The variables are good and valid because we need to find
trains between two stations. This is done by finding trains having stops at user's mentioned 
source and destination station. 
*/

SELECT T.TRAIN_ID Train_ID, 
       T.TRAIN_NAME Train_Name, 
       T.TRAIN_TYPE Train_Type, 
       T.SEATS_CC Availabilty_CC, 
       T.SEATS_AC Availability_AC,
       T.SEATS_SL Availability_SL, 
       T.SOURCE_STATION Starts_From,
       T.DESTINATION_STATION Ends_At
FROM (SELECT SRC.TRAIN_ID
FROM (SELECT TRAIN_ID, STOP_NUMBER FROM TRAIN_ROUTE WHERE STATION_ID = UPPER('&Source_ID')) SRC,
     (SELECT TRAIN_ID, STOP_NUMBER FROM TRAIN_ROUTE WHERE STATION_ID = UPPER('&Destination_ID')) DEST 
WHERE (SRC.TRAIN_ID = DEST.TRAIN_ID AND (DEST.STOP_NUMBER - SRC.STOP_NUMBER) > 0)) SUB,
TRAINS T
WHERE SUB.TRAIN_ID = T.TRAIN_ID;

/* ############# FARE CALCULATION #############
The query will take Train ID, Travel Class, Source station ID and Destination station ID as user's input to calculate fare.
Substitution variables used are Travel_Class, Train_ID, Source_ID  and Destination_ID. The variables are good and valid 
because we need to find fare based on distance between two stations, train and chair car type in which user wants to travel. 
This is done by extracting train route from TRAIN_MAPS table and fare information from FARE table.

NOTE: In case Source_ID and Destination_ID are same, fare will be calculated as 0. 
      Fare for invalid stations will also result in 0.
*/
DEFINE Travel_Class = "'&Travel_Class'"
DEFINE Train_ID = "'&TrainID'"
SELECT DISTANCE.DISTANCE*FARE.FARE FARE
FROM (SELECT CASE
    WHEN UPPER(&Travel_Class) = 'CC' THEN FARE_CC
    WHEN UPPER(&Travel_Class) = 'SL' THEN FARE_SL 
    ELSE FARE_AC END FARE
    FROM (SELECT * FROM FARES WHERE TRAIN_TYPE = (SELECT TRAIN_TYPE FROM TRAINS WHERE TRAIN_ID = UPPER(&Train_ID)))) FARE,
         (SELECT MAX(SOURCE_DISTANCE)-MIN(SOURCE_DISTANCE) AS DISTANCE
          FROM (SELECT * 
               FROM (SELECT * FROM TRAIN_ROUTE WHERE TRAIN_ID = UPPER(&Train_ID) ORDER BY STOP_NUMBER ASC)
               WHERE (STATION_ID = UPPER('&Source_ID') OR STATION_ID = UPPER('&Destination_ID')))) DISTANCE ;    
UNDEFINE Travel_Class
UNDEFINE Train_ID

/* ############# USER'S TICKET HISTORY #############
 Will display Ticket and User information using LEFT JOIN
*/
SELECT TICKETS.EMAIL_ID EMAIL_ID, 
       USER_DETAILS.FIRST_NAME FIRST_NAME, 
       USER_DETAILS.LAST_NAME LAST_NAME, 
       TICKETS.TICKET_NUMBER TICKET_NO,
       TICKETS.TRAIN_ID TRAIN_ID
FROM TICKETS
LEFT JOIN USER_DETAILS ON TICKETS.EMAIL_ID = USER_DETAILS.EMAIL_ID; 




