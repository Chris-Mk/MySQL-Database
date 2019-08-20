CREATE DATABASE soft_uni;
USE soft_uni;

CREATE TABLE towns (
	id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL
);

CREATE TABLE addresses (
	id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    address_text VARCHAR(50) NOT NULL,
    town_id INT(11) NOT NULL,
    FOREIGN KEY (town_id) REFERENCES towns(id)
);

CREATE TABLE departments (
	id INT(11) NOT NULL,
    name VARCHAR(20) NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE employees (
	id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    middle_name VARCHAR(20),
    last_name VARCHAR(20) NOT NULL,
    job_title VARCHAR(20) NOT NULL,
    department_id VARCHAR(20) NOT NULL,
    hire_date DATE,
	salary DECIMAL(11, 2) NOT NULL,
--    address_id INT(11) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(name)
--    FOREIGN KEY (address_id) REFERENCES addresses(id)
);

INSERT INTO towns (name) VALUE ("Sofia");
INSERT INTO towns (name) VALUE ("Plovdiv");
INSERT INTO towns (name) VALUE ("Varna");
INSERT INTO towns (name) VALUE ("Burgas");

INSERT INTO departments (name) VALUE ("Engineering");
INSERT INTO departments (name) VALUE ("Sales");
INSERT INTO departments (name) VALUE ("Marketing");
INSERT INTO departments (name) VALUE ("Software Development");
INSERT INTO departments (name) VALUE ("Quality Assurance");

INSERT INTO employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
VALUES ("Ivan", "Ivanov", "Ivanov", ".NET Developer", "Software Development", "2013-02-01", 3500.00);

SELECT * FROM employees;













