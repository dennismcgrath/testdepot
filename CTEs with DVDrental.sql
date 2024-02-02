
-- average # actors per film
-- actor(s) who has been in the most films
-- average # rentals per film 
-- countries with above average # rentals

-- average # actors per film
SELECT avg(count)FROM 
(SELECT film_id, count(actor_id) 
FROM film_actor fa 
GROUP BY film_id) AS actor_count

--same thing with CTE
WITH actor_count AS 
(
	SELECT film_id, count(actor_id) 
	FROM film_actor fa 
	GROUP BY film_id
)
SELECT avg(count) FROM actor_count


-- list actor(s) who has been in the most films
WITH film_count AS 
(
	SELECT actor_id, count(film_id) AS num_films
	FROM film_actor 
	GROUP BY actor_id
	ORDER BY count(film_id) DESC
)
SELECT a.first_name, a.last_name, fc.num_films 
FROM film_count fc
JOIN actor a 
ON fc.actor_id = a.actor_id 
WHERE num_films = (SELECT max(num_films) FROM film_count)


-- average # rentals per film 
WITH rentals_per_film AS 
(
SELECT f.film_id, count(r.rental_id) AS rental_count
FROM film f
JOIN inventory i 
ON i.film_id = f.film_id 
JOIN rental r 
ON r.inventory_id = i.inventory_id 
GROUP BY f.film_id 
)
SELECT avg(rental_count) FROM rentals_per_film


-- countries with above average # rentals
WITH country_rentals AS 
(
SELECT co.country, count(r.rental_id) AS rental_count
FROM country co
JOIN city ci 
ON ci.country_id = co.country_id 
JOIN address a 
ON a.city_id = ci.city_id 
JOIN customer cu
ON cu.address_id = a.address_id 
JOIN rental r 
ON r.customer_id = cu.customer_id 
GROUP BY co.country
)
SELECT country, rental_count
FROM country_rentals
WHERE rental_count > (SELECT avg(rental_count) FROM country_rentals)


-- list categories with below average total payment $ per category