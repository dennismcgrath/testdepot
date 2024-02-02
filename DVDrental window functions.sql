-- list payments, film and the 
-- total amount of payments 
-- for that film

SELECT p.payment_id, p.amount, f.title, 
sum(p.amount) OVER (PARTITION BY f.title)
FROM payment p
JOIN rental r 
ON p.rental_id = r.rental_id 
JOIN inventory i 
ON i.inventory_id = r.inventory_id 
JOIN film f 
ON f.film_id = i.film_id 


-- list film, film length 
-- category, and the avg length 
-- for that category 

SELECT f.title, f.length,  c.name,
avg(f.length) OVER (PARTITION BY c.name)
FROM film f 
JOIN film_category fc 
ON f.film_id = fc.film_id 
JOIN category c 
ON c.category_id = fc.category_id 

-- list film, film length 
-- category, and the avg length 
-- for ALL FILMS  
SELECT f.title, f.length, c.name,
avg(f.length) OVER ()
FROM film f 
JOIN film_category fc 
ON f.film_id = fc.film_id 
JOIN category c 
ON c.category_id = fc.category_id

-- -- list film, film length 
-- category, and the rank (longest to shortest) 
-- for that category 
SELECT f.title, f.length, c.name,
rank() OVER (PARTITION BY c.category_id ORDER BY f.length DESC)
FROM film f 
JOIN film_category fc 
ON f.film_id = fc.film_id 
JOIN category c 
ON c.category_id = fc.category_id 

-- -- list film, film length 
-- category, and the DENSE rank (longest to shortest) 
-- for that category 
SELECT f.title, f.length, c.name,
dense_rank() OVER (PARTITION BY c.category_id ORDER BY f.length DESC)
FROM film f 
JOIN film_category fc 
ON f.film_id = fc.film_id 
JOIN category c 
ON c.category_id = fc.category_id 
 