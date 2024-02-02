-- Difference between INNER JOIN  
-- and LEFT JOIN 

-- Are there films for which there is no inventory?
SELECT f.film_id, f.title, i.inventory_id  
FROM film f 
INNER JOIN inventory i ON i.film_id = f.film_id
WHERE i.inventory_id IS NULL
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
WHERE i.inventory_id  IS NULL


--RIGHT JOIN vs. INNER JOIN
-- Are there videos that have never been rented? 
SELECT i.inventory_id,r.rental_id  FROM rental r 
JOIN inventory i ON i.inventory_id  = r.inventory_id 
ORDER BY r.rental_id DESC


SELECT i.inventory_id,r.rental_id  FROM rental r 
RIGHT JOIN inventory i ON i.inventory_id  = r.inventory_id 
ORDER BY r.rental_id  DESC

SELECT i.inventory_id,r.rental_id  FROM inventory i 
LEFT JOIN rental r ON i.inventory_id  = r.inventory_id 
ORDER BY r.rental_id  DESC

-- how many title in the inventory have never been rented? 
SELECT count(i.inventory_id) FROM rental r 
RIGHT JOIN inventory i ON i.inventory_id  = r.inventory_id 
WHERE r.rental_id IS NULL


-- What cities have the most rentals?
--Are there cities that have no rentals? 
SELECT c.city, count(r.rental_id) AS rentals FROM city c 
LEFT JOIN address a ON c.city_id = a.city_id 
LEFT JOIN customer cu ON cu.address_id = a.address_id 
LEFT JOIN rental r ON r.customer_id = cu.customer_id
GROUP BY c.city_id  
ORDER BY rentals 

--- Same thing with RIGHT JOINS instead of LEFT 
SELECT c2.city, count(r.rental_id) AS rentals 
FROM rental r
RIGHT JOIN customer c ON c.customer_id = r.customer_id 
RIGHT JOIN address a ON a.address_id = c.address_id 
RIGHT JOIN city c2 ON c2.city_id = a.city_id 
GROUP BY c2.city_id  
ORDER BY rentals 


-- Only list the cities with no rentals
SELECT c.city_id, c.city, count(r.rental_id) AS rentals FROM city c 
LEFT JOIN address a ON a.city_id =c.city_id
LEFT JOIN customer c2 ON c2.address_id = a.address_id 
LEFT JOIN rental r ON r.customer_id = c2.customer_id 
WHERE r.rental_id IS null
GROUP BY c.city_id
ORDER BY c.city 


-- combine both staff and customers in an email list  
SELECT s.first_name, s.last_name, s.email, 'staff' AS type   FROM staff s 
UNION
SELECT c.first_name, c.last_name, c.email, 'customer'   FROM customer c 
ORDER BY TYPE DESC  


