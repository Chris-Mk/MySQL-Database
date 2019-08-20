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





















