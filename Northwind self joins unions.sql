
-- self join to list employee and boss
SELECT e.last_name, b.last_name AS boss 
FROM employees e 
LEFT JOIN employees b
ON e.reports_to = b.employee_id 

-- year end holiday mailing list (customers and employees)
SELECT first_name || ' ' ||last_name AS name,
address,  city, country, 'valued employee' AS type
FROM employees
UNION 
SELECT contact_name, address, city, country, 'valued customer' 
FROM customers 

-- list product categories and associated products
SELECT c.category_name, p.product_name  FROM categories c
JOIN products p 
ON p.category_id = c.category_id 