-- exporting ... use the BOM flag! 
SELECT DISTINCT product_name 
FROM products p 

-- Subquery in the WHERE clause
SELECT product_name, reorder_level  
FROM products p 
WHERE reorder_level = (SELECT max(reorder_level) FROM products)
ORDER BY reorder_level DESC

-- Subquery in the FROM 
-- what's the average # products per category? 
SELECT avg(prod_count) AS avg_product_count 
FROM 
(SELECT c.category_name, count(p.product_id) AS prod_count
FROM categories c 
JOIN products p 
ON p.category_id = c.category_id 
GROUP BY c.category_name) AS product_count

-- Subquery in the SELECT 
-- count orders by shipping company
SELECT s.company_name, count(o.order_id) 
FROM shippers s 
LEFT JOIN orders o 
ON o.ship_via = s.shipper_id 
GROUP BY s.company_name 

SELECT s.company_name, 
(SELECT count(*) FROM orders o WHERE o.ship_via = s.shipper_id)
FROM shippers s 
