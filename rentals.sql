--What are the last names of customers named ‘Jon’ or ‘John’?
SELECT first_name, last_name  
FROM actor 
WHERE first_name = 'Jon' OR last_name = 'John'

SELECT first_name, last_name  
FROM actor
WHERE first_name IN ('John', 'Jon')


--What films are rated by ‘G’?
SELECT title, rating
FROM film 
WHERE rating = 'G'

--How many films are rated by ‘PG’ or ‘PG-13’?
SELECT rating count(film_id)
FROM film 
WHERE rating IN ('PG', 'PG-13')
GROUP BY rating

-How many actors have a first name ‘Morgan’?
SELECT Count(actor_id) 
FROM actor 
WHERE first_name = 'Morgan'

--What’s the average film length (in minutes) for films for each rating (G, PG, etc)?
SELECT rating, avg(length) AS average_length 
FROM film 
GROUP BY rating

--What is the highest payment for rentals for each customer_id?
SELECT customer_id, max(amount) AS maximum_payment 
FROM payment
GROUP BY customer_id 
ORDER BY maximum_payment desc

--What’s the smallest replacement cost of films by rental rate?
SELECT  min(replacement_cost),rental_rate 
FROM film 
GROUP BY rental_rate
