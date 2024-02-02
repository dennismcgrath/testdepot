SELECT * FROM employees e 

-- concat title, firstname, lastname
SELECT title_of_courtesy, first_name, last_name  
FROM employees e 

SELECT title_of_courtesy || first_name || last_name  
FROM employees e 

SELECT title_of_courtesy || ' '|| first_name || ' ' || last_name  
FROM employees e

SELECT concat(title_of_courtesy,' ', first_name, ' ', last_name)
FROM employees 
--
SELECT product_name, substring(product_name, 13,7) FROM products
WHERE product_name LIKE ('%Organic%')

-- LEFT RIGHT
SELECT customer_id FROM customers

SELECT LEFT(customer_id,3) FROM customers

SELECT RIGHT(customer_id,3) FROM customers

-- TRIM LTRIM RTRIM REPLACE
SELECT company_name, fax FROM customers

SELECT company_name, trim(fax,'(') FROM customers 

SELECT company_name, replace(fax,')',' ') FROM customers 

-- UPPER LOWER

SELECT company_name FROM customers 

SELECT UPPER(company_name) FROM customers 

SELECT LOWER(company_name) FROM customers 

-- Casting and rounding 

SELECT employee_id FROM employees e 

SELECT CAST(employee_id AS varchar) FROM employees e 

SELECT ROUND(3.14159, 2)

SELECT ROUND(3.14159, 4)

SELECT order_id, round(CAST(sum(quantity*unit_price*(1-discount)) AS numeric), 2)
FROM order_details od
GROUP BY order_id

