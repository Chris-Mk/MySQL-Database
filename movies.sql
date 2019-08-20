CREATE SCHEMA Movies;
USE Movies;

CREATE TABLE directors (
	id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    director_name VARCHAR(50) NOT NULL,
    notes TEXT
);

CREATE TABLE genres (
	id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL,
    notes TEXT
);

CREATE TABLE categories (
	id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    notes TEXT
);

CREATE TABLE movies (
	id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director_id INT(11) NOT NULL,
    copyright_year YEAR(4),
    length TIME,
    genre_id INT(11) NOT NULL,
    category_id INT(11) NOT NULL,
    rating FLOAT,
    notes TEXT,
    FOREIGN KEY (director_id) REFERENCES directors(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);


INSERT INTO directors (director_name, notes) VALUES ("Pesho Shefe", "djfbjksdnf");
INSERT INTO directors (director_name, notes) VALUES ("Shefe Shefe", NULL);
INSERT INTO directors (director_name, notes) VALUES ("Gosho Goshev", "1234");
INSERT INTO directors (director_name, notes) VALUES ("Mariyka Villa", "eat");
INSERT INTO directors (director_name, notes) VALUES ("Spider man", NULL);

INSERT INTO genres (genre_name, notes) VALUES ("Thriller", "more thrill");
INSERT INTO genres (genre_name, notes) VALUES ("Reggae", NULL);
INSERT INTO genres (genre_name, notes) VALUES ("Fantasy", "Disney land");
INSERT INTO genres (genre_name, notes) VALUES ("Science", "I'm thinking");
INSERT INTO genres (genre_name, notes) VALUES ("Play", NULL);

INSERT INTO categories (category_name, notes) VALUES ("FUN", NULL);
INSERT INTO categories (category_name, notes) VALUES ("440", "440-440-440");
INSERT INTO categories (category_name, notes) VALUES ("WHY?", NULL);
INSERT INTO categories (category_name, notes) VALUES ("Happy Happy", "be happier and smile");
INSERT INTO categories (category_name, notes) VALUES ("Food", "Give me more food!!!");

INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
VALUES ("Mans not hot", 3, NULL, NULL, 5, 1, 89.99, "very funny");
INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
VALUES ("Space Odessy", 1, 2001, 120.40, 2, 3, NULL, NULL);
INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
VALUES ("Hanger Man", 4, 2012, 43.50, 1, 5, 20.90, "hanging clothes in the wardrobe");
INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
VALUES ("Shadow Fight", 5, NULL, 20.00, 3, 2, NULL, "Turn into a human");
INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
VALUES ("Dragonoid", 2, 2005, 39.20, 4, 4, 98.99, "Beat me if you can");





















