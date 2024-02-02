
--Create a new category based on unit price
SELECT product_name, unit_price, 
CASE 
	WHEN unit_price > 40 THEN 'Premium'
	WHEN unit_price > 20 THEN 'Standard'
	ELSE 'Thrifty'
END AS price_category
FROM products p  

--create a new column for 'Continent'
SELECT DISTINCT country FROM customers

SELECT city, country,  
CASE 
	WHEN country IN ('USA', 'Mexico', 'Canada') THEN 'North America'
	WHEN country IN ('Venezuela', 'Brazil', 'Argentina') THEN 'South America'
	ELSE 'Europe'
END AS continent
FROM customers

-- Null functions
SELECT * FROM customers 
WHERE region IS NULL 

SELECT company_name, 
CASE 
	WHEN region IS NULL THEN 'Neverland'
	ELSE region
END
FROM customers



-- Date and Time Stuff
-- what date will be 7 weeks and 1 day from now?
SELECT NOW()

SELECT LOCALTIME

SELECT LOCALTIMESTAMP 

SELECT INTERVAL '2 WEEKS' + INTERVAL '2 DAYS'

SELECT NOW() + INTERVAL '7 WEEKS' + '1 DAY'

-- What age are all our employees? 

SELECT * FROM employees  

SELECT last_name, now() - birth_date FROM employees

SELECT last_name, age(now(), birth_date) FROM employees

SELECT last_name, EXTRACT (YEAR FROM age(now(), birth_date)) 
FROM employees

SELECT last_name, DATE_PART('year', age(now(), birth_date)) 
FROM employees

-- Can we parse day, month, year from datetime? 
SELECT EXTRACT (MONTH FROM order_date) FROM orders

SELECT DATE_PART('month', order_date) FROM orders

SELECT DATE_PART('year', order_date) FROM orders

-- use age and extract (or date_part) and CASE/WHEN to create a new
-- column called 'ship_cycle_time'
-- calculate difference between order_date and shipped_date in days
-- make it 'late' if > 10
-- 'acceptable if > 4'
-- else 'on time'

 SELECT order_date, shipped_date, age(shipped_date, order_date),
 EXTRACT(DAY FROM age(shipped_date, order_date)),
 CASE
 	 WHEN EXTRACT(DAY FROM age(shipped_date, order_date)) > 10 THEN 'Late'
 	 WHEN EXTRACT(DAY FROM age(shipped_date, order_date)) > 4 THEN 'Acceptable'
 	 ELSE 'On time'
 END AS ship_cycle_time
 FROM orders
 
 --
 SELECT order_date, shipped_date, age(shipped_date, order_date),
 EXTRACT(DAY FROM age(shipped_date, order_date)),
 CASE
 	 WHEN (shipped_date - order_date) > 10 THEN 'Late'
 	 WHEN (shipped_date - order_date)  > 4 THEN 'Acceptable'
 	 ELSE 'On time'
 END AS ship_cycle_time
 FROM orders 
-- 
 
 
 -- transform date_part into text day of week
SELECT CASE 
	WHEN DATE_PART('dow', order_date)=1 THEN 'Monday'
	WHEN DATE_PART('dow', order_date)=2 THEN 'Tuesday'
	WHEN DATE_PART('dow', order_date)=3 THEN 'Wednesday'
	WHEN DATE_PART('dow', order_date)=4 THEN 'Thursday'
	WHEN DATE_PART('dow', order_date)=5 THEN 'Friday'
	WHEN DATE_PART('dow', order_date)=6 THEN 'Saturday'
	WHEN DATE_PART('dow', order_date)=7 THEN 'Sunday'
	ELSE 'Other'
END AS "day_of_the_week"
FROM orders
 