CREATE SCHEMA project_management_db;
USE project_management_db;

CREATE TABLE projects (
    id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    client_id INT(11) NOT NULL,
    project_lead_id INT(11) NOT NULL
);

CREATE TABLE employees (
	id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    project_id INT(11) NOT NULL,
    CONSTRAINT fk_employee_project
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE TABLE clients (
	id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(100) NOT NULL,
    project_id INT(11) NOT NULL,
    CONSTRAINT fk_client_project
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE TABLE passports (
	passport_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    passport_number VARCHAR(10) NOT NULL
);

CREATE TABLE persons(
	person_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    passport_id INT NOT NULL UNIQUE,
    CONSTRAINT fk_person_passport
    FOREIGN KEY (passport_id) REFERENCES passports(passport_id) ON DELETE CASCADE
);

INSERT INTO passports VALUES (101, 'N34FG21B');
INSERT INTO passports VALUES (102, 'K65LO4R7');
INSERT INTO passports VALUES (103, 'ZE657QP2');

INSERT INTO persons (first_name, salary, passport_id) VALUES ('Roberto', 43300.00, 102);
INSERT INTO persons (first_name, salary, passport_id) VALUES ('Tom', 56100.00, 103);
INSERT INTO persons (first_name, salary, passport_id) VALUES ('Yana', 60200.00, 101);

ALTER TABLE passports 
MODIFY COLUMN passport_number VARCHAR(10) NOT NULL UNIQUE;

CREATE TABLE manufacturers (
	manufacturer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    established_on DATE NOT NULL
);

CREATE TABLE models (
	model_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    manufacturer_id INT NOT NULL,
    CONSTRAINT fk_model_manufacture
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id)
);

INSERT INTO manufacturers (name, established_on) VALUES ('BMW', '1916-03-01');
INSERT INTO manufacturers (name, established_on) VALUES ('Tesla', '2003-01-01');
INSERT INTO manufacturers (name, established_on) VALUES ('Lada', '1966-05-01');

INSERT INTO models (model_id, name, manufacturer_id) VALUES (101, 'X1', 1);
INSERT INTO models (model_id, name, manufacturer_id) VALUES (102, 'i6', 1);
INSERT INTO models (model_id, name, manufacturer_id) VALUES (103, 'Model S', 2);
INSERT INTO models (model_id, name, manufacturer_id) VALUES (104, 'Model X', 2);
INSERT INTO models (model_id, name, manufacturer_id) VALUES (105, 'Model 3', 2);
INSERT INTO models (model_id, name, manufacturer_id) VALUES (106, 'Nova', 3);

CREATE TABLE students (
	student_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL
);

CREATE TABLE exams (
	exam_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

CREATE TABLE students_exams (
	student_id INT NOT NULL,
    exam_id INT NOT NULL,
    PRIMARY KEY (student_id, exam_id),
    CONSTRAINT fk_students_exams_students
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_students_exams_exams
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);

INSERT INTO students (name) VALUE ('Mila');
INSERT INTO students (name) VALUE ('Toni');
INSERT INTO students (name) VALUE ('Ron');

INSERT INTO exams (exam_id, name) VALUE (101, 'Spring MVC');
INSERT INTO exams (exam_id, name) VALUE (102, 'Neo4j');
INSERT INTO exams (exam_id, name) VALUE (103, 'Oracle 11g');

INSERT INTO students_exams (student_id, exam_id) VALUES (1, 101);
INSERT INTO students_exams (student_id, exam_id) VALUES (1, 102);
INSERT INTO students_exams (student_id, exam_id) VALUES (2, 101);
INSERT INTO students_exams (student_id, exam_id) VALUES (3, 103);
INSERT INTO students_exams (student_id, exam_id) VALUES (2, 102);
INSERT INTO students_exams (student_id, exam_id) VALUES (2, 103);

CREATE TABLE teachers (
	teacher_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    manager_id INT,
    CONSTRAINT fk_teacher_manager
    FOREIGN KEY (manager_id) REFERENCES teachers(teacher_id)
);

INSERT INTO teachers (teacher_id, name, manager_id) 
VALUES (101, 'John', NULL),
	   (102, 'Maya', NULL),
       (103 , 'Silvia', NULL),
       (104, 'Ted', NULL),
       (105, 'Mark', 101),
       (106, 'Greta', 101);
       
SELECT * FROM teachers;

UPDATE teachers SET manager_id = 106 WHERE teacher_id = 102;
UPDATE teachers SET manager_id = 106 WHERE teacher_id = 103;
UPDATE teachers SET manager_id = 105 WHERE teacher_id = 104;













