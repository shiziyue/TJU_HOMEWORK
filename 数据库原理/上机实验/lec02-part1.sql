-------------------------------------------
-- Lecture 02 - Relational Database Language
-------------------------------------------

-- Set operations

DROP TABLE R;
DROP TABLE S;

CREATE TABLE R (
    name		CHAR(30),
	address		VARCHAR(255),
    gender		CHAR(1),
    birthdate	CHAR(10),
    PRIMARY KEY (name)
);

CREATE TABLE S (
    name		CHAR(30),
	address		VARCHAR(255),
    gender		CHAR(1),
    birthdate	CHAR(10),
    PRIMARY KEY (name)
);

INSERT INTO R VALUES ('Carrie Fisher', '123 Maple St.', 'F', '1999-09-09');
INSERT INTO R VALUES ('Mark Hamill', '456 Oak Rd.', 'M', '1988-08-08');
INSERT INTO S VALUES ('Carrie Fisher', '123 Maple St.', 'F', '1999-09-09');
INSERT INTO S VALUES ('Harrison Ford', 'Beverly Hills', 'M', '1977-07-07');

SELECT * FROM R;

SELECT * FROM S;

(SELECT * FROM R) UNION (SELECT * FROM S);

(SELECT * FROM R) INTERSECT (SELECT * FROM S);

(SELECT * FROM R) EXCEPT (SELECT * FROM S);

-------------------------------------------
-- movies database
-------------------------------------------

DROP TABLE movies;

CREATE TABLE movies (
    title		CHAR(100),
	year		INT,
    length		INT,
    genre		CHAR(10),
    studioname	CHAR(30),
    producerc	INT,
    PRIMARY KEY (title, year)
);

INSERT INTO movies VALUES ('Star Wars', 1977, 124, 'sciFi', 'Fox', 12345);
INSERT INTO movies VALUES ('Galaxy Quest', 1999, 104, 'comedy', 'DreamWorks', 67890);
INSERT INTO movies VALUES ('Wayne''s World', 1992, 95, 'comedy', 'Paramount', 99999);


-- projection

SELECT title, year, length
FROM movies;

SELECT genre
FROM movies;

SELECT DISTINCT genre
FROM movies;

-- selection

SELECT *
FROM movies
WHERE length >= 100;

SELECT * FROM movies WHERE length >= 100 AND studioName='Fox';

-- Cartesian Product 

DROP TABLE R;
DROP TABLE S;

CREATE TABLE R (
    A		 INT,
	B		 INT
);

CREATE TABLE S (
    B		INT,
	C		INT,
    D		INT
);

INSERT INTO R VALUES (1, 2);
INSERT INTO R VALUES (3, 4);
INSERT INTO S VALUES (2, 5, 6);
INSERT INTO S VALUES (4, 7, 8);
INSERT INTO S VALUES (9, 10, 11);

SELECT * FROM R CROSS JOIN S;

SELECT * FROM R, S;

-- Natural Joins

SELECT * FROM R NATURAL JOIN S;

SELECT A, B, C, D FROM R NATURAL JOIN S;

DROP TABLE U;
DROP TABLE V;

CREATE TABLE U (
    A		 INT,
	B		 INT,
	C		 INT
);

CREATE TABLE V (
    B		INT,
	C		INT,
    D		INT
);

INSERT INTO U VALUES (1, 2, 3);
INSERT INTO U VALUES (6, 7, 8);
INSERT INTO U VALUES (9, 7, 8);
INSERT INTO V VALUES (2, 3, 4);
INSERT INTO V VALUES (2, 3, 5);
INSERT INTO V VALUES (7, 8, 10);

SELECT A, B, C, D FROM U NATURAL INNER JOIN V;

-- Theta-Joins

SELECT * FROM U INNER JOIN V ON A < D;

SELECT * 
FROM U, V
WHERE A < D;

SELECT * 
FROM U INNER JOIN V ON A < D
WHERE U.B <> V.B;

-- Combining Operations to Form Queries












SELECT title, year
FROM
((SELECT * FROM movies WHERE length >= 100) 
INTERSECT
(SELECT * FROM movies WHERE studioName='Fox')) AS foo;





SELECT title, year
FROM movies WHERE length >= 100 AND studioName='Fox';

-- Renaming

SELECT * FROM R CROSS JOIN (SELECT B AS X, C, D FROM S) AS SS;

SELECT A, R.B, S.B AS X, C, D FROM R CROSS JOIN S;


