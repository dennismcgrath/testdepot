-- on what dates did we get most orders? 
-- list top 5
SELECT order_date, freight
FROM orders
WHERE freight = (SELECT max(freight) FROM orders)
ORDER BY 2 DESC

-- catch the tie for MOST!!!
-- what products have the highest reorder level? 
SELECT product_name, reorder_level  
FROM products 
WHERE reorder_level = (SELECT max(reorder_level) FROM products)
ORDER BY 2 DESC

-- average of a count 
-- what is the average # of products per catetory
SELECT avg(prod_count) AS avg_prod_per_category FROM   
(
SELECT c.category_name, count(p.product_id) AS prod_count
FROM categories c
JOIN products p 
ON p.category_id = c.category_id 
GROUP BY c.category_name
) AS prod_count_table

-- subquery instead of join 
-- number of orders by shipping company
SELECT s.company_name, count(o.order_id) FROM shippers s 
LEFT JOIN orders o 
ON o.ship_via = s.shipper_id 
GROUP BY s.company_name 

SELECT s.company_name, 
(SELECT count(*) FROM orders o WHERE o.ship_via = s.shipper_id)
FROM shippers s 

-- list order_ids that are above average weight 
SELECT order_id, round(CAST (freight AS NUMERIC),2), freight - ((SELECT avg(freight) FROM orders )) AS overage
FROM orders
WHERE freight > (SELECT avg(freight) FROM orders )
ORDER BY 2 desc

