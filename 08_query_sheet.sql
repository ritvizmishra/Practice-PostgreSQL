-- Finding products with discounts greater than or equal to 3.00:
SELECT sales_item.item_id, sales_item.qty, product.name, sales_item.discount, item.size, item.color, item.price
FROM sales_item
JOIN item
ON sales_item.item_id = item.id
JOIN product
ON item.product_id = product.id
WHERE discount >= 3.00
ORDER BY discount ASC;

-- Finding the date of all the orders in May 2025:
SELECT purchase_order_num, DATE(time_order_taken)
FROM sales_order
WHERE EXTRACT(MONTH FROM time_order_taken) = 05
	AND EXTRACT(YEAR FROM time_order_taken) = 2025;

-- Returning name of the customer in a single field along with the contact details and state:
SELECT CONCAT(first_name, ' ', last_name) AS name, phone, email, state
FROM customer;

-- Finding the total cost of different types of shoes in our inventory:
SELECT product_type.product_name, SUM(item.price) as total_price
FROM product_type 
JOIN product 
ON product_type.id = product.type_id
JOIN item
ON product.id = item.product_id
GROUP BY product_type.product_name;

-- List of states we have customers in:
SELECT DISTINCT state FROM customer;

-- Find all items ordered with their customer's name:
SELECT CONCAT(customer.first_name,' ', customer.last_name) as name, sales_order.purchase_order_num, 
		DATE(sales_order.time_order_taken)
FROM sales_order
JOIN customer ON sales_order.customer_id = customer.id
ORDER BY name;

-- Find out how many orders a customer placed:
SELECT CONCAT(customer.first_name,' ', customer.last_name) as name, COUNT(sales_order.purchase_order_num)
FROM sales_order
JOIN customer ON sales_order.customer_id = customer.id
GROUP BY name
ORDER BY name;

-- List all customers and any orders they may have placed. Include customers who haven’t placed any orders yet:
SELECT CONCAT(customer.first_name,' ', customer.last_name) as name, sales_order.purchase_order_num
FROM customer
LEFT JOIN sales_order ON sales_order.customer_id = customer.id;

-- Show all products and their corresponding item details, even if some products don’t have any items listed yet:
SELECT product.name, item.size, item.color, item.price
FROM product
LEFT JOIN item ON product.id = item.product_id;

-- Find out customer details with the respective salesperson:
SELECT first_name, birth_date, city 
FROM customer
WHERE EXTRACT(MONTH FROM birth_date) = 09 
UNION
SELECT first_name, birth_date, city
FROM sales_person
WHERE EXTRACT(MONTH FROM birth_date) = 09;

-- Find matching pattern:
-- #1: starting with Ma
SELECT first_name, last_name
FROM customer
WHERE last_name ~ '^Ma';

-- #2: ending with ez
SELECT first_name, last_name
FROM customer
WHERE last_name ~ 'ez$';

-- #3: ending with ez or son
SELECT first_name, last_name
FROM customer
WHERE last_name ~ 'ez|son';

-- #4: contains w/x/y/z
SELECT first_name, last_name
FROM customer
WHERE last_name ~ '[w-z]';

-- Find the number of months in which more than 1 customer has a birthday:
SELECT EXTRACT(MONTH FROM birth_date) AS month, COUNT(*) AS persons
FROM customer
GROUP BY month HAVING COUNT(*) > 1;

-- Describe items on various parameters:
SELECT COUNT(*) AS Items, SUM(price) AS Value, MAX(price) AS Max, MIN(price) AS Min, ROUND(AVG(price), 2) AS Average
FROM item;






