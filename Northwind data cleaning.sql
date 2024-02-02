-- Northwind data cleaning 

--simple query
SELECT first_name, last_name FROM employees

-- old school concatenation
SELECT first_name || ' ' ||  last_name AS name
FROM employees

-- Postgres concat function
SELECT concat(first_name,' ',last_name) AS name
FROM employees

SELECT concat (title_of_courtesy,' ', first_name,' ', last_name)
FROM employees

-- substring, position, and character_length
SELECT product_name, 
substring(product_name,position('Organic' in product_name),character_length('Organic')) 
FROM products
WHERE product_name LIKE '%Organic%'

-- RIGHT and LEFT
SELECT customer_id, RIGHT(customer_id,3), LEFT(customer_id,3) 
FROM customers c 

-- LTRIM (RTRIM) REPLACE 
SELECT fax, ltrim(fax,'('), REPLACE(fax,')',' ') FROM customers

SELECT fax, ltrim(REPLACE(fax,')',' '),'(') FROM customers

SELECT company_name, upper(company_name), 
lower(company_name),
initcap(customer_id)
FROM customers

--ROUND and CAST
SELECT o.order_id,
round(CAST(od.unit_price * od.quantity * (1-od.discount) AS NUMERIC), 2) AS od_total
FROM orders o
JOIN order_details od 
ON o.order_id = od.order_id 

SELECT o.order_id,
round(CAST(sum(od.unit_price * od.quantity * (1-od.discount)) AS NUMERIC), 2) AS od_total
FROM orders o
JOIN order_details od 
ON o.order_id = od.order_id 
GROUP BY o.order_id


SELECT employee_id, CAST(employee_id AS varchar)  FROM employees



