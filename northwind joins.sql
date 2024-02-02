--employees AND their boss
--suppliers and customers addresses
--list categories and number of products
--ship country and total sales
--top 10 orders by total sales
--top 10 customers by items purchased
--shippers who have shipped no orders

--employees AND their boss
-- self join! 
SELECT e.first_name, e.last_name, e.title,
b.last_name AS supervisor, b.title
FROM employees e
LEFT JOIN employees b
ON e.reports_to = b.employee_id 


--1 list of suppliers and customers addresses
SELECT company_name, contact_name, 
address, city, country, 'customer' AS type
FROM customers
UNION
SELECT company_name, contact_name, 
address, city, country, 'supplier' AS type 
FROM suppliers

-- LIST order_id and their totals
SELECT o.order_id, sum(od.unit_price*od.quantity*(1-od.discount)) 
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id 
GROUP BY o.order_id 