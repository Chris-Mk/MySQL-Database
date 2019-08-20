CREATE TABLE categories (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL,
    daily_rate FLOAT,
    weekly_rate FLOAT,
    monthly_rate FLOAT,
    weekend_rate FLOAT
);

CREATE TABLE cars (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    plate_number VARCHAR(10) NOT NULL,
    make VARCHAR(20) NOT NULL,
    model VARCHAR(20),
    car_year YEAR NOT NULL,
    category_id INT NOT NULL,
    doors INT,
    picture BLOB,
    car_condition VARCHAR(255),
	available BOOLEAN NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE employees (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    title VARCHAR(20),
    notes TEXT
);

CREATE TABLE customers (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    driver_licence_number VARCHAR(20) NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(20),
    zip_code INT(11),
    notes TEXT
);

CREATE TABLE rental_orders (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    car_id INT NOT NULL,
    car_condition VARCHAR(255),
    tank_level FLOAT,
	kilometrage_start FLOAT,
    kilometrage_end FLOAT,
    total_kilometrage FLOAT,
    start_date DATE,
    end_date DATE,
	total_days INT,
    rate_applied FLOAT,
    tax_rate FLOAT,
    order_status BOOLEAN,
    notes TEXT,
    FOREIGN KEY (car_id) REFERENCES cars(id)
);

INSERT INTO categories (category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
VALUES ("A", NULL, NULL, NULL, NULL),
	   ("B", 12.12, 4545.50, 934.23, 12983.34),
       ("C", NULL, 322.78, NULL, 821.34);
       
INSERT INTO cars (plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
VALUES ("AA 2324 BB", "AUDI", NULL, 2001, 2, 3, NULL, NULL, TRUE),
	   ("QW 4750 KK", "BMW", "MK X", 2007, 1, 4, NULL, "in a good condition", TRUE),
       ("SK 1238 MM", "BOSS", "Q1", 1998, 3, NULL, NULL, "new", FALSE);

INSERT INTO employees (first_name, last_name, title, notes)
VALUES ("Pesho", "Peshev", NULL, NULL),
       ("Gosho", "Goshev", "CEO", NULL),
       ("Flip", "Flop", "CTO", "very cool");
       
INSERT INTO customers (driver_licence_number, full_name, address, city, zip_code, notes)
VALUES ("AYD 2323 ASDA 123", "Antoine Griezzman", "Pobeda 6g", NULL, NULL, NULL),
	   ("MFG 3247 SLEU 597", "Messi Messi", "Dar q9", "Apple", 9000, "eat ugali"),
       ("IUT 4579 JHFW 385", "Why Me", "Popo 46", "Haha", 2833, "yeah!");

INSERT INTO rental_orders (employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start,
 kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes)
 VALUES (1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	    (2, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
        (3, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);











