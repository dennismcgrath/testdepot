-- use Northwind

-- list categories and # products (count) in that category
SELECT c.category_name, count(p.product_id) FROM categories c 
JOIN products p 
ON p.category_id = c.category_id
GROUP BY c.category_name


-- list employees (firstname, lastname) and their age in years
SELECT first_name, last_name, date_part('year',age(now(),birth_date) ) FROM employees

-- suppliers and the products they sell
SELECT s.company_name, p.product_name  FROM suppliers s
JOIN products p ON s.supplier_id = p.supplier_id 

-- sales (total $) in the US by region
SELECT o.ship_region, sum(od.quantity*od.unit_price*(1-od.discount)) 
FROM orders o
JOIN order_details od 
ON o.order_id = od.order_id 
WHERE o.ship_country = 'USA'
GROUP BY o.ship_region


-- categories and total $ sold for that category
SELECT c.category_name, sum(od.quantity*od.unit_price*(1-od.discount))  FROM categories c 
JOIN products p 
ON p.category_id = c.category_id 
JOIN order_details od 
ON od.product_id = p.product_id 
GROUP BY c.category_name 

-- shippers and the # orders (count) shipped (including 0s)
SELECT s.company_name, count(o.order_id) FROM shippers s 
LEFT JOIN orders o 
ON o.ship_via = s.shipper_id
GROUP BY s.company_name 

-- list # orders by ship country (descending by count of orders)
SELECT o.ship_country, count(o.order_id) FROM orders o
GROUP BY o.ship_country
ORDER BY 2 desc

-- list continent and total $ sold (round to 2 decimals) use case/when
SELECT  
CASE 
	WHEN o.ship_country IN ('Argentina', 'Brazil', 'Venezuela') THEN 'South America'
	WHEN o.ship_country IN ('USA', 'Canada', 'Mexico') THEN 'North America'
	ELSE 'Europe'
END AS Continent, 
sum(od.quantity*od.unit_price*(1-od.discount))
FROM orders o 
JOIN order_details od 
ON od.order_id = o.order_id 
group BY 1



