
-- categories, and count of products per category 
SELECT c.category_name, count(p.product_id) AS product_count
FROM products p 
JOIN categories c 
ON p.category_id = c.category_id 
GROUP BY c.category_name
ORDER BY 2 DESC

-- Write a query that will list all of  
-- order IDs, ship city, ship country, 
-- and continent for orders over 100 lbs (freight)
SELECT order_id, ship_city, ship_country, 
CASE 
	WHEN ship_country IN ('USA','Canada', 'Mexico') THEN 'North America'
	WHEN ship_country IN ('Venezuela', 'Brazil', 'Argentine') THEN 'South America'
	ELSE 'Europe'
END
FROM orders
WHERE freight > 100

--Write a query that will determine the top 5 countries 
--measured by total items (sum of quantity) sold by shipping country.  
SELECT o.ship_country, sum(od.quantity) AS items
FROM order_details od 
JOIN orders o 
ON o.order_id = od.order_id 
GROUP BY o.ship_country 
ORDER BY items desc
LIMIT 5

-- Write a query that determines the average order size  (# items) 
-- for each shipping company.  Include shipping companies that have 
-- never shipped anything 
WITH order_tally AS 
(
SELECT o.order_id, sum(od.quantity) AS items,
s.company_name 
FROM order_details od 
RIGHT JOIN orders o 
ON o.order_id = od.order_id 
RIGHT JOIN shippers s 
ON s.shipper_id = o.ship_via 
GROUP BY o.order_id, s.company_name 
)
SELECT company_name, 
CASE 
	WHEN avg(items) IS NULL THEN 0
	ELSE avg(items)
END AS items_shipped
FROM order_tally
GROUP BY company_name
ORDER BY 2 DESC


--Write a query that lists all the order amounts, 
--their shipping country, and total amount of revenue from that country. 
WITH order_totals AS 
(
SELECT o.order_id, o.ship_country,
sum(od.quantity*od.unit_price*(1-od.discount)) AS total
FROM order_details od 
JOIN orders o 
ON o.order_id = od.order_id 
GROUP BY o.order_id
) 
SELECT *, sum(total) OVER (PARTITION BY ship_country) AS country_sum
FROM order_totals
