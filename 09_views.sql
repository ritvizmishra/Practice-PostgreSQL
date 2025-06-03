CREATE VIEW purchase_order_overview AS
SELECT sales_order.purchase_order_num, CONCAT(customer.first_name,' ',customer.last_name) AS customer, 
		sales_item.qty, product.supplier, product.name,
		item.price, (sales_item.qty * item.price) AS total,
		CONCAT(sales_person.first_name,' ',sales_person.last_name) AS salesperson
FROM sales_order
JOIN sales_item ON sales_item.sales_order_id = sales_order.id
JOIN item ON item.id = sales_item.item_id
JOIN customer ON sales_order.customer_id = customer.id
JOIN product ON product.id = item.product_id
JOIN sales_person ON sales_person.id = sales_order.sales_person_id
ORDER BY sales_order.purchase_order_num;

DROP VIEW purchase_order_overview;

SELECT * FROM purchase_order_overview;
