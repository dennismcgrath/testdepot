-- what films have never been rented? 

-- what films have no inventory? 
SELECT f.title, count(i.inventory_id) FROM film f 
LEFT JOIN inventory i 
ON i.film_id = f.film_id 
WHERE i.inventory_id IS NULL 
GROUP BY f.title
--HAVING count(i.inventory_id) = 0
ORDER BY 2 desc

-- what inventory has no rentals? 
SELECT i.inventory_id, count(r.rental_id) FROM inventory i 
LEFT JOIN rental r 
ON i.inventory_id = r.inventory_id 
GROUP BY i.inventory_id 
HAVING count(r.rental_id) = 0 

-- count the inventory items
SELECT f.title, count(i.inventory_id) FROM film f 
LEFT JOIN inventory i ON i.film_id = f.film_id 
LEFT JOIN rental r ON r.inventory_id = i.inventory_id 
WHERE r.rental_id IS NULL 
GROUP BY f.title
--HAVING count(r.rental_id) = 0
ORDER BY 2

-- count the rentals 
SELECT f.title, count(r.rental_id) FROM film f 
LEFT JOIN inventory i ON i.film_id = f.film_id 
LEFT JOIN rental r ON r.inventory_id = i.inventory_id 
WHERE r.rental_id IS NULL 
GROUP BY f.title
--HAVING count(r.rental_id) = 0
ORDER BY 2


-- how many films have never been rented? 
WITH number_rentals AS 
(
SELECT f.title, count(r.rental_id) FROM film f 
LEFT JOIN inventory i ON i.film_id = f.film_id 
LEFT JOIN rental r ON r.inventory_id = i.inventory_id 
WHERE r.rental_id IS NULL
GROUP BY f.title
ORDER BY 2
)
SELECT count(title) FROM number_rentals

-- which films have produced more revenue than 'Rugrats Shakespeare'
WITH rev_per_film AS 
(
SELECT f.title, sum(p.amount) as total_revenue
FROM film f 
JOIN inventory i ON i.film_id = f.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
JOIN payment p ON p.rental_id = r.rental_id 
GROUP BY f.title
)
SELECT * FROM rev_per_film
WHERE total_revenue >= 
(SELECT total_revenue FROM rev_per_film WHERE title = 'Rugrats Shakespeare')
ORDER BY 2 DESC

-- list films with below average revenue (total amount)
WITH rev_per_film AS 
(
SELECT f.title, sum(p.amount) as total_revenue
FROM film f 
JOIN inventory i ON i.film_id = f.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
JOIN payment p ON p.rental_id = r.rental_id 
GROUP BY f.title
)
SELECT * FROM rev_per_film
WHERE total_revenue < (SELECT avg(total_revenue) FROM rev_per_film)
ORDER BY 2 DESC

-- list of customers who have rented more films than Megan Palmer
WITH rentals_per_customer AS 
(
SELECT c.first_name, c.last_name, count(r.rental_id) rental_count
FROM customer c 
JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id 
)
SELECT * FROM rentals_per_customer
WHERE rental_count >= 
(SELECT rental_count FROM rentals_per_customer
WHERE first_name = 'Megan' AND last_name='Palmer')
ORDER BY 3 desc

