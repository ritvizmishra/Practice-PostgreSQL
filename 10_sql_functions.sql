-- SQL FUNCTIONS:

CREATE OR REPLACE FUNCTION fn_add_ints(int, int) 
RETURNS int AS
$body$
	SELECT $1 + $2
$body$
LANGUAGE SQL

SELECT fn_add_ints(3,4);

-- Updating customer company:
CREATE OR REPLACE FUNCTION fn_set_customer_company()
RETURNS void AS
$body$
	UPDATE customer
	SET company = 'unknown'
	WHERE company IS null
$body$
LANGUAGE SQL

SELECT fn_set_customer_company();
SELECT company FROM customer;

-- Find the number of orders placed by a customer:
CREATE OR REPLACE FUNCTION fn_get_order_nums(cust_fname VARCHAR, cust_lname VARCHAR)
RETURNS int AS
$body$
	SELECT COUNT(*)
	FROM sales_order
	JOIN customer c ON c.id = sales_order.customer_id
	WHERE c.first_name = cust_fname AND c.last_name = cust_lname
$body$
LANGUAGE SQL

SELECT fn_get_order_nums('Virat', 'Kohli');

-- Get details of the latest order:
CREATE OR REPLACE FUNCTION fn_get_latest_order()
RETURNS sales_order AS
$body$
	SELECT * FROM sales_order
	ORDER BY time_order_taken
	LIMIT 1
$body$
LANGUAGE SQL

SELECT (fn_get_latest_order()).*;

-- Returning multiple rows:
CREATE OR REPLACE FUNCTION fn_get_saleperson_by_state(loc VARCHAR)
RETURNS SETOF sales_person AS
$body$
	SELECT * FROM sales_person
	WHERE state = loc
$body$
LANGUAGE SQL

SELECT (fn_get_saleperson_by_state('CO')).*;









