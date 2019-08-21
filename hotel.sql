CREATE TABLE employees (
	id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    title VARCHAR(20) NOT NULL,
    notes TEXT
);

CREATE TABLE customers (
	account_number INT(11) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    phone_number INT(11) NOT NULL,
    emergency_name VARCHAR(20),
	emergency_number VARCHAR(20),
    notes TEXT
);

CREATE TABLE room_status (
	room_status VARCHAR(50) NOT NULL,
    notes TEXT
);

CREATE TABLE room_types (
	room_type VARCHAR(50) NOT NULL,
    notes TEXT
);

CREATE TABLE bed_types (
	bed_type VARCHAR(50) NOT NULL, 
    notes TEXT
);

CREATE TABLE rooms (
	room_number INT(11) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    bed_type VARCHAR(50) NOT NULL,
    rate FLOAT(5, 2) NOT NULL,
    room_status VARCHAR(50) NOT NULL,
    notes TEXT,
    FOREIGN KEY (room_status) REFERENCES room_status(room_status),
    FOREIGN KEY (room_type) REFERENCES room_type(room_type),
    FOREIGN KEY (bed_type) REFERENCES bed_type(bed_type)
);

CREATE TABLE payments (
	id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    employee_id INT(11) NOT NULL,
    payment_date DATE NOT NULL,
    account_number INT(11) NOT NULL,
    first_date_occupied DATE NOT NULL,
	last_date_occupied DATE NOT NULL,
    total_days INT(11) NOT NULL,
    amount_charged DECIMAL(11, 2) NOT NULL,
    tax_rate FLOAT NOT NULL,
    tax_amount DECIMAL(11, 2) NOT NULL, 
    payment_total DECIMAL(11, 2) NOT NULL,
	notes TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE occupancies (
	id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    employee_id INT(11) NOT NULL,
    date_occupied DATE NOT NULL,
    account_number INT(11) NOT NULL,
    room_number INT(11) NOT NULL,
    rate_applied INT(11) NOT NULL,
	phone_charge INT(11) NOT NULL,
    notes TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

INSERT INTO employees (first_name, last_name, title) VALUES ("Pesho", "Peshev", "CTO");
INSERT INTO employees (first_name, last_name, title) VALUES ("Gosho", "Goshev", "CeO");
INSERT INTO employees (first_name, last_name, title) VALUES ("Stamat", "Stamato", "KO");


SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'sa%'
ORDER BY employee_id;

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

SELECT first_name
FROM employees
WHERE department_id IN (3, 10) AND
	  hire_date BETWEEN '1995-01-01' AND '2005-12-31'
ORDER BY employee_id;

SELECT first_name, last_name
FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

SELECT name FROM towns
WHERE CHAR_LENGTH(name) IN (5, 6)
ORDER BY name;

SELECT * FROM towns
WHERE LEFT(name, 1) IN ('M', 'K', 'E', 'B')
ORDER BY name;

SELECT * FROM towns
WHERE LEFT(name, 1) NOT IN ('B', 'R', 'D')
ORDER BY name;

CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name, last_name 
FROM employees
WHERE hire_date > '2000-12-31';

SELECT * FROM v_employees_hired_after_2000;

SELECT first_name, last_name
FROM employees
WHERE CHAR_LENGTH(last_name) = 5;

SELECT country_name, iso_code
FROM countries
WHERE country_name LIKE '%a%a%a%'
ORDER BY iso_code;

SELECT p.peak_name,
	   r.river_name,
       concat(LOWER(p.peak_name), LOWER(INSERT(r.river_name, 1, 1, ''))) AS mix
FROM peaks p, rivers r
WHERE RIGHT(p.peak_name, 1) = LEFT(r.river_name, 1)
ORDER BY mix;

SELECT name, DATE_FORMAT(start, '%Y-%m-%d') AS start
FROM games
WHERE start BETWEEN '2011-01-01' AND '2012-12-31'
ORDER BY start, name
LIMIT 50;

SELECT user_name, REPLACE(SUBSTRING(email, LOCATE('@', email)), '@', '') AS Email_Provider
FROM users
ORDER BY Email_Provider, user_name;

SELECT user_name, ip_address
FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;

SELECT name,
	   IF (EXTRACT(HOUR FROM start) < 12, 'Morning', 
			IF (EXTRACT(HOUR FROM start) < 18, 'Afternoon', 'Evening')) AS 'Part of the Day',
	   IF (duration <= 3, 'Extra Short', 
			IF (duration <= 6, 'Short',
				IF (duration <= 10, 'Long', 'Extra Long'))) AS Duration
FROM games;






















