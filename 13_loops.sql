/*
LOOP
	Statements
	EXIT WHEN condition is true;
END LOOP;
*/

CREATE OR REPLACE FUNCTION fn_loop_test(max_num INT)
RETURNS INT AS
$body$
DECLARE
	i INT DEFAULT 1;
	total_sum INT DEFAULT 0;
BEGIN
	LOOP
		total_sum := total_sum + i;
		i := i + 1;
		EXIT WHEN i > max_num;
	END LOOP;
	RETURN total_sum;
END
$body$
LANGUAGE plpgsql

SELECT fn_loop_test(10);

-- FOR LOOP:
CREATE OR REPLACE FUNCTION fn_for_loop_test(max_num INT)
RETURNS INT AS
$body$
DECLARE
	total_sum INT DEFAULT 0;
BEGIN
	FOR i IN REVERSE max_num .. 1 BY 3
	LOOP
		total_sum := total_sum + i;
		EXIT WHEN i > max_num;
	END LOOP;
	RETURN total_sum;
END
$body$
LANGUAGE plpgsql

SELECT fn_for_loop_test(10);

-- Raising notice in messages console:
/*
	~ % is a placeholder for a value.
	~ So % %' means: insert two values with a space between them.
	~ rec.first_name and rec.last_name are the values that replace the two %s respectively.
*/
DO 
$body$
	DECLARE
		rec RECORD;
	BEGIN
		FOR rec IN 
				SELECT first_name, last_name
				FROM sales_person
		LOOP
			RAISE NOTICE '% %', rec.first_name, rec.last_name;
		END LOOP;
	END;
$body$
LANGUAGE plpgsql

-- FOREACH LOOP and ARRAY DECLARATION:
DO
$body$
	DECLARE
		arr INT[] = ARRAY[1,2,3,4,5,6,7,8,9,10];
		i INT;
	BEGIN
		FOREACH i IN ARRAY arr
		LOOP
			RAISE NOTICE '%', i;
		END LOOP;
	END;
$body$
LANGUAGE plpgsql

-- WHILE LOOP
DO
$body$
	DECLARE
		i INT DEFAULT 1;
		total_sum BIGINT DEFAULT 0;
	BEGIN
		WHILE i <= 100000
		LOOP
			total_sum := total_sum + i;
			i := i + 1;
		END LOOP;
		RAISE NOTICE '%', total_sum;
	END;
$body$
LANGUAGE plpgsql

-- Printing odd numbers using the CONTINUE statement:
DO
$body$
	DECLARE 
		i INT DEFAULT 1;
	BEGIN
		LOOP
			i := i + 1;
			EXIT WHEN i > 10;
			CONTINUE WHEN MOD(i,2) = 0;
			RAISE NOTICE 'Num: %', i;
		END LOOP;
	END;
$body$
LANGUAGE plpgsql

-- Return a supplier and total inventory value related to it:
CREATE OR REPLACE FUNCTION fn_get_supplier_inventory(the_supplier VARCHAR)
RETURNS VARCHAR AS
$body$
DECLARE 
	supplier_name VARCHAR;
	total_value NUMERIC;
BEGIN
	SELECT product.supplier, SUM(item.price) 
	INTO supplier_name, total_value
	FROM product, item
	WHERE product.supplier = the_supplier
	GROUP BY product.supplier;
	RETURN CONCAT(supplier_name, ' Inventory value: $', total_value);
END
$body$
LANGUAGE plpgsql	

SELECT fn_get_supplier_inventory('Nike');














