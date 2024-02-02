
 --customers AND the # rentals
SELECT c.last_name, count(r.rental_id) 
FROM customer c 
JOIN rental r
ON r.customer_id = c.customer_id 
GROUP BY c.last_name

 --actors named 'Julia' and their films
SELECT a.first_name, a.last_name, f.title  
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id 
JOIN film f 
ON f.film_id = fa.film_id 
WHERE a.first_name = 'Julia'

--top 5 categories with the most films
SELECT c.name, count(fc.film_id) AS film_count 
FROM category c 
JOIN film_category fc 
ON c.category_id = fc.category_id 
GROUP BY c.name
ORDER BY film_count DESC 
LIMIT 5

--top 5 categories with the most rentals
SELECT c.name, count(r.rental_id) AS film_count  
FROM category c 
JOIN film_category fc 
ON fc.category_id = c.category_id 
JOIN film f 
ON f.film_id = fc.film_id 
JOIN inventory i 
ON i.film_id = f.film_id 
JOIN rental r 
ON r.inventory_id = i.inventory_id 
GROUP BY c.name
ORDER BY film_count DESC
LIMIT 5

--customer (names) from Finland
SELECT c.last_name, co.country  FROM customer c 
JOIN address a 
ON a.address_id = c.address_id 
JOIN city ci 
ON a.city_id = ci.city_id
JOIN country co
ON co.country_id = ci.country_id 
WHERE co.country = 'Finland'

--films with no inventory? need a left join 
SELECT f.title, count(i.inventory_id) AS inv_count 
FROM film f 
LEFT JOIN inventory i 
ON i.film_id = f.film_id 
GROUP BY f.title
ORDER BY inv_count ASC 

--films with no inventory? (using right join) 
SELECT f.title, count(i.inventory_id) AS inv_count
FROM inventory i
RIGHT JOIN film f 
ON i.film_id = f.film_id 
GROUP BY f.title
ORDER BY inv_count ASC

--films that have never been rented? 
SELECT f.title, count(r.rental_id) AS rental_count
FROM film f 
LEFT JOIN inventory i 
ON i.film_id = f.film_id 
LEFT JOIN rental r 
ON r.inventory_id = i.inventory_id 
GROUP BY f.title 
HAVING count(r.rental_id) < 1
ORDER BY f.title

--films where rental_id = NULL? 
SELECT f.title, r.rental_id  
FROM film f 
LEFT JOIN inventory i 
ON i.film_id = f.film_id 
LEFT JOIN rental r 
ON r.inventory_id = i.inventory_id 
WHERE r.rental_id IS NULL
ORDER BY f.title

-- Why did Academy Dinosaur show up now?
SELECT f.title, i.inventory_id, r.rental_id  
FROM film f 
LEFT JOIN inventory i 
ON i.film_id = f.film_id 
LEFT JOIN rental r 
ON r.inventory_id = i.inventory_id 
WHERE f.title = 'Academy Dinosaur'
--because inventory_id = 5 (copy) was not rented



-- List all languages and # films (*even if no films)
SELECT l.name, count(f.film_id) 
FROM language l
LEFT JOIN film f 
ON l.language_id = f.language_id 
GROUP BY l.name

-- same with RIGHT JOIN 
SELECT l.name, count(f.film_id) 
FROM film f 
RIGHT JOIN language l 
ON l.language_id = f.language_id 
GROUP BY l.name


