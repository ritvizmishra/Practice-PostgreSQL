-- Creating the table customer:
CREATE TABLE customer (
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	email VARCHAR(60) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	company VARCHAR (60) NULL,
	street VARCHAR(50) NOT NULL,
	city VARCHAR(20) NOT NULL,
	state CHAR(2) NOT NULL DEFAULT 'PA',
	zip SMALLINT NOT NULL,
	birth_date DATE NULL,
	sex CHAR(1) NOT NULL,
	date_entered TIMESTAMP NOT NULL,
	id SERIAL PRIMARY KEY
);

-- Inserting into customer:
INSERT INTO customer (first_name, last_name, email, phone, company, street, city, state, zip, birth_date, sex, date_entered)
VALUES 
	('Ritviz', 'Mishra', '1822mritviz@aj.com', '222-333-4441', 'AJ', '345 - Block A', 'Greater Noida', 'UP', 20134, '2000-09-20', 'M', CURRENT_TIMESTAMP),
	('Virat', 'Kohli', 'viratkohli@bcci.com', '333-222-1119', 'BCCI', '182 - Block C', 'Mumbai', 'MH', 30982, '1988-11-05', 'M', CURRENT_TIMESTAMP),
	('Ava', 'Thompson', 'ava.thompson@gmail.com', '555-123-4567', 'Thompson Ltd.', '123 Maple St', 'Harrisburg', 'NY', 17101, '1992-04-15', 'F', CURRENT_TIMESTAMP),
	('Liam', 'Rodriguez', 'liam.rod@yahoo.com', '555-987-6543', NULL, '45 Oak Ave', 'Lancaster', 'CA', 17601, '1988-07-22', 'M', CURRENT_TIMESTAMP),
	('Noah', 'Patel', 'noah.patel@outlook.com', '555-222-3344', 'Patel Inc.', '789 Birch Rd', 'Erie', 'TX', 16501, '1995-03-11', 'M', CURRENT_TIMESTAMP),
	('Emma', 'Nguyen', 'emma.nguyen@zoho.com', '555-111-2233', NULL, '321 Pine Blvd', 'Scranton', 'FL', 18503, '1990-12-05', 'F', CURRENT_TIMESTAMP),
	('Sophia', 'Green', 's.green@icloud.com', '555-333-4455', 'Green Tech', '654 Willow Way', 'Bethlehem', 'WA', 18015, '1993-09-17', 'F', CURRENT_TIMESTAMP),
	('James', 'Carter', 'j.carter@protonmail.com', '555-777-8899', NULL, '888 Cedar Dr', 'Reading', 'IL', 19601, '1985-11-03', 'M', CURRENT_TIMESTAMP),
	('Olivia', 'Kim', 'oliviakim@hotmail.com', '555-000-1122', 'Kim Enterprises', '159 Spruce Ln', 'York', 'OH', 17401, '1996-06-28', 'F', CURRENT_TIMESTAMP),
	('Lucas', 'Brown', 'lucas.b@aol.com', '555-444-5566', NULL, '987 Elm St', 'Allentown', 'MI', 18101, '1991-08-19', 'M', CURRENT_TIMESTAMP),
	('Mia', 'Davis', 'mia_davis@live.com', '555-666-7788', 'Davis Designs', '246 Aspen Ct', 'Altoona', 'CO', 16601, '1994-10-10', 'F', CURRENT_TIMESTAMP),
	('Ethan', 'Martinez', 'ethan.m@msn.com', '555-889-9001', NULL, '111 Fir St', 'Chester', 'GA', 19013, '1989-01-25', 'M', CURRENT_TIMESTAMP);

-- Viewing the table content:
SELECT * FROM customer;

-- Creating custom data type using ENUM:
CREATE TYPE sex_type AS ENUM ('M', 'F');

-- Using custom data type:
ALTER TABLE customer
ALTER COLUMN sex TYPE sex_type USING sex::sex_type;





