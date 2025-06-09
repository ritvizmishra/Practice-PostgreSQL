-- STORED PROCEDURES
/*
	CREATE OR REPLACE PROCEDURE procedure_name(params)
	AS	
	$body$
		DECLARE
			-- if reqd
		BEGIN
			-- logic
		END;
	$body$
	LANGUAGE plpgsql

	CALL procedure_name;

-- If no parameters, it's called a static procedure.
*/

-- Creating a new table for dues:
CREATE TABLE pay_dues(
	 id SERIAL PRIMARY KEY,
	 cust_name VARCHAR(20),
	 balance NUMERIC(6,2)
);

INSERT INTO pay_dues (cust_name, balance)
VALUES 
	('Ritviz Mishra', 599.22),
	('Noah Patel', 287.34),
	('Ava Thompson', 987.21),
	('Sophia Green', 349.99);

SELECT * FROM pay_dues ORDER BY id ASC;

-- Creating a procedure:
CREATE OR REPLACE PROCEDURE pr_debt_paid (balance_paid NUMERIC, cust_id INT)
AS
$body$
	BEGIN
		UPDATE pay_dues
		SET balance = balance - balance_paid
		WHERE id = cust_id;
		COMMIT;
	END;
$body$
LANGUAGE plpgsql

CALL pr_debt_paid(240.98, 1);
CALL pr_debt_paid(280.98, 2);





















