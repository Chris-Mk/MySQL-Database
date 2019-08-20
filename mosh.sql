SELECT name, unit_price, unit_price * 1.1 AS new_price FROM products;

SELECT * FROM orders WHERE order_date >= '2019-01-01';

SELECT * FROM order_items WHERE order_id = 6 AND unit_price * quantity > 30;

SELECT * FROM products WHERE quantity_in_stock IN (49, 38, 72);

SELECT * FROM customers WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT * FROM customers WHERE address LIKE '%TRAIL%' OR address LIKE '%AVENUE%';

SELECT * FROM customers WHERE phone LIKE '%9';

SELECT * FROM customers WHERE first_name REGEXP 'ELKA|AMBUR';

SELECT * FROM customers WHERE last_name REGEXP 'ON$|EY$';

SELECT * FROM customers WHERE last_name REGEXP '^MY|SE';

SELECT * FROM customers WHERE last_name REGEXP 'B[RU]';

SELECT * FROM orders WHERE shipped_date IS NULL;

SELECT * , unit_price * quantity AS total_price 
FROM order_items 
WHERE order_id = 2 
ORDER BY total_price DESC;

SELECT * FROM customers ORDER BY points DESC LIMIT 3;

-- joins
SELECT order_id, p.product_id, p.name, o.quantity, o.unit_price
FROM order_items o
JOIN products p
	-- USING (product_id)
	ON o.product_id = p.product_id;

-- multiple joins
SELECT p.payment_id, p.date,
	   c.name, c.phone,
       pm.name
FROM payments p
JOIN clients c
	-- USING (client_id)
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;

-- outer joins
SELECT p.product_id,
	   p.name,
       oi.quantity
FROM products p
LEFT JOIN order_items oi
	-- USING (product_id)
	ON p.product_id = oi.product_id;

-- multiple outer joins
SELECT o.order_date,
	   o.order_id,
       c.first_name,
       sh.name AS shipper,
       os.name
FROM orders o
JOIN customers c
	-- USING (customer_id)
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	-- USING (shipper_id)
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id;

-- multiple joins
SELECT p.date,
	   c.name AS client,
       p.amount,
       pm.name AS payment_method
FROM payments p
JOIN clients c
	-- USING (client_id)
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;

-- cross joins
SELECT * FROM shippers, products;
SELECT * FROM shippers
CROSS JOIN products;

-- using UNIONS
SELECT customer_id, first_name, points, 'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT customer_id, first_name, points, 'Silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT customer_id, first_name, points, 'Gold' AS type
FROM customers
WHERE points > 3000
ORDER BY first_name;


-- CREATE TABLE invoices_archieved AS;
SELECT * 
FROM invoices i
JOIN clients c
-- USING (client_id)
    ON i.client_id = c.client_id
WHERE i.payment_date IS NOT NULL;


UPDATE orders SET comments = "Gold Customer"
WHERE customer_id IN (
		SELECT customer_id 
			FROM customers 
            WHERE points > 3000);





