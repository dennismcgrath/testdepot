--How many films are rated by ‘PG’ or ‘PG-13’?
--How many actors have a first name ‘Morgan’?
--What’s the average film length (in minutes) for films for each rating (G, PG, etc)?
--What is the total payment for rentals for each customer_id?
--What’s the smallest replacement cost of films by rental rate?

--How many films are rated by ‘PG’ or ‘PG-13’?

SELECT rating, count(film_id) FROM film
WHERE rating IN ('PG', 'PG-13')
GROUP BY rating

SELECT  count(film_id) FROM film
WHERE rating IN ('PG', 'PG-13')

--How many actors have a first name ‘Morgan’?
SELECT first_name, count(*) FROM actor 
WHERE first_name = 'Morgan'
GROUP BY first_name

--What’s the average film length (in minutes) for films for each rating (G, PG, etc)?
SELECT rating, round(avg(length),2) FROM film
GROUP BY rating

--What is the total payment for rentals for each customer_id?
SELECT customer_id, sum(amount) FROM payment
GROUP BY customer_id
ORDER BY sum(amount) DESC 
LIMIT 10

--What’s the smallest replacement cost of films by rental rate?
SELECT rental_rate, min(replacement_cost) FROM film
GROUP BY rental_rate