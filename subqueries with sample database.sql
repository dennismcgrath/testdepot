
--What tracks are longer than the average track length?
--Use a subquery in the WHERE clause
--Output: Track name, Milliseconds

SELECT name, Milliseconds  FROM Track 
WHERE Milliseconds > 
(SELECT avg(Milliseconds) FROM track)


--What’s the average $ spent by all cities in our store
--Get BillingCity, and amount spent in a  subquery
--Determine AVG in main query

SELECT avg(city_total) FROM 
(
SELECT c.City, sum(i.total) AS city_total
FROM Customer c 
JOIN Invoice i 
ON c.CustomerId = i.CustomerId 
GROUP BY c.city
)






--List album name and # tracks but use a subquery instead of join

SELECT a.title, 
(
SELECT count(*) FROM track t
WHERE t.albumid = a.albumid
) AS songs
FROM album a
ORDER BY songs desc

SELECT a.title, count(t.trackid)
FROM Album a 
JOIN Track t 
ON a.AlbumId = t.AlbumId 
GROUP BY a.title
ORDER BY count(t.trackid) desc


--List cities who have spent more than average $ per city

SELECT c2.City, sum(i2.total) AS city_total
FROM Customer c2 
JOIN Invoice i2 
ON c2.CustomerId = i2.CustomerId 
GROUP BY c2.city
HAVING sum(i2.total) > 
(SELECT avg(city_total) FROM 
	(
	SELECT c.City, sum(i.total) AS city_total
	FROM Customer c 
	JOIN Invoice i 
	ON c.CustomerId = i.CustomerId 
	GROUP BY c.city
	)
)


-- now do that with a CTE! 
WITH dollars_per_city AS (
	SELECT c.City, sum(i.total) AS city_total
	FROM Customer c 
	JOIN Invoice i 
	ON c.CustomerId = i.CustomerId 
	GROUP BY c.city
	)
SELECT city, city_total FROM dollars_per_city
WHERE city_total > 
(SELECT avg(city_total) FROM dollars_per_city)


