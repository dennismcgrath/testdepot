-- count customers in each country
SELECT country, count(customer_id) FROM customers 
GROUP BY country 
ORDER BY count(customer_id) DESC 
LIMIT 5

--top 10 countries BY # OF orders 
SELECT ship_country, count(*) FROM orders
GROUP BY ship_country
ORDER BY count(*) DESC 
LIMIT 10

--top 5 cities in Germany by # orders
SELECT ship_city, count(order_id) AS order_count
FROM orders 
WHERE ship_country = 'Germany'
GROUP BY ship_city
ORDER BY order_count DESC 
LIMIT 5

-- how many products do we have for each category
-- for those categories with at least 10 products
SELECT category_id, count(product_id) 
FROM products
GROUP BY category_id
HAVING count(product_id) >= 10
ORDER BY category_id 