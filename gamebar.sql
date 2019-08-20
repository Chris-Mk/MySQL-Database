CREATE SCHEMA gamebar;
USE gamebar;

CREATE TABLE employees (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL
);

CREATE TABLE categories (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL
);

CREATE TABLE products (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL,
    category_id INT NOT NULL
);

INSERT INTO employees (first_name, last_name) VALUES ("Pesho", "Gosho");
INSERT INTO employees (first_name, last_name) VALUES ("Gosho", "Peshov");
INSERT INTO employees (first_name, last_name) VALUES ("Stamat", "Keranov");

-- ALTER TABLE employees ADD middle_name VARCHAR(45) AFTER first_name;

ALTER TABLE employees DROP COLUMN middle_name;
ALTER TABLE employees ADD middle_name VARCHAR(45);
ALTER TABLE products ADD FOREIGN KEY (category_id) REFERENCES categories(id);
ALTER TABLE employees MODIFY COLUMN middle_name VARCHAR(100);









