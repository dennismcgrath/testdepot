WITH all_revenue AS
(
SELECT c.company_name, c.country,
sum(od.unit_price*od.quantity*(1-od.discount)) AS customer_revenue
FROM customers c
LEFT JOIN orders o
ON o.customer_id = c.customer_id
JOIN order_details od
ON od.order_id = o.order_id
GROUP BY c.company_name, c.country
)
SELECT company_name, country, customer_revenue,
sum(customer_revenue) OVER (PARTITION BY country) AS total_country_revenue
FROM all_revenue
ORDER BY total_country_revenue DESC, country