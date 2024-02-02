--List categories and their associated products and suppliers
--How many products are there for each category?
--are there any suppliers that have no products?
--List customer company name and their total number of orders
--List customer company and their total dollars spent including discount
--List the average of total dollars spent by each country including discount.  Also add a column for  ‘continent’. 
 
--List categories and their associated products and suppliers

SELECT c.category_name, p.product_name, s.company_name  
FROM categories c 
JOIN products p ON p.category_id = c.category_id 
JOIN suppliers s ON s.supplier_id = p.supplier_id 
ORDER BY 1
 
--How many products are there for each category?

SELECT c.category_name, count(p.product_name)   
FROM categories c 
JOIN products p ON p.category_id = c.category_id 
GROUP BY 1
ORDER BY 1 

--are there any suppliers that have no products?

 SELECT s.company_name, count(p.product_id) FROM suppliers s 
 LEFT JOIN products p ON p.supplier_id = s.supplier_id 
 GROUP BY s.company_name 
 
 --List customer company name and their total number of orders
 SELECT c.company_name, count(o.order_id) FROM customers c 
 JOIN orders o ON o.customer_id = c.customer_id 
 GROUP BY c.company_name 
 
 
 
 --List customer company and their total dollars spent including discount
SELECT c.company_name, round(CAST(sum(od.unit_price*od.quantity*(1-od.discount)) AS NUMERIC),2)
FROM order_details od 
JOIN orders o ON od.order_id = o.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.company_name
ORDER BY 2 desc

-- total by country
SELECT c.company_name, c.country, sum(od.unit_price*od.quantity*(1-od.discount))
FROM order_details od 
JOIN orders o ON od.order_id = o.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.company_name, c.country


--average of country totals
WITH country_totals AS 
(
SELECT c.company_name, c.country, sum(od.unit_price*od.quantity*(1-od.discount))
FROM order_details od 
JOIN orders o ON od.order_id = o.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.company_name, c.country
)
SELECT avg(sum) FROM country_totals


--Average total by continent? 
WITH customer_total AS 
(
SELECT c.country, sum(od.unit_price*od.quantity*(1-od.discount))
FROM order_details od 
JOIN orders o ON od.order_id = o.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.country
)
SELECT 
CASE 
	WHEN country IN ('UK', 'Spain', 'Sweden', 'Germany', 'Portugal', 'Belgium', 'Austria',
	'Norway', 'Denmark', 'Finland', 'Italy', 'France', 'Ireland', 'Switzerland', 'Poland')
	THEN 'Europe'
	WHEN country IN ('USA', 'Canada', 'Mexico') THEN 'North America'
	WHEN country IN ('Brazil', 'Venezuela', 'Argentina') Then 'South America'
	ELSE 'Asia'
END AS continent, 
round(CAST(avg(sum) AS NUMERIC),2)
FROM customer_total 
GROUP BY continent
 

SELECT DISTINCT country FROM customers c 