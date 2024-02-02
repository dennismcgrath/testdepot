-- what actor has been in films with the most other actors 
WITH other_actors AS 
(
SELECT fa.actor_id AS act, other_actor.actor_id AS other_act 
FROM film_actor fa
JOIN film_actor other_actor
on fa.film_id = other_actor.film_id
WHERE fa.actor_id <> other_actor.actor_id 
)
SELECT a.first_name, a.last_name, count(DISTINCT other_act) AS others
FROM other_actors oa
JOIN actor a 
ON oa.act = a.actor_id 
GROUP BY a.first_name, a.last_name
ORDER BY OTHERS DESC 

