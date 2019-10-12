/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping structure for table bank.accounts
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL,
  `account_holder_id` int(11) NOT NULL,
  `balance` decimal(19,4) DEFAULT '0.0000',
  PRIMARY KEY (`id`),
  KEY `fk_accounts_account_holders` (`account_holder_id`),
  CONSTRAINT `fk_accounts_account_holders` FOREIGN KEY (`account_holder_id`) REFERENCES `account_holders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table bank.accounts: ~18 rows (approximately)
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` (`id`, `account_holder_id`, `balance`) VALUES
	(1, 1, 123.1200),
	(2, 3, 4354.2300),
	(3, 12, 6546543.2300),
	(4, 9, 15345.6400),
	(5, 11, 36521.2000),
	(6, 8, 5436.3400),
	(7, 10, 565649.2000),
	(8, 11, 999453.5000),
	(9, 1, 5349758.2300),
	(10, 2, 543.3000),
	(11, 3, 10.2000),
	(12, 7, 245656.2300),
	(13, 5, 5435.3200),
	(14, 4, 1.2300),
	(15, 6, 0.1900),
	(16, 2, 5345.3400),
	(17, 11, 76653.2000),
	(18, 1, 235469.8900);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;


-- Dumping structure for table bank.account_holders
DROP TABLE IF EXISTS `account_holders`;
CREATE TABLE IF NOT EXISTS `account_holders` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `ssn` char(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table bank.account_holders: ~12 rows (approximately)
/*!40000 ALTER TABLE `account_holders` DISABLE KEYS */;
INSERT INTO `account_holders` (`id`, `first_name`, `last_name`, `ssn`) VALUES
	(1, 'Susan', 'Cane', '1234567890'),
	(2, 'Kim', 'Novac', '1234567890'),
	(3, 'Jimmy', 'Henderson', '1234567890'),
	(4, 'Steve', 'Stevenson', '1234567890'),
	(5, 'Bjorn', 'Sweden', '1234567890'),
	(6, 'Kiril', 'Petrov', '1234567890'),
	(7, 'Petar', 'Kirilov', '1234567890'),
	(8, 'Michka', 'Tsekova', '1234567890'),
	(9, 'Zlatina', 'Pateva', '1234567890'),
	(10, 'Monika', 'Miteva', '1234567890'),
	(11, 'Zlatko', 'Zlatyov', '1234567890'),
	(12, 'Petko', 'Petkov Junior', '1234567890');
/*!40000 ALTER TABLE `account_holders` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;


DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT concat(first_name, ' ', last_name) AS full_name
    FROM account_holders
    ORDER BY full_name, id;
END $$
DELIMITER ;

CALL usp_get_holders_full_name();

------------- TODO -----------------------
DELIMITER $$
CREATE FUNCTION udf_get_total_account_balance_from(user_id INT)
RETURNS DECIMAL(19, 4)
BEGIN
	DECLARE total_account_balance DECIMAL(19, 4);
    SET total_account_balance := 
		(SELECT SUM(balance)
        FROM accounts
		WHERE account_holder_id = user_id);
	RETURN total_account_balance;
END $$

CREATE PROCEDURE usp_get_holders_with_balance_higher_than(min_balance DECIMAL(19, 4))
BEGIN
	SELECT ah.first_name, ah.last_name
    FROM account_holders ah
    JOIN accounts a
		ON ah.id = a.account_holder_id
	WHERE (SELECT total_balance FROM 
			(SELECT SUM(balance) AS total_balance
			 FROM accounts a
			 GROUP BY a.account_holder_id) AS sum_sum
		  ) > min_balance
    ORDER BY ah.first_name, ah.last_name, a.id;
END $$
DELIMITER ;

CALL usp_get_holders_with_balance_higher_than(7000);

DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(initial_sum DOUBLE, yearly_interest_rate DECIMAL(5, 2), number_of_years INT)
RETURNS DOUBLE
BEGIN 
	DECLARE future_sum DOUBLE;
    SET future_sum := initial_sum * (POW((1 + yearly_interest_rate), number_of_years));
    RETURN future_sum;
END $$
DELIMITER ;

SELECT ufn_calculate_future_value(1000, 0.1, 5);

DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(account_id INT, interest_rate DOUBLE)
BEGIN
	SELECT 
		a.id,
        ah.first_name,
        ah.last_name,
        a.balance AS current_balance,
        round((SELECT ufn_calculate_future_value(a.balance, interest_rate, 5)), 4) AS balance_in_5_years
    FROM accounts a
    JOIN account_holders ah
		ON a.account_holder_id = ah.id
	WHERE a.id = account_id;
END $$
DELIMITER ;

CALL usp_calculate_future_value_for_account(1, 0.1);

DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DOUBLE)
BEGIN
	START TRANSACTION;
    IF (money_amount < 0) THEN 
		ROLLBACK;
	ELSE 
		UPDATE accounts
        SET balance = round(balance + money_amount, 4)
        WHERE id = account_id;
        COMMIT;
    END IF;
END $$
DELIMITER ;

CALL usp_deposit_money(1, 10);

SELECT * FROM accounts;

DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DOUBLE)
BEGIN
	START TRANSACTION;
    IF (money_amount < 0 OR (SELECT balance FROM accounts WHERE id = account_id) < money_amount) THEN
		ROLLBACK;
	ELSE
		UPDATE accounts
        SET balance = balance - money_amount
        WHERE id = account_id;
        COMMIT;
    END IF;
END $$
DELIMITER ;

CALL usp_withdraw_money(1, 10);

SELECT * FROM accounts WHERE id = 1;

DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DOUBLE)
BEGIN
	START TRANSACTION;
    IF (from_account_id < 1
		OR to_account_id < 1
		OR from_account_id > (SELECT COUNT(id) FROM accounts)
        OR to_account_id > (SELECT COUNT(id) FROM accounts)
        OR amount < 0
        OR (SELECT balance FROM accounts WHERE id = from_account_id) < amount
        OR from_account_id = to_account_id) THEN
        ROLLBACK;
	ELSE
		UPDATE accounts
        SET balance = balance - amount
        WHERE id = from_account_id;
        
        UPDATE accounts
        SET balance = balance + amount
        WHERE id = to_account_id;
        
        COMMIT;
    END IF;
END $$
DELIMITER ;

CALL usp_transfer_money(1, 2, 10);

SELECT * FROM accounts LIMIT 2;

CREATE TABLE logs(
	log_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    old_sum DECIMAL(19, 4),
    new_sum DECIMAL(19, 4)
);

CREATE TABLE notification_emails(
	id INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT,
    subject VARCHAR(50),
    body VARCHAR(50)
);

DELIMITER $$
CREATE TRIGGER tr_account_sum
AFTER UPDATE ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO logs (account_id, old_sum, new_sum)
    VALUES (OLD.id, OLD.balance, NEW.balance);
END $$

CREATE TRIGGER tr_emails
AFTER INSERT ON logs
FOR EACH ROW
BEGIN
	INSERT INTO notification_emails (recipient, subject, body)
    VALUES (account_id,
			concat('Balance change for account:', account_id),
            concat('On ',  DATE_FORMAT(DATE(NOW()), '%b %d %Y'),' at ', DATE_FORMAT(TIME(NOW()), '%r'),
					' your balance was changed from',  old_sum, ' to ', new_sum, '.'));
END $$
DELIMITER ;

UPDATE accounts
SET balance = balance + 10
WHERE id = 1;




