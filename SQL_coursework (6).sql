/*
Student name: Julie Bui          
Student ID: 220018065          
*/

/* SECTION 1 - CREATE TABLE STATEMENTS */

CREATE TABLE Competition (
	performance_ID INTEGER(10) PRIMARY KEY,
	performance_name VARCHAR(255),
	level VARCHAR(45),
	dance_style VARCHAR(45),
	date INTEGER(6),
	stage INTEGER(10));

CREATE TABLE Dance_team (
	dance_team_ID INTEGER PRIMARY KEY,
	team_name VARCHAR(45),
	no_dancers INTEGER(10),
	performance_ID INTEGER,
	FOREIGN KEY (performance_ID) REFERENCES Competition (performance_ID)); 

CREATE TABLE Dance_captain (
	dance_captain_ID INTEGER PRIMARY KEY,
	dance_captain_name VARCHAR(45),
	age INTEGER(10),
	city VARCHAR(45),
	dance_team_ID INTEGER,
	FOREIGN KEY (dance_team_ID) REFERENCES Dance_team (dance_team_ID));
/* FOREIGN KEY*/

CREATE TABLE Result (
  performance_ID INTEGER,
	team_rank INTEGER,
	score INTEGER,
	award VARCHAR(45),
	FOREIGN KEY (performance_ID) REFERENCES Competition (performance_ID),
	PRIMARY KEY (performance_ID));

/* SECTION 2 - INSERT STATEMENTS */

INSERT INTO Competition VALUES
	(101, "Starlight", "Beginners", "Hip-hop", 030125, 4),
	(102, "Into the Unknown", "Advanced", "Popping", 100125, 2),
	(103, "Fire", "Beginners", "Hip-hop", 030125, 1),
	(104, "Threads of Time", "Beginners", "Krumping", 120125, 3),
	(105, "Shadows", "Intermediate", "Street", 200125, 5),
	(106, "Joy", "Beginners", "Hip-hop", 150125, 5),
	(107, "Mystic Rhythms", "Advanced", "Locking", 200125, 1),
	(108, "Fired up", "Intermediate", "Breakdancing", 130125, 4),
	(109, "Grooves", "Intermediate", "Hip-hop", 030125, 3),
	(110, "Waves", "Beginners", "Hip-hop", 100125, 2),
	(111, "Feet unleashed", "Advanced", "House", 120125, 4),
	(112, "Urban vibes", "Intermediate", "Popping", 120125, 4),
	(113, "Street Swagger", "Beginners", "Street", 180125, 3),
	(114, "Street Kings and Queens", "Advanced", "Street", 140125, 1),
	(115, "Breaking boundaries", "Beginners", "Breakdancing", 070125, 5);

INSERT INTO Dance_Team VALUES
	(1001, "Flow dance", 8, 101),
	(1002, "Champions", 5, 102),
	(1003, "Grooves and Bounce", 15, 103),
	(1004, "Crowns", 12, 104),
	(1005, "Elementals", 20, 105),
	(1006, "Winners", 10, 106),
	(1007, "Tempest", 9, 107),
	(1008, "XO", 11, 108),
	(1009, "Purple Hearts", 10, 109),
	(1010, "Varsity", 20, 110),
	(1011, "Worldwide", 15, 111),
	(1012, "Dance Collective", 7, 112),
	(1013, "Synchronised Team", 12, 113),
	(1014, "Street Vibe Squad", 16, 114),
	(1015, "Breakers Crew", 5, 115);

INSERT INTO Dance_captain VALUES
	(1101, "Amber Wright", 21, "London", 1001),
	(1102, "Noah Stephens", 20, "Birmingham", 1002),
	(1103, "Olivia Smith", 21, "Leeds", 1003),
	(1104, "Amelia Evans", 22, "Liverpool", 1004),
	(1105, "Daisy Williams", 19, "London", 1005),
	(1106, "Sophia Jones", 20, "London", 1006),
	(1107, "Leo Taylor", 18, "Sheffield", 1007),
	(1108, "Theo Jones", 18, "London", 1008),
	(1109, "Lily Brown", 21, "Manchester", 1009),
	(1110, "Oliver Davies", 23, "Bristol", 1010),
	(1111, "Ava Smith", 25, "London", 1011),
	(1112, "Luca Wilson", 24, "Leeds", 1012),
	(1113, "Henry Thomas", 20, "Coventry", 1013),
	(1114, "Luna Smith", 19, "Nottingham", 1014),
	(1115, "Willow Murphy", 21, "Manchester", 1015);

INSERT INTO Result VALUES
	(101, 12, 71, "Certificate"),
	(102, 9, 79, "Medal"),
	(103, 5, 90, "Medal"),
	(104, 15, 63, "Certificate"),
	(105, 1, 98, "Trophy"),
	(106, 10, 77, "Medal"),
	(107, 11, 72, "Certificate"),
	(108, 8, 81, "Medal"),
	(109, 4, 91, "Medal"),
	(110, 13, 68, "Certificate"),
	(111, 2, 96, "Silver Trophy"),
	(112, 3, 95, "Bronze Trophy"),
	(113, 7, 84, "Medal"),
	(114, 14, 66, "Certificate"),
	(115, 6, 88, "Medal");
	

/* SECTION 3 - UPDATE STATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective statements */

/*
1) Change the award of the dance team 'Elementals' from 'Trophy' to 'Gold trophy'

*/

UPDATE Result
SET award = 'Gold Trophy'
WHERE performance_ID IN (
  SELECT performance_ID
  FROM Dance_team
  WHERE team_name = 'Elementals'
);

/*
2) Change the level of dance teams that have more than 20 dancers to 'Advanced'

*/

UPDATE Competition
SET level = 'Advanced'
WHERE performance_ID IN (
  SELECT performance_ID
  FROM dance_team
  WHERE no_dancers >= 20
);

/* SECTION 4 - SELECT STATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective SELECTs*/

/* 
1)  List the names of dance teams that have a rank over 90 in descending order

*/
select '1)' AS '';

SELECT tn.team_name, s.score
FROM Result s
INNER JOIN Dance_team tn
	ON s.performance_ID = tn.performance_ID
WHERE s.score IN (
	SELECT score
	FROM Result
	WHERE score >= 90)
ORDER BY s.score DESC;

/* 
2)  List the name, team_rank, score and award of the losing team in last place

*/
select '2)' AS ''; 

SELECT tn.team_name, s.team_rank, s.score, s.award
FROM Result s 
INNER JOIN Dance_team tn
	ON s.performance_ID = tn.performance_ID
WHERE s.score = (
	SELECT MAX(score)
	FROM Result);

/* 
3) List the names of dance captains that are from 'London' in ascending age
*/
select '3)' AS '';

SELECT d.dance_captain_name, d.age, d.city, tn.team_name
FROM Dance_team tn
INNER JOIN Dance_captain d
  ON tn.dance_team_ID = d.dance_team_ID
WHERE city LIKE "London"
AND city IS NOT NULL
ORDER BY age ASC;

/* 
4) List the dance teams that are competing in the dance style 'Hip-hop'

*/
select '4)' AS '';  

SELECT team_name
FROM Dance_team dt
WHERE EXISTS (SELECT *
  FROM Competition c 
  WHERE c.performance_ID = dt.performance_ID
  AND dance_style = 'Hip-hop');


/* 
5)  List the dance team that came fifth in the Competition with the team's dance captain

*/
select '5)' AS ''; 

SELECT dt.team_name, dc.dance_captain_name, r.team_rank
FROM Dance_captain dc
INNER JOIN Dance_team dt
ON dc.dance_team_ID = dt.dance_team_ID
INNER JOIN Result r
ON r.performance_ID = dt.performance_ID
WHERE team_rank = 5;

/* 
6)  List the dates that have more than one performance a day

*/
select '6)' AS ''; 

SELECT date, COUNT(date) AS date_count
FROM Competition 
GROUP BY date
HAVING COUNT(date) > 1;

/* 
7) List all teams who have over 10 dancers, or is competing at beginners level, or both 

*/
select '7)' AS ''; 

SELECT performance_name, level
FROM Competition c
INNER JOIN Dance_team dt
ON c.performance_ID = dt.performance_ID
WHERE no_dancers >= 10
UNION 
SELECT DISTINCT performance_name, level
FROM Competition
WHERE level = 'Beginners';

/* 
8) List the  performance name, team name, dance captain name, 
rank, score and award of the winning performance 
*/
select '8)' AS ''; 

SELECT c.performance_name, dt.team_name, dc.dance_captain_name, r.team_rank, r.score, r.award
FROM Dance_captain dc
INNER JOIN Dance_team dt
ON dc.dance_team_ID = dt.dance_team_ID
INNER JOIN Competition C
ON dt.performance_ID = c.performance_ID
INNER JOIN Result r
ON c.performance_ID = r.performance_ID
WHERE r.score = (
	SELECT MAX(score)
	FROM Result);




/* SECTION 5 - DELETE ROWS - The queries must be explained in natural (English) language first, and then followed up by respective statements */

/*
1) Delete the dance captains of dance teams with less than 5 dancers

*/
DELETE FROM Dance_captain
WHERE dance_team_ID IN (
  SELECT dance_team_ID
  FROM Dance_team
  WHERE no_dancers < 10
);

/*
2) Remove from 'Result' scores with less than 70

*/

DELETE FROM Result 
WHERE score < 70;

/* SECTION 6 - DROP TABLES */

DROP TABLE Result;
DROP TABLE Dance_captain;
DROP TABLE Dance_Team;
DROP TABLE Competition;

SHOW TABLES;