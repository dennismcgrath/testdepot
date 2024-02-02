--Which films in our inventory have never been rented?
--What are the # rentals per film in our video store?
--List actors whose first names start with A
--List all movies with the actors whose names start with A
--What films have an above average rental rate?
--List of actors who play in our top 10 most rented films?

--Which films in our inventory have never been rented?
-- ABMIGUOUS QUESTION
-- better wording:  
--Which inventory (copies) have never been rented
-- and what's the associated film?

SELECT f.title  FROM inventory i 
LEFT JOIN rental r ON i.inventory_id = r.inventory_id 
LEFT JOIN film f ON f.film_id = i.film_id 
WHERE r.rental_id ISNULL

--What are the # rentals per film in our video store?
SELECT f.title, count(r.rental_id) FROM film f 
JOIN inventory i ON i.film_id = f.film_id 
JOIN rental r ON r.inventory_id = i .inventory_id 
GROUP BY 1

--List actors whose first names start with A
SELECT a.first_name, a.last_name  FROM actor a 
WHERE a.first_name LIKE 'A%'


--List all movies with the actors whose names start with A
SELECT DISTINCT f.title  FROM film f
JOIN film_actor fa ON fa.film_id = f.film_id
JOIN actor a ON a.actor_id = fa.actor_id 
WHERE a.first_name LIKE 'A%'

--What films have an above average rental rate?
SELECT f.title, f.rental_rate  FROM film f 
WHERE f.rental_rate > (SELECT avg(rental_rate) FROM film)

--****What films have an above average rental COUNT?
WITH num_rentals AS 
(
SELECT f.title, count(r.rental_id) AS rent_count FROM film f 
JOIN inventory i ON i.film_id = f.film_id 
JOIN rental r ON r.inventory_id = i .inventory_id 
GROUP BY 1
)
SELECT * FROM num_rentals
WHERE rent_count > (SELECT avg(rent_count) FROM num_rentals)



--List of actors who play in our top 10 most rented films?
WITH top10_rentals AS 
(
SELECT f.film_id, count(r.rental_id) AS rent_count FROM film f 
JOIN inventory i ON i.film_id = f.film_id 
JOIN rental r ON r.inventory_id = i .inventory_id 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
)
SELECT DISTINCT a.first_name, a.last_name 
FROM top10_rentals t
JOIN film_actor fa ON fa.film_id = t.film_id
JOIN actor a ON fa.actor_id = a.actor_id

