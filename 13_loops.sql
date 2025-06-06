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


















