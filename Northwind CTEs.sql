-- total order amount per order id
SELECT o.order_id, sum(od.unit_price* od.quantity* (1-od.discount))
FROM orders o
JOIN order_details od 
ON o.order_id = od.order_id 
GROUP BY o.order_id 

-- total number of items in each order 
SELECT o.order_id, sum(od.quantity)
FROM orders o
JOIN order_details od 
ON o.order_id = od.order_id 
GROUP BY o.order_id 

-- average total by ship country
WITH order_totals AS 
(
SELECT o.ship_country, sum(od.unit_price* od.quantity* (1-od.discount)) AS order_sum
FROM orders o
JOIN order_details od 
ON o.order_id = od.order_id 
GROUP BY o.ship_country
) 
SELECT avg(order_sum) FROM order_totals

-- what is the average order total $ in Prague ? 
-- what is the average shipment size (# items) to Brazil?  
-- what is the max shipment size (# items) by continent?  
