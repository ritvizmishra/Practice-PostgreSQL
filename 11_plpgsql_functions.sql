-- PL/pgSQL FUNCTIONS:

CREATE OR REPLACE FUNCTION fn_get_product_price(prod_name VARCHAR) 
RETURNS numeric AS
$body$
BEGIN
	RETURN item.price
	FROM item
	NATURAL JOIN product
	WHERE product.name = prod_name;
END
$body$
LANGUAGE plpgsql

SELECT fn_get_product_price('Grandview');

-- Using variables in functions:
CREATE OR REPLACE FUNCTION fn_get_sum(num1 INT, num2 INT)
RETURNS INT AS
$body$
DECLARE
	ans INT;
BEGIN
	ans := num1 + num2;
	RETURN ans;
END
$body$
LANGUAGE plpgsql

SELECT fn_get_sum(23,67);

-- Generating random integer:
/*
To generate a number in a range [min, max):

		```random_number = RANDOM() * (max - min) + min```
		
This logic is universal in programming languages.
*/
CREATE OR REPLACE FUNCTION fn_get_rand_num(min_val INT, max_val INT)
RETURNS INT AS
$body$
DECLARE 
	rand INT;
BEGIN
	SELECT RANDOM()*(max_val - min_val) + min_val INTO rand;
	RETURN rand;
END
$body$
LANGUAGE plpgsql

SELECT fn_get_rand_num(1, 100);

-- Return name of a random sales_person:
CREATE OR REPLACE FUNCTION fn_get_rand_salesperson()
RETURNS varchar AS
$body$
DECLARE 
	rand INT;
	emp RECORD;
BEGIN
	SELECT RANDOM()*(10 - 1) + 1 INTO rand;
	SELECT *
	FROM sales_person
	INTO emp
	WHERE id = rand;
	RETURN CONCAT(emp.first_name, ' ', emp.last_name);
END
$body$
LANGUAGE plpgsql

SELECT fn_get_rand_salesperson();

-- IN INOUT OUT function modes:
CREATE OR REPLACE FUNCTION fn_get_diff(IN var1 INT, IN var2 INT, OUT ans INT)
AS
$body$
BEGIN
	ans := var1 - var2;
END
$body$
LANGUAGE plpgsql

SELECT fn_get_diff(8,1);

-- Querying the customer's birthday:
CREATE OR REPLACE FUNCTION fn_get_cust_birthday(IN the_month INT, OUT bd_month INT, OUT bd_day INT,
										OUT f_name VARCHAR, OUT l_name VARCHAR)
AS
$body$
BEGIN
	SELECT EXTRACT(MONTH FROM birth_date),EXTRACT(DAY FROM birth_date), first_name, last_name
	INTO bd_month, bd_day, f_name, l_name
	FROM customer
	WHERE EXTRACT(MONTH FROM birth_date) = the_month;
END
$body$
LANGUAGE plpgsql

SELECT (fn_get_cust_birthday(11)).*;

-- Returning multiple rows from a query:
CREATE OR REPLACE FUNCTION fn_get_salesperson()
RETURNS SETOF sales_person AS
$body$
BEGIN
	RETURN QUERY
	SELECT *
	FROM sales_person;
END
$body$
LANGUAGE plpgsql

SELECT (fn_get_salesperson()).*;
SELECT (fn_get_salesperson()).phone;

-- Querying for a table of the top 10 most expensive items:
CREATE OR REPLACE FUNCTION fn_top_10_expensive_items()
RETURNS TABLE (
	name VARCHAR,
	supplier VARCHAR,
	price NUMERIC
) AS
$body$
BEGIN
	RETURN QUERY
	SELECT product.name, product.supplier, item.price
	FROM item
	NATURAL JOIN product
	ORDER BY item.price DESC
	LIMIT 10;
END
$body$
LANGUAGE plpgsql

SELECT (fn_top_10_expensive_items()).*;








