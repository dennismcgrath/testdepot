
-- list product, unit price, category 
-- and the average unit price of that category

SELECT p.product_name, 
round(CAST(p.unit_price AS NUMERIC), 2), 
c.category_name,  
round(CAST(avg(p.unit_price) OVER (PARTITION BY c.category_name)AS NUMERIC),2)
FROM products p
JOIN categories c 
ON c.category_id = p.category_id 


-- list the product, the total $ spent on that product
-- the product category, and the total $ spent on that category
-- we need a CTE first to get the $ spent by product 
WITH product_total AS 
(
SELECT p.product_name, 
round (CAST(sum(od.unit_price * od.quantity * (1-od.discount)) AS NUMERIC),2) AS total, 
c.category_name 
FROM order_details od
JOIN products p 
ON p.product_id = od.product_id 
JOIN categories c 
ON p.category_id = c.category_id 
GROUP BY product_name, c.category_name 
)
SELECT product_name, total, category_name, 
sum(total) OVER (PARTITION BY category_name) AS category_total
FROM product_total


-- list the order_id, the freight, the shipper name, 
-- and the total freight shipped via that shipper 


-- list the order_id, the order total $, the shipper name
-- and the total value in $ sent via that shipper 