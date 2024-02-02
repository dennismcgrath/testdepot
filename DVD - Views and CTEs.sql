--use DVD

-- average films per category? 
-- CREATE a VIEW with a count of films
CREATE VIEW films_per_category AS 
SELECT c.name, count(fc.film_id) FROM category c 
JOIN film_category fc 
ON c.category_id = fc.category_id 
GROUP BY 1
-- then use the view to calculate the average number
SELECT avg(count) AS avg_films_category FROM films_per_category fpc 

-- same with a  CTE instead of a view
WITH film_count_cte AS 
(
SELECT c.name, count(fc.film_id) AS film_count FROM category c 
JOIN film_category fc 
ON c.category_id = fc.category_id 
GROUP BY 1
)
SELECT avg(film_count) AS avg_films_category FROM  film_count_cte