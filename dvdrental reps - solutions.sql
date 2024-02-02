--use dvdrental
 -- write a query with a CASE/WHEN for film table
-- use the film table, select title and description
-- add a column called 'film_duration'
SELECT title, length,
CASE
  WHEN length <= 90 THEN 'Too Short'
  WHEN length > 120 THEN 'Too Long'
  ELSE 'Just Right'
END AS type
FROM film;

-- List all the films rented by customer 
-- named Elizabeth Brown
SELECT f.title FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE c.first_name = 'Elizabeth' AND c.last_name = 'Brown'

-- list the top 5 towns by total payment dollars
-- list the town and their total
SELECT c.city, SUM(p.amount) AS total_payments
FROM payment p
JOIN customer cu ON p.customer_id = cu.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
GROUP BY c.city
ORDER BY total_payments DESC
LIMIT 5;


--list the total payments for each customer
-- list last_name and total
SELECT c.last_name, SUM(p.amount) AS total_payments
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY c.last_name

 
-- how many rentals have no payment?
SELECT count(r.rental_id) FROM rental r
LEFT JOIN payment p ON p.rental_id = r.rental_id
WHERE p.payment_id IS NULL

-- list the names of all the films and 
-- a count of the total rentals/film
SELECT f.title, count(r.rental_id) FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.title

-- count rentals by film AND by category 
-- output: film, rental_count, category, category_count
WITH count_rentals AS
(
SELECT f.title, c.name AS category, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY f.title, c.name
)
SELECT title, rental_count, category,
sum(rental_count) OVER (PARTITION BY category) as category_rentals
FROM count_rentals