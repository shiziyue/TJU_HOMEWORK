
DROP TABLE movies;
DROP TABLE movieexec;
DROP TABLE moviestar;
DROP TABLE starsin;
DROP TABLE studio;

CREATE TABLE movieexec (
    name		CHAR(30),
    address		VARCHAR(255),
    cert		INT		PRIMARY KEY,
    networth	INT
);

CREATE TABLE studio (
    name		CHAR(50)	PRIMARY KEY,
    address		VARCHAR(255),
    presc		INT,
    FOREIGN KEY (presc) REFERENCES movieexec(cert)
);

CREATE TABLE movies (
    title		CHAR(100),
	year		INT,
    length		INT,
    genre		CHAR(10),
    studioname	CHAR(30),
    producerc	INT,
    PRIMARY KEY (title, year),
    FOREIGN KEY (studioname) REFERENCES studio(name),
    FOREIGN KEY (producerc) REFERENCES movieexec(cert)
);

CREATE TABLE moviestar (
    name		CHAR(30),
	address		VARCHAR(255),
    gender		CHAR(1),
    birthdate	CHAR(10),
    PRIMARY KEY (name)
);

CREATE TABLE starsin (
    movietitle	CHAR(100),
    movieyear	INT,
    starname	CHAR(30),
	PRIMARY KEY (movietitle, movieyear, starname),
    FOREIGN KEY (movietitle, movieyear) REFERENCES movies(title, year),
    FOREIGN KEY (starname) REFERENCES moviestar(name)
);

INSERT INTO movieexec VALUES ('George Lucas', 'Oak Rd.', 555, 200000000);
INSERT INTO movieexec VALUES ('Ted Turner', 'Turner Av.', 333, 125000000);
INSERT INTO movieexec VALUES ('Stephen Spielberg', '123 ET road', 222, 100000000);
INSERT INTO movieexec VALUES ('Merv Griffin', 'Riot Rd.', 199, 112000000);
INSERT INTO movieexec VALUES ('Calvin Coolidge', 'Fast Lane', 123, 20000000);
INSERT INTO movieexec VALUES ('Garry Marshall', 'First Street', 999, 50000000);
INSERT INTO movieexec VALUES ('J.J. Abrams', 'High Road', 345, 45000000);
INSERT INTO movieexec VALUES ('Bryan Singer', 'Downtown', 456, 70000000);
INSERT INTO movieexec VALUES ('George Roy Hill', 'Baldwin Av.', 789, 20000000);
INSERT INTO movieexec VALUES ('Dino De Laurentiis', ' Beverly Hills', 666, 120000000);

INSERT INTO studio VALUES ('MGM','MGM Boulevard', 123);
INSERT INTO studio VALUES ('Fox', 'Hollywood', 555);
INSERT INTO studio VALUES ('Disney', 'Buena Vista', 999);
INSERT INTO studio VALUES ('Paramount', 'Hollywood', 345);
INSERT INTO studio VALUES ('Universal', 'Hollywood', 789);

INSERT INTO movies VALUES ('Logan''s run', 1976, NULL, 'sciFi', 'MGM', 123);
INSERT INTO movies VALUES ('Star Wars', 1977, 124, 'sciFi', 'Fox', 555);
INSERT INTO movies VALUES ('Empire Strikes Back', 1980, 111, 'fantasy', 'Fox', 555);
INSERT INTO movies VALUES ('Star Trek', 1979, 132, 'sciFi', 'Paramount', 345);
INSERT INTO movies VALUES ('Star Trek: Nemesis', 2002, 116, 'sciFi', 'Paramount', 345);
INSERT INTO movies VALUES ('Terms of Endearment', 1983, 132, 'romance', 'MGM', 123);
INSERT INTO movies VALUES ('The Usual Suspects', 1995, 106, 'crime', 'MGM', 456);
INSERT INTO movies VALUES ('Gone With the Wind', 1938, 238, 'drama', 'MGM', 123);
INSERT INTO movies VALUES ('Wayne''s World', 1992, 95, 'comedy', 'Paramount', 123);
INSERT INTO movies VALUES ('King Kong', 2005, 187, 'drama', 'Universal', 789);
INSERT INTO movies VALUES ('King Kong', 1976, 134, 'drama', 'Paramount', 666);
INSERT INTO movies VALUES ('King Kong', 1933, 100, 'drama', 'Universal', 345);
INSERT INTO movies VALUES ('Pretty Woman', 1990, 119, 'comedy', 'Disney', 999);

INSERT INTO moviestar VALUES ('Jane Fonda', 'Turner Av.', 'F', '1977-07-07');
INSERT INTO moviestar VALUES ('Alec Baldwin', 'Baldwin Av.', 'M', '1977-06-07');
INSERT INTO moviestar VALUES ('Kim Basinger', 'Baldwin Av.', 'F', '1979-05-07');
INSERT INTO moviestar VALUES ('Harrison Ford', 'Beverly Hills', 'M', '1977-07-07');
INSERT INTO moviestar VALUES ('Carrie Fisher', '123 Maple St.', 'F', '1999-09-09');
INSERT INTO moviestar VALUES ('Mark Hamill', '456 Oak Rd.', 'M', '1988-08-08');
INSERT INTO moviestar VALUES ('Debra Winger', 'A way', 'F', '1978-05-06');
INSERT INTO moviestar VALUES ('Jack Nicholson', 'X path', 'M', '1949-05-05');
INSERT INTO moviestar VALUES ('Kevin Spacey', 'New York Av.', 'F', '1937-12-21');

INSERT INTO starsin VALUES ('Star Wars', 1977, 'Carrie Fisher');
INSERT INTO starsin VALUES ('Star Wars', 1977, 'Mark Hamill');
INSERT INTO starsin VALUES ('Star Wars', 1977, 'Harrison Ford');
INSERT INTO starsin VALUES ('Empire Strikes Back', 1980, 'Harrison Ford');
INSERT INTO starsin VALUES ('The Usual Suspects', 1995, 'Kevin Spacey');
INSERT INTO starsin VALUES ('Terms of Endearment', 1983, 'Debra Winger');
INSERT INTO starsin VALUES ('Terms of Endearment', 1983, 'Jack Nicholson');


SELECT *
FROM movies
WHERE studioname='Disney' AND year=1990
ORDER BY length, title;
