--How many customers ? 
SELECT count(customer_id) 
FROM customer c 

--customer_id? , rented 12 movies
SELECT customer_id, count(rental_id) 
FROM rental 
GROUP BY customer_id 
HAVING count(rental_id) =12


--Customer lastname for id=318
SELECT last_name  FROM customer c 
WHERE customer_id = 318

--inventory id for customer=318, 7/6 before midnight
SELECT inventory_id, rental_date  FROM rental 
WHERE rental_date 
BETWEEN '2005-07-06 12:00:00.000' 
and '2005-07-06 23:59:59.000'
AND customer_id = 318

-- Get the film id for inventory_id = 4282
SELECT inventory_id, film_id  FROM inventory i 
WHERE inventory_id = 4282

-- Get the title for film 932
SELECT film_id, title FROM film
WHERE film_id = 932

--get the actors for film_id = 932
SELECT actor_id FROM film_actor fa 
WHERE film_id = 932

-- get the actor_id for actor with 19 films
SELECT actor_id, count(*) FROM film_actor 
WHERE actor_id IN 
(SELECT actor_id FROM film_actor fa 
WHERE film_id = 932)
GROUP BY actor_id
HAVING count(*) = 19

-- get the firstname and lastname for actorid = 63
SELECT first_name, last_name FROM actor
WHERE actor_id = 63