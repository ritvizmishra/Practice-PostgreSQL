-- IF ELSEIF ELSE statements:
CREATE OR REPLACE FUNCTION fn_orders_review(the_month INT)
RETURNS VARCHAR AS
$body$
DECLARE
	total_orders INT;
BEGIN
	SELECT COUNT(*)
	INTO total_orders
	FROM sales_order
	WHERE EXTRACT(MONTH FROM time_order_taken) = the_month;
	IF total_orders > 5 THEN
		RETURN CONCAT(total_orders, ' orders: good!');
	ELSEIF total_orders < 5 AND total_orders >= 2 THEN
		RETURN CONCAT(total_orders, ' orders: decent.');
	ELSE
		RETURN CONCAT(total_orders, ' orders: bad and sad.');
	END IF;
END
$body$
LANGUAGE plpgsql

SELECT fn_orders_review(7);

-- CASE statements:
CREATE OR REPLACE FUNCTION fn_orders_review(the_month INT)
RETURNS VARCHAR AS
$body$
DECLARE
	total_orders INT;
BEGIN
	SELECT COUNT(*)
	INTO total_orders
	FROM sales_order
	WHERE EXTRACT(MONTH FROM time_order_taken) = the_month;
	CASE 
		WHEN total_orders > 5 THEN
			RETURN CONCAT(total_orders, ' orders: good!');
		WHEN total_orders < 5 AND total_orders >= 2 THEN
			RETURN CONCAT(total_orders, ' orders: decent.');
		ELSE
			RETURN CONCAT(total_orders, ' orders: bad and sad.');
	END CASE;
END
$body$
LANGUAGE plpgsql

SELECT fn_orders_review(1);




