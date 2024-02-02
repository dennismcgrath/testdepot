-- product, price, category, and avg price for that category
SELECT p.product_name, p.unit_price, c.category_name, 
avg(p.unit_price) OVER (PARTITION BY c.category_name)
FROM products p 
JOIN categories c ON c.category_id = p.category_id 


-- category with the maximum average unit_price 

WITH avg_cat_price AS 
(
SELECT c.category_name, avg(p.unit_price) AS avg_unit_price
FROM categories c 
JOIN products p ON p.category_id = c.category_id 
GROUP BY c.category_name 
)
SELECT max(avg_unit_price)
FROM avg_cat_price

-- select products with above average unit price
SELECT product_name, unit_price  FROM products p 
WHERE unit_price > (SELECT avg(unit_price) FROM products) 