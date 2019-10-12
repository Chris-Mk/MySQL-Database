DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with (input_str VARCHAR(50))
BEGIN
	DECLARE town_wild_card VARCHAR(50);
    SET town_wild_card := concat(input_str, '%');
    
    SELECT t.name
    FROM towns t
    WHERE lower(t.name) LIKE lower(town_wild_card)
    ORDER BY t.name;
END $$
DELIMITER ;

CALL usp_get_towns_starting_with ('b');

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE employees_town_count INT;
    SET employees_town_count := 
		(SELECT count(e.employee_id)
        FROM employees e
        JOIN addresses a
			USING (address_id)
		JOIN towns t
			USING (town_id)
		WHERE t.name = town_name);
	RETURN employees_town_count;
END $$
DELIMITER ;

SELECT ufn_count_employees_by_town('Sofia');

DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
	UPDATE employees e
    JOIN departments d
		USING (department_id)
	SET e.salary = e.salary * 1.05
    WHERE d.name = department_name;
END $$
DELIMITER ;
    
CALL usp_raise_salaries('Finance');

DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
	UPDATE employees
    SET salary = salary * 1.05
    WHERE employee_id = id;
END $$
DELIMITER ;

CREATE TABLE deleted_employees (
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50),
    last_name VARCHAR(50),
    middle_name VARCHAR(50),
    job_title VARCHAR(50),
    department_id INT(10),
    salary DECIMAL(19, 4)
);

DELIMITER $$
CREATE TRIGGER fired_employees_from_soft_uni
AFTER DELETE ON employees
FOR EACH ROW
	BEGIN
		INSERT INTO deleted_employees (first_name, last_name, middle_name, job_title, department_id, salary)
        VALUES (OLD.first_name, OLD.last_name, OLD.middle_name, OLD.job_title, OLD.department_id, OLD.salary);
	END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS BIT
BEGIN
	DECLARE is_comprised BIT;
	DECLARE current_index INT;
    DECLARE word_length INT;
    
    SET is_comprised := 1;
    SET current_index := 1;
    SET word_length := char_length(word);
    
    WHILE (current_index <= word_length) DO
		IF (set_of_letters NOT LIKE concat('%', substring(word, current_index, 1), '%')) THEN
			SET is_comprised := 0;
		END IF;
        
        SET current_index := current_index + 1;
	END WHILE;
    RETURN is_comprised;
END $$
DELIMITER ;

SELECT ufn_is_word_comprised('oistmiahf', 'Sofia') AS result;
SELECT ufn_is_word_comprised('oistmiahf', 'halve') AS result;
SELECT ufn_is_word_comprised('oistmiahf', 'Sofia') AS result;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT first_name, last_name
    FROM employees
    WHERE salary > 35000
    ORDER BY first_name, last_name, employee_id;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(min_salary DECIMAL(19, 4))
BEGIN
	SELECT first_name, last_name
    FROM employees
    WHERE salary >= min_salary
    ORDER BY first_name, last_name, employee_id;
END $$
DELIMITER ;

CALL usp_get_employees_salary_above(48100);

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(prefix VARCHAR(50))
BEGIN
	SELECT name
    FROM towns
    WHERE name LIKE concat(prefix, '%')
    ORDER BY name;
END $$
DELIMITER ;

CALL usp_get_towns_starting_with('b');

DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
	SELECT e.first_name, e.last_name
    FROM employees e
    JOIN addresses a
		USING (address_id)
	JOIN towns t
		USING (town_id)
	WHERE t.name = town_name
    ORDER BY e.first_name, e.last_name, e.employee_id;
END $$
DELIMITER ;

CALL usp_get_employees_from_town('Sofia');

DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(employee_salary DECIMAL(19, 4))
RETURNS VARCHAR(7)
BEGIN
	DECLARE salary_level VARCHAR(7);
	SET salary_level := 
    (CASE
		WHEN employee_salary < 30000 THEN 'Low'
		WHEN employee_salary BETWEEN 30000 AND 50000 THEN 'Average'
		ELSE 'High'
	END);
    RETURN salary_level;
END $$
DELIMITER ;

SELECT ufn_get_salary_level(13500.00);
SELECT ufn_get_salary_level(43300.00);
SELECT ufn_get_salary_level(125500.00);

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(7))
BEGIN
	SELECT first_name, last_name
    FROM employees
    WHERE (SELECT ufn_get_salary_level(salary)) = salary_level
    ORDER BY first_name DESC, last_name DESC;
END $$
DELIMITER ;

CALL usp_get_employees_by_salary_level('High');


