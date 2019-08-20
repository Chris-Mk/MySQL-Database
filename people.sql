CREATE TABLE people (
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB(2048),
    height FLOAT,
    weight FLOAT,
    gender ENUM("m", "f") NOT NULL,
    birthdate DATE,
	biography TEXT
);

INSERT INTO people (name, picture, height, weight, gender, birthdate, biography) 
VALUES ("Kelvin", NULL, 120.23, 70.40, "m", "2000-12-12", "I love science");

INSERT INTO people (name, picture, height, weight, gender, birthdate, biography) 
VALUES ("Jane", NULL, 180.31, 60.75, "f", "1996-04-11", "I love programming");

INSERT INTO people (name, picture, height, weight, gender, birthdate, biography) 
VALUES ("Dimi", NULL, 188.20, 74.50, "f", "2019-01-23", NULL);

INSERT INTO people (name, picture, height, weight, gender, birthdate, biography) 
VALUES ("Krasi", NULL, 173.50, 90.00, "m", "1971-03-05", "I love fishing");

INSERT INTO people (name, picture, height, weight, gender, birthdate, biography) 
VALUES ("Mitko", NULL, 180.10, 88.80, "m", "1954-08-21", "I love beer");


CREATE TABLE users (
	id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture MEDIUMBLOB,
    last_login_time TIME,
    is_deleted BOOLEAN -- or BIT
);

INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted)
VALUES ("Gogo", "12i3{23q", NULL, "12:32:56", false);

INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted)
VALUES ("Gaga", "wkfyuskj", NULL, "02:09:23", false);

INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted)
VALUES ("GG", "igjh)_*(", NULL, "06:44:21", true);

INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted)
VALUES ("KK", "2p4985y@DF", NULL, "15:12:18", false);

INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted)
VALUES ("Pesho", "erfg356", NULL, "22:38:07", true);

ALTER TABLE users DROP PRIMARY KEY, ADD PRIMARY KEY (id, username);
-- ALTER TABLE users ALTER COLUMN last_login_time SET DEFAULT ;

ALTER TABLE users DROP PRIMARY KEY, ADD PRIMARY KEY (id);
ALTER TABLE users ADD CONSTRAINT unique_username UNIQUE (username);






















