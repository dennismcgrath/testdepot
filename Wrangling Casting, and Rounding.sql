-- use the Northwind database
SELECT company_name FROM shippers s 

-- Trim spaces from the left
SELECT LTRIM(company_name) FROM shippers

-- Trim spaces from the right
SELECT RTRIM(company_name,'-In ') FROM shippers

-- Trim spaces from both ends
SELECT TRIM(company_name) FROM shippers

-- All upper case
SELECT UPPER(company_name) FROM shippers

-- All lower case
SELECT LOWER(company_name) FROM shippers

-- Proper (first letter capitalized)
SELECT TRIM(INITCAP(company_name)) FROM shippers

-- combine strings into one
SELECT customer_id FROM customers
SELECT CONCAT(customer_id, ' ', contact_name) FROM customers c  
SELECT customer_id||' '||contact_name FROM customers

-- look at all those decimals! 
SELECT unit_price FROM order_details

-- round to 0 decimals
SELECT round(unit_price) FROM order_details 

-- Try to round to 2 decimals
SELECT round(unit_price, 2) FROM order_details 

SELECT CAST(unit_price AS numeric) FROM order_details 


-- Use cast() with round()
SELECT round(CAST(unit_price AS numeric), 2) FROM order_details 

-- List sales by category for each order 
-- taking into account the discount!!
SELECT od.order_id, c.category_name, od.unit_price*quantity*(1-od.discount) AS total_price
FROM categories c 
JOIN products p ON p.category_id = c.category_id 
JOIN order_details od ON od.product_id = p.product_id 



-- List sales by category for each order 
-- taking into account the discount and ROUND the result
SELECT od.order_id, c.category_name, ROUND(od.unit_price*quantity*(1-od.discount)) AS total_price
FROM categories c 
JOIN products p ON p.category_id = c.category_id 
JOIN order_details od ON od.product_id = p.product_id 

-- List sales by category for each order 
-- taking into account the discount and ROUND the result to 2 DECIMAL PLACES
SELECT od.order_id, c.category_name, 
ROUND(CAST(od.unit_price*quantity*(1-od.discount)AS numeric), 2) AS total_price
FROM categories c 
JOIN products p ON p.category_id = c.category_id 
JOIN order_details od ON od.product_id = p.product_id 



-- Calculate total Sales $$ for each product category 
-- taking into account the discount!!





SELECT  s.company_name,  
ROUND(CAST(sum(od.unit_price*quantity*(1-od.discount))AS numeric), 2) AS total_price
FROM shippers s  
LEFT JOIN orders o ON o.ship_via = s.shipper_id 
LEFT JOIN order_details od ON od.order_id = o.order_id 
GROUP BY  s.company_name
