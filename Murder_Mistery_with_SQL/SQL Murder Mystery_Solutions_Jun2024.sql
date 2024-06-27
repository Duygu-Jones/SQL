
-------------------SQL Murder Mystery----------------------------
---------------Can you find out whodunnit?-----------------------

/*
 *Walkthrough for SQL Beginners
If you're comfortable with SQL, you can skip these explanations and put your skills to the test! 
Below we introduce some basic SQL concepts, and just enough detail to solve the murder. 
If you'd like a more complete introduction to SQL, try Select Star SQL.
A crime has taken place and the detective needs your help. 
The detective gave you the crime scene report, but you somehow lost it. 
You vaguely remember that the crime was a murder that occurred sometime on Jan.15, 2018 
and that it took place in SQL City. 
Start by retrieving the corresponding crime scene report from the police department’s database.
All the clues to this mystery are buried in a huge database, 
and you need to use SQL to navigate through this vast network of information. 

*Your first step to solving the mystery is 
*to retrieve the corresponding crime scene report from the police department’s database.

Resource: https://mystery.knightlab.com/walkthrough.html 
 */


--1. Clue: 
-- murder that occurred sometime on Jan.15, 2018 
-- and that it took place in SQL City

-- Find Information about Witnesses in crime_scene_report table;
SELECT *
FROM crime_scene_report
WHERE type = 'murder'
AND city = 'SQL City'
AND date = 20180115;


  
--2. Clue: 
-- Security footage shows that there were 2 witnesses. 
-- 1st witness lives at the last house on "Northwestern Dr". 
-- 2nd witness, named Annabel, lives somewhere on "Franklin Ave".

-- Find details about the witnesses in person table; 
-- 1st Witness: 
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

-- 2nd Witness: 
SELECT *
FROM person
WHERE address_street_name = 'Franklin Ave'
AND LOWER(name) LIKE '%annabel%'



--3. Clue: 
-- Check the Witnesses with their person_id from the interview table
-- to get the information from the transcript;
SELECT *
FROM interview
WHERE person_id IN (14887,16371);



--4. Clue: 
-- "Get Fit Now Gym" bag started with "48Z" -> gym gold member
-- car with a plate that included "H42W"
-- Witness saw the guy at the gym last week on January the 9th

-- Using details from interview table find the killer;
SELECT 
	person.*,
  	gym_cin.*
FROM drivers_license AS license
INNER JOIN person ON license.id = person.license_id
INNER JOIN get_fit_now_member AS gym ON gym.person_id = person.id
INNER JOIN get_fit_now_check_in AS gym_cin ON gym_cin.membership_id = gym.id
WHERE plate_number LIKE '%H42W%'
AND membership_status ='gold'
AND check_in_date =20180109;


-- Check the solution;
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        
SELECT value FROM solution;

--Congrats, you found the murderer! 

--But wait, there's more!... 
--If you think you're up for a challenge, 
--try querying the interview transcript of the murderer 
--to find the real villain behind this crime. 

--5. Clue:
-- Check out the killer's interview transcript
SELECT *
FROM interview
WHERE person_id = 67318;

 

--6. Clue:
-- Murderer hired by a woman with a lot of money
-- she's around 5'5" (65") or 5'7" (67") height
-- red hair and she drives a Tesla Model S
-- she attended the SQL Symphony Concert 3 times in December 2017.

-- Use details to find the women who hired the Murderer;

-- Check out'drivers_license' table to find the car, height, hair color information
SELECT *
FROM drivers_license
WHERE hair_color ='red'
AND height BETWEEN 65 AND 67
AND gender = 'female'
AND car_make = 'Tesla'
AND car_model = 'Model S';


-- Check out 'facebook_event_checkin' table for concert and person_id etc.
SELECT 
	person_id,
	event_name,
	COUNT(*) times
FROM facebook_event_checkin
WHERE date BETWEEN 20171201 AND 20171231
AND event_name ='SQL Symphony Concert'
GROUP BY person_id
HAVING COUNT(*) >= 3;


-- Join the tables; person/facebook_event_checkin;
SELECT person.*, concert.*
FROM person 
INNER JOIN facebook_event_checkin AS concert ON concert.person_id = person.id
WHERE date BETWEEN 20171201 AND 20171231
AND event_name ='SQL Symphony Concert'
GROUP BY person_id
HAVING COUNT(*) >= 3

-- YOU ARE SO CLOSE!
-- One more step

-- You can use Common Table Expression (CTE) to find the information about concert
-- Then joined it to person table filtered by description given;
WITH CTE AS(
SELECT 
person_id,
event_name,
COUNT(*) times
FROM facebook_event_checkin
WHERE date BETWEEN 20171201 AND 20171231
AND event_name ='SQL Symphony Concert'
GROUP BY person_id
HAVING COUNT(*) >= 3
)

SELECT person.*, concert.*
FROM drivers_license as license
INNER JOIN person ON license.id = person.license_id
INNER JOIN CTE AS concert ON concert.person_id = person.id
WHERE hair_color ='red'
AND height BETWEEN 65 AND 67
AND gender = 'female'
AND car_make = 'Tesla'
AND car_model = 'Model S'

-- Check the solution;
INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
SELECT value FROM solution;









