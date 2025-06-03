--  Creating a table to record the sales:
CREATE TABLE sales_item (
	item_id INT REFERENCES item(id),
	sales_order_id INT REFERENCES sales_order(id),
	qty INT NOT NULL,
	discount NUMERIC(3,2) NULL DEFAULT 0,
	taxable BOOLEAN NOT NULL DEFAULT FALSE,
	sales_tax_rate NUMERIC(5,2) NOT NULL DEFAULT 0,
	id SERIAL PRIMARY KEY
);

-- Recording the day of the order:
ALTER TABLE sales_item ADD day_of_week VARCHAR(10);

-- Making recording day compulsory:
ALTER TABLE sales_item
ALTER COLUMN day_of_week SET NOT NULL;

-- Changing the name of the day_of_week:
ALTER TABLE sales_item
RENAME COLUMN day_of_week TO weekday;

-- Deleting weekday column:
ALTER TABLE sales_item
DROP COLUMN weekday;

-- Adding records to the sales made:
INSERT INTO sales_item (item_id, sales_order_id, qty, discount, taxable, sales_tax_rate) 
VALUES
	(12, 1, 3, 5.00, true, 10.0),
	(37, 7, 2, 0.00, false, 0.0),
	(21, 20, 1, 2.50, true, 8.0),
	(45, 16, 4, 3.00, true, 8.0),
	(7, 3, 3, 1.00, true, 12.0),
	(19, 25, 2, 0.00, false, 0.0),
	(33, 8, 1, 9.99, true, 15.0),
	(26, 40, 4, 0.00, true, 10.0),
	(44, 43, 3, 4.00, false, 0.0),
	(11, 30, 1, 0.00, true, 12.5),
	(29, 21, 2, 2.00, true, 12.5),
	(3, 39, 4, 3.50, false, 0.0),
	(50, 6, 1, 0.00, true, 10.0),
	(8, 49, 3, 1.00, true, 10.0),
	(14, 37, 2, 0.00, false, 0.0),
	(41, 12, 1, 2.00, true, 8.0),
	(6, 17, 3, 0.00, true, 12.0),
	(20, 31, 4, 1.00, false, 0.0),
	(15, 41, 2, 5.00, true, 15.0),
	(10, 19, 1, 0.00, true, 10.0),
	(31, 4, 4, 3.00, false, 0.0),
	(25, 45, 3, 1.00, true, 12.5),
	(9, 23, 1, 0.00, true, 12.5),
	(38, 11, 2, 0.00, false, 0.0),
	(18, 44, 3, 2.00, true, 10.0),
	(16, 15, 1, 0.00, true, 10.0),
	(27, 29, 2, 0.00, false, 0.0),
	(23, 28, 3, 1.50, true, 8.0),
	(13, 22, 4, 0.00, true, 12.0),
	(1, 9, 2, 0.00, false, 0.0),
	(32, 34, 3, 4.00, true, 15.0),
	(39, 18, 1, 0.00, true, 10.0),
	(46, 38, 4, 0.00, false, 0.0),
	(22, 26, 3, 3.00, true, 12.5),
	(5, 13, 2, 0.00, true, 12.5),
	(48, 27, 1, 0.00, false, 0.0),
	(24, 2, 4, 1.00, true, 10.0),
	(2, 36, 3, 0.00, true, 10.0),
	(17, 33, 2, 0.00, false, 0.0),
	(34, 14, 4, 2.50, true, 8.0),
	(30, 10, 1, 0.00, true, 12.0),
	(40, 24, 3, 0.00, false, 0.0),
	(4, 42, 2, 5.00, true, 15.0),
	(28, 32, 1, 0.00, true, 10.0),
	(43, 46, 4, 1.00, false, 0.0),
	(42, 5, 3, 0.00, true, 12.5),
	(35, 35, 2, 0.00, true, 12.5),
	(36, 48, 4, 3.00, false, 0.0),
	(47, 38, 1, 0.00, true, 10.0);


-- Viewing the orders dispacthed:
SELECT * FROM sales_item;