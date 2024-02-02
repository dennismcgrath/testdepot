
-- create a new column called 'watchability'
SELECT title, length, 
CASE 
	WHEN length > 120 THEN 'long'
	WHEN length > 90 THEN 'watchable'
	ELSE 'too short'
END AS watchability
FROM film
ORDER BY watchability

-- create a new column called 'status' based on amount of $
SELECT customer_id, amount,  
CASE 
	WHEN amount > 7 THEN 'Platinum'
	WHEN amount > 3 THEN 'Gold'
	ELSE 'Silver'
END AS status
FROM payment

-- only show NULL addresses
SELECT * FROM address
WHERE address2 ISNULL

-- difference between 2 dates
SELECT return_date - rental_date FROM rental

--age function calculates difference between dates
SELECT age(return_date, rental_date) FROM rental

SELECT age(now(), rental_date) FROM rental

-- date_part gets day of the week (dow) as number 
SELECT date_part('dow',rental_date ), count(rental_id) 
FROM rental
GROUP BY date_part('dow',rental_date )

SELECT date_part('dow',rental_date ), count(rental_id) 
FROM rental
GROUP BY 1
ORDER BY 2 DESC

SELECT Extract('dow' FROM rental_date ), count(rental_id) 
FROM rental
GROUP BY 1
ORDER BY 2 DESC

SELECT Extract('MONTH' FROM rental_date ), count(rental_id) 
FROM rental
GROUP BY 1
ORDER BY 2 DESC

SELECT Extract('YEAR' FROM rental_date ), count(rental_id) 
FROM rental
GROUP BY 1
ORDER BY 2 DESC


SELECT rental_date, Extract('dow' FROM rental_date ) 
FROM rental
WHERE Extract('dow' FROM rental_date )  = 0
LIMIT 1


