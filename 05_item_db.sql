-- Creating an items table:
CREATE TABLE item (
	product_id INT REFERENCES product(id),
	size SMALLINT NOT NULL,
	color VARCHAR(20) NOT NULL,
	picture VARCHAR(256) NOT NULL,
	price NUMERIC(6,2) NOT NULL,
	id SERIAL PRIMARY KEY
);

-- Adding a list of the items:
INSERT INTO item (product_id, size, color, picture, price)
VALUES 
	(2, 8, 'Red', 'Coming soon', 199.00),
	(5, 9, 'Black', 'Coming soon', 249.99),
	(7, 10, 'White', 'Coming soon', 179.50),
	(3, 7, 'Brown', 'Coming soon', 220.75),
	(1, 6, 'Tan', 'Coming soon', 205.00),
	(4, 9, 'Grey', 'Coming soon', 189.90),
	(6, 8, 'Navy Blue', 'Coming soon', 210.60),
	(8, 11, 'Olive', 'Coming soon', 198.99),
	(10, 7, 'Maroon', 'Coming soon', 232.30),
	(9, 6, 'Beige', 'Coming soon', 194.45),
	(5, 6, 'Black', 'Coming soon', 189.99),
	(19, 8, 'White', 'Coming soon', 175.50),
	(13, 7, 'Brown', 'Coming soon', 210.25),
	(21, 9, 'Grey', 'Coming soon', 199.00),
	(30, 10, 'Tan', 'Coming soon', 220.00),
	(7, 6, 'Navy', 'Coming soon', 230.45),
	(16, 11, 'Olive', 'Coming soon', 215.80),
	(25, 7, 'Maroon', 'Coming soon', 205.35),
	(8, 9, 'Beige', 'Coming soon', 187.90),
	(33, 8, 'Charcoal', 'Coming soon', 198.99),
	(4, 10, 'Red', 'Coming soon', 201.75),
	(27, 6, 'Mustard', 'Coming soon', 189.50),
	(14, 7, 'Wine', 'Coming soon', 214.99),
	(2, 11, 'Sky Blue', 'Coming soon', 179.25),
	(29, 8, 'Ivory', 'Coming soon', 193.80),
	(17, 9, 'Steel Grey', 'Coming soon', 223.00),
	(22, 10, 'Dusty Rose', 'Coming soon', 209.40),
	(12, 6, 'Chocolate', 'Coming soon', 199.10),
	(10, 7, 'Mint', 'Coming soon', 184.20),
	(31, 8, 'Teal', 'Coming soon', 205.65),
	(6, 9, 'Slate', 'Coming soon', 218.80),
	(23, 7, 'Cobalt', 'Coming soon', 201.00),
	(11, 6, 'Gold', 'Coming soon', 237.70),
	(26, 8, 'Silver', 'Coming soon', 219.99),
	(1, 10, 'Lavender', 'Coming soon', 192.35),
	(3, 11, 'Magenta', 'Coming soon', 206.20),
	(28, 7, 'Amber', 'Coming soon', 209.85),
	(20, 9, 'Rust', 'Coming soon', 188.60),
	(9, 6, 'Copper', 'Coming soon', 195.00),
	(15, 8, 'Peach', 'Coming soon', 202.50),
	(24, 10, 'Burgundy', 'Coming soon', 217.99),
	(32, 11, 'Indigo', 'Coming soon', 189.45),
	(18, 6, 'Lime', 'Coming soon', 198.70),
	(33, 9, 'Coral', 'Coming soon', 208.10),
	(3, 7, 'Cream', 'Coming soon', 213.55),
	(30, 8, 'Forest Green', 'Coming soon', 219.99),
	(2, 10, 'Canary', 'Coming soon', 191.80),
	(13, 11, 'Saffron', 'Coming soon', 204.99),
	(5, 6, 'Turquoise', 'Coming soon', 187.75),
	(6, 7, 'Plum', 'Coming soon', 214.65);

-- Randomizing the product_id
TRUNCATE TABLE item CASCADE;

-- Resetting PK to 1
SELECT pg_get_serial_sequence('item', 'id');
ALTER SEQUENCE item_id_seq RESTART WITH 1;

-- Viewing this table:
SELECT * FROM item;