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










