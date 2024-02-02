-- Difference between INNER JOIN  
-- and LEFT JOIN 

-- Are there films for which there is no inventory?
SELECT f.film_id, f.title, i.inventory_id  
FROM film f 
JOIN inventory i ON i.film_id = f.film_id
ORDER BY i.inventory_id DESC 

SELECT f.film_id, f.title, i.inventory_id  
FROM film f 
LEFT JOIN inventory i ON i.film_id = f.film_id 
WHERE i.inventory_id IS NULL
ORDER BY i.inventory_id DESC 

--How many films have no inventory??
SELECT count(f.film_id)
FROM film f 
LEFT JOIN inventory i ON i.film_id = f.film_id 
WHERE i.inventory_id IS NULL


--RIGHT JOIN vs. INNER JOIN
-- Are there videos that have never been rented? 
SELECT i.inventory_id,r.rental_id  FROM rental r 
JOIN inventory i ON i.inventory_id  = r.inventory_id 
ORDER BY r.rental_id DESC

SELECT i.inventory_id,r.rental_id  FROM rental r 
RIGHT JOIN inventory i ON i.inventory_id  = r.inventory_id 
ORDER BY r.rental_id  DESC

SELECT count(i.inventory_id) FROM rental r 
RIGHT JOIN inventory i ON i.inventory_id  = r.inventory_id 

-- What cities have the most rentals?
--Are there cities that have no rentals? 


