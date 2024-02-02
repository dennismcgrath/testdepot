--How many films are rated by ‘PG’ or ‘PG-13’?
SELECT rating, count(film_id) FROM film
WHERE rating IN ('PG', 'PG-13')
GROUP BY rating

--How many actors have a first name ‘Morgan’?
SELECT count(actor_id) FROM actor
WHERE first_name = 'Morgan'

--What’s the average film length (in minutes) for films for each rating (G, PG, etc)?
SELECT rating, avg(length) FROM film 
GROUP BY rating


--What is the total payment for rentals for each customer_id?
SELECT customer_id, sum(amount) FROM payment p 
GROUP BY customer_id 

--What’s the smallest replacement cost of films by rental rate?
SELECT rental_rate, min(replacement_cost) FROM film 
GROUP BY rental_rate