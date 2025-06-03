-- Creating sales person table:
CREATE TABLE sales_person (
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
	sex sex_type NOT NULL,
	date_hired TIMESTAMP NOT NULL,
	id SERIAL PRIMARY KEY
);

-- Inserting into the salesperson table:
INSERT INTO sales_person (first_name, last_name, email, phone, company, street, city, state, zip, birth_date, sex, date_hired)
VALUES
	('Harper', 'Wells', 'harper.w@outlook.com', '555-321-6789', 'Wells & Co.', '210 Oak St', 'Phoenix', 'AZ', 5001, '1991-03-10', 'F', CURRENT_TIMESTAMP),
	('Jackson', 'Lee', 'j.lee@gmail.com', '555-234-5678', NULL, '89 Elm Ave', 'Columbus', 'OH', 3004, '1987-11-05', 'M', CURRENT_TIMESTAMP),
	('Chloe', 'Adams', 'chloe.adams@icloud.com', '555-678-1234', 'Adams Supplies', '452 Maple Dr', 'Boulder', 'CO', 3301, '1992-06-23', 'F', CURRENT_TIMESTAMP),
	('Ethan', 'Brooks', 'ethanb@yahoo.com', '555-888-9900', NULL, '123 Cedar Blvd', 'Portland', 'OR', 7201, '1985-09-17', 'M', CURRENT_TIMESTAMP),
	('Grace', 'Miller', 'grace.m@zoho.com', '555-111-3344', 'Miller Textiles', '67 Birch Ln', 'Austin', 'TX', 3301, '1994-04-12', 'F', CURRENT_TIMESTAMP),
	('Aiden', 'Nguyen', 'a.nguyen@live.com', '555-456-7890', NULL, '980 Willow St', 'Charlotte', 'NC', 8202, '1990-07-29', 'M', CURRENT_TIMESTAMP),
	('Ella', 'Perez', 'ella.p@protonmail.com', '555-777-6543', 'Perez Ventures', '32 Spruce Ct', 'Tampa', 'FL', 3602, '1993-01-16', 'F', CURRENT_TIMESTAMP),
	('Logan', 'Ward', 'loganward@hotmail.com', '555-222-4444', NULL, '789 Poplar Way', 'Madison', 'WI', 5703, '1989-08-08', 'M', CURRENT_TIMESTAMP),
	('Scarlett', 'King', 'scarlett.king@aol.com', '555-999-1212', 'King Distribution', '145 Redwood Rd', 'Denver', 'CO', 8202, '1995-12-01', 'F', CURRENT_TIMESTAMP),
	('Benjamin', 'Scott', 'benscott@msn.com', '555-333-7891', NULL, '246 Aspen Dr', 'Reno', 'NV', 8501, '1986-10-22', 'M', CURRENT_TIMESTAMP);

-- Viewing the saleperson table:
SELECT * FROM sales_person;



		