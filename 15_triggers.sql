/*
-- Trigger Function
CREATE OR REPLACE FUNCTION trigger_fn_name()
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS
$body$
	BEGIN
	END;
$body$

-- Trigger
CREATE TRIGGER trigger_name
	{BEFORE | AFTER} {EVENT} -- EVENTS: INSERT/UPDATE/TRUNCATE
ON table_name
	[FOR [EACH] {ROW | STATEMENT}]
		EXECUTE PROCEDURE trigger_fn_name();
*/

-- Creating distributor table:
CREATE TABLE distributor(
	id SERIAL PRIMARY KEY,
	name VARCHAR(20)
);

-- Inserting some distributors:
INSERT INTO distributor(name)
VALUES
	('Hindustan Unilever'),
	('Patanjali Ayurveda'),
	('PepsiCo'),
	('IndiaMART'),
	('Dots Food');

-- Calling distributor table:
SELECT * FROM distributor;

-- Updating VARCHAR length:
ALTER TABLE distributor ALTER COLUMN name TYPE VARCHAR(100);

-- Creating audit table for distributor
CREATE TABLE distributor_audit(
	id SERIAL PRIMARY KEY,
	dist_id INT NOT NULL,
	name VARCHAR(100) NOT NULL,
	edit_date TIMESTAMP NOT NULL
);

-- Adding new name to distributor audit table:
ALTER TABLE distributor_audit ADD COLUMN new_name VARCHAR(100);

-- Creating Trigger Function for name change of distributor:
CREATE OR REPLACE FUNCTION fn_dist_name_change()
	RETURNS TRIGGER
	LANGUAGE plpgsql	
AS
$body$
	BEGIN
		IF NEW.name <> OLD.name THEN
			INSERT INTO distributor_audit(dist_id, name, new_name, edit_date)
			VALUES
				(OLD.id, OLD.name, NEW.name, NOW());
		END IF;
		RAISE NOTICE 'Trigger Name: %', TG_NAME;
		RAISE NOTICE 'Table Name: %', TG_TABLE_NAME;
		RAISE NOTICE 'Operation performed: %', TG_OP;
		RAISE NOTICE 'When Executed: %', TG_WHEN;
		RAISE NOTICE 'Row or Statement: %', TG_LEVEL;
		RAISE NOTICE 'Table Schema: %', TG_TABLE_SCHEMA;
		RETURN NEW;
	END;
$body$

-- Creating the trigger:
CREATE OR REPLACE TRIGGER tr_dist_name_changed
	BEFORE UPDATE
	ON distributor
	FOR EACH ROW
	EXECUTE PROCEDURE fn_dist_name_change();

-- Testing the trigger:
UPDATE distributor
SET name = 'MuscleBlaze'
WHERE id = 3;

DELETE FROM distributor_audit
WHERE id = 1;

UPDATE distributor
SET name = 'BookWorms'
WHERE id = 1;
		
-- Calling distributor audit table:
SELECT * FROM distributor_audit;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

-- Trigger function for not allowing changes on weekends:
CREATE OR REPLACE FUNCTION fn_block_weekend_changes()
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS
$body$
	BEGIN
		RAISE NOTICE 'No changes allowed on weekends!';
		RETURN null;
	END;
$body$

-- Create Trigger for blocking weekend changes:
CREATE TRIGGER tr_block_weekend_changes
	BEFORE INSERT OR UPDATE OR DELETE OR TRUNCATE
	ON distributor
	FOR EACH STATEMENT
	WHEN (
		EXTRACT('DOW' FROM CURRENT_TIMESTAMP) BETWEEN 6 AND 7
	)
	EXECUTE PROCEDURE fn_block_weekend_changes();

-- Testing above trigger on current day:
CREATE TRIGGER tr_block_changes_today
	BEFORE INSERT OR UPDATE OR DELETE OR TRUNCATE
	ON distributor
	FOR EACH STATEMENT
	WHEN (
		EXTRACT('DOW' FROM CURRENT_TIMESTAMP) = 2
	)
	EXECUTE PROCEDURE fn_block_weekend_changes();

UPDATE distributor
SET name = 'xyz'
WHERE id = 2;

-- Dropping a trigger:
DROP TRIGGER IF EXISTS tr_block_changes_today ON distributor;


























