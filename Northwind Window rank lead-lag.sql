-- list product, unit price 
-- category, and avg price by category

SELECT p.product_name, p.unit_price, c.category_name,
AVG(p.unit_price) OVER (PARTITION BY c.category_name)
FROM products p 
JOIN categories c 
ON p.category_id = c.category_id 

-- rank products within category by price
SELECT p.product_name, p.unit_price, c.category_name,
RANK() OVER (PARTITION BY c.category_name ORDER BY p.unit_price DESC)
FROM products p 
JOIN categories c 
ON p.category_id = c.category_id

-- dense rank products within category by price
SELECT p.product_name, p.unit_price, c.category_name,
DENSE_RANK() OVER (PARTITION BY c.category_name ORDER BY p.unit_price DESC)
FROM products p 
JOIN categories c 
ON p.category_id = c.category_id

-- row_number (unique) rank products within category by price
SELECT p.product_name, p.unit_price, c.category_name,
row_number() OVER (PARTITION BY c.category_name ORDER BY p.unit_price DESC)
FROM products p 
JOIN categories c 
ON p.category_id = c.category_id

-- quartile of products within category by price
SELECT p.product_name, p.unit_price, c.category_name,
NTILE(4) OVER (ORDER BY p.unit_price DESC) AS quartile
FROM products p 
JOIN categories c 
ON p.category_id = c.category_id

-- decile of products within category by price
SELECT p.product_name, p.unit_price, c.category_name,
NTILE(10) OVER (ORDER BY p.unit_price DESC) AS decile
FROM products p 
JOIN categories c 
ON p.category_id = c.category_id


-- orders by date/time
SELECT order_date, count(o.order_id),
lag(count(o.order_id)) OVER (ORDER BY order_date) AS previous_day,
lead(count(o.order_id)) OVER (ORDER BY order_date) AS next_day
FROM orders o 
JOIN order_details od ON od.order_id = o.order_id 
GROUP BY order_date
ORDER BY 1 

