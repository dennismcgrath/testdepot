SELECT customer.first_name, customer.last_name, rental.rental_date, film.title  
FROM rental 
INNER JOIN customer 
ON customer.customer_id = rental.customer_id 
INNER JOIN inventory 
ON inventory.inventory_id = rental.inventory_id 
INNER JOIN film 
ON inventory.film_id = film.film_id
ORDER BY customer.last_name
--
SELECT c.first_name, c.last_name, r.rental_date
FROM rental r
JOIN customer c 
ON c.customer_id = r.customer_id 
JOIN inventory i 
ON i.inventory_id = r.inventory_id 
JOIN film f
ON i.film_id = f.film_id 
ORDER BY c.last_name 
