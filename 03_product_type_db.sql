-- Creating product type table:
CREATE TABLE product_type (
	product_name VARCHAR(20) NOT NULL,
	id SERIAL PRIMARY KEY
);

-- Populating product type table:
INSERT INTO product_type (product_name)
VALUES 
('Business'),
('Casual'),
('Sports'),
('Formal'),
('Loafers'),
('Sneakers'),
('Boots'),
('Sandals'),
('Oxfords'),
('Slip-ons');

-- Viewing product type table:
SELECT * FROM product_type;
