-- CURSORS
DO 
$body$
	DECLARE
		msg TEXT DEFAULT '';
		rec_customer RECORD;
		cur_customer CURSOR
		FOR
			SELECT * FROM customer;
	BEGIN
		OPEN cur_customer;
		LOOP
			FETCH cur_customer INTO rec_customer;
			EXIT WHEN NOT FOUND;
			msg := msg || FORMAT('%s %s, ', rec_customer.first_name, rec_customer.last_name);
		END LOOP;
		RAISE NOTICE 'Customer names: %', msg;
	END;
$body$