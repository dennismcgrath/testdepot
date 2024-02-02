SELECT title, length FROM film

-- plain old aggregate
SELECT avg(length) FROM film 

-- aggregate with GROUP BY
SELECT rating, round(avg(length),2) FROM film
GROUP BY rating

-- individual film and length, rating, 
-- avg length for that rating
SELECT title, length, rating, 
round(AVG(length) OVER(PARTITION BY rating),1) AS avg_length_rating
FROM film

-- partition over nothing gives us the 
-- average for all films 
SELECT title, length,
round(AVG(length) OVER(),1) AS avg_length
FROM film

-- avg length - partition by film category 
SELECT f.title, f.length, c.name, 
round( AVG(length) OVER(PARTITION BY c.name),1)
FROM film f 
JOIN film_category fc ON fc.film_id = f.film_id 
JOIN category c ON c.category_id = fc.category_id 

-- max length - partition by film category 
SELECT f.title, f.length, c.name, 
round( MAX(length) OVER(PARTITION BY c.name),1) AS max_length
FROM film f 
JOIN film_category fc ON fc.film_id = f.film_id 
JOIN category c ON c.category_id = fc.category_id 


-- customers and their payment amounts 
SELECT c.last_name, p.amount  FROM customer c
JOIN payment p ON p.customer_id = c.customer_id 

-- list of customers, payments, and the total of 
-- payments for that customer
SELECT c.last_name, p.payment_date, p.amount, 
sum(p.amount) OVER (PARTITION BY c.customer_id)
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id 

-- list of customers, their total payments
-- and the the total payments for their country 
WITH customer_total AS 
(
SELECT c.last_name, co.country, sum(p.amount) AS cust_total 
FROM customer c 
JOIN payment p ON p.customer_id = c.customer_id 
JOIN address a ON a.address_id = c.address_id 
JOIN city ct ON ct.city_id = a.city_id 
JOIN country co ON co.country_id = ct.country_id 
GROUP BY c.customer_id, co.country
)
SELECT last_name, cust_total, country,
sum(cust_total) OVER (PARTITION BY country) AS country_total
FROM customer_total
