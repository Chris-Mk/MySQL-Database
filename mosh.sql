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

SELECT order_id, p.product_id, p.name, o.quantity, o.unit_price
FROM order_items o
JOIN products p
	ON o.product_id = p.product_id;

SELECT p.payment_id, p.date,
	   c.name, c.phone,
       pm.name
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;















