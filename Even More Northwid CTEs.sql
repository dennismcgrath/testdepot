

-- what is the average order total $ in Paris ? 
WITH order_totals AS 
(
SELECT o.order_id, o.ship_city,
sum(od.unit_price* od.quantity* (1-od.discount)) AS total
FROM orders o
JOIN order_details od 
ON o.order_id = od.order_id 
GROUP BY o.order_id 
)
SELECT ship_city, round(CAST(avg(total) AS NUMERIC),2) AS avg_order
FROM order_totals 
WHERE ship_city = 'Paris'
GROUP BY ship_city 

-- what is the average shipment size (# items) to Brazil?  
WITH order_size AS 
(
SELECT o.order_id, o.ship_country, sum(od.quantity) AS items
FROM orders o
JOIN order_details od 
ON o.order_id = od.order_id 
GROUP BY o.order_id 
)
SELECT ship_country, CAST(avg(items) AS integer) AS avg_items
FROM order_size
WHERE ship_country = 'Brazil'
GROUP BY 1


-- what is the max shipment size (# items) by continent?  
WITH continent_orders AS 
(
SELECT o.order_id, o.ship_country,
CASE 
	WHEN o.ship_country IN ('USA', 'Canada', 'Mexico') THEN 'North America'
	WHEN o.ship_country IN ('Argentina', 'Brazil', 'Venezuela') THEN 'South America'
	ELSE 'Europe'
END AS continent,
sum(od.quantity) AS items
FROM orders o
JOIN order_details od 
ON o.order_id = od.order_id 
GROUP BY o.order_id 
) 
SELECT continent, max(items) AS max_order_size
FROM continent_orders
GROUP BY continent



-- using alternate column notation
SELECT o.order_id, o.ship_country, sum(od.quantity) AS items
FROM orders o
JOIN order_details od 
ON o.order_id = od.order_id 
GROUP BY 1
ORDER BY 3 DESC




