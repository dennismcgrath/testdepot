SELECT r.rental_id, 
CASE
	WHEN rental_date BETWEEN '2005-04-01 00:00:00' AND '2005-06-30 23:59:59'THEN '2nd Quarter'  
	WHEN rental_date BETWEEN '2005-07-01 00:00:00' AND '2005-09-30 23:59:59'THEN '3rd Quarter'  
	ELSE '4th quarter'
END AS quarter
FROM rental r 


SELECT DATE_PART('QUARTER', rental_date) FROM rental

-- mysql> SELECT QUARTER('2008-04-01');
