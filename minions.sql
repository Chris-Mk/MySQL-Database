CREATE SCHEMA minions;
USE minions;

CREATE TABLE Minions (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT
);

CREATE TABLE Towns (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

ALTER TABLE Minions ADD COLUMN town_id INT;
ALTER TABLE Minions ADD FOREIGN KEY (town_id) REFERENCES Towns(id);

-- DELETE FROM Minions WHERE id = 1;

INSERT INTO Towns (name) VALUE ("Sofia");
INSERT INTO Towns (name) VALUE ("Plovdiv");
INSERT INTO Towns (name) VALUE ("Varna");

INSERT INTO Minions (name, age, town_id) VALUES ("Kevin", 22, 1);
INSERT INTO Minions (name, age, town_id) VALUES ("Bob", 15, 3);
INSERT INTO Minions (name, age, town_id) VALUES ("Steward", 25, 2);

TRUNCATE TABLE Minions;
DROP TABLE Minions;
DROP TABLE Towns;







