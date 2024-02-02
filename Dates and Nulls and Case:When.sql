-- Use the dBeaver sample database

SELECT 'Hello world' AS greeting


--Current date
SELECT date()

-- Current time (GMT)
SELECT time()

-- Current date and time 
SELECT datetime()

-- # days since January 1, 4713 BC
SELECT JULIANDAY(date()) 

SELECT invoicedate FROM invoice
-- calculate # days between 2 dates
SELECT JULIANDAY(date())-JULIANDAY(InvoiceDate) FROM invoice

SELECT date() - invoicedate FROM Invoice i 

-- Who are our customers that are not affiliated with a company
SELECT FirstName, 'Smith' AS LastName FROM customer 
WHERE company IS NOT NULL

-- list our customer and their company, put No Company if NULL
SELECT FirstName, LastName, IFNULL(company, 'No Company') AS Company
FROM customer; 

-- list invoices as gold, platinum, or loser based on total $
SELECT customerID, invoiceDate, total,
CASE
   WHEN total >10 THEN 'good'
   WHEN total >5 THEN 'cheap'
   ELSE 'loser'
END as customer_type
FROM invoice
ORDER BY total DESC, customer_type DESC




-- List all customers, and their status based on total $ spent 
-- (Platinum > 45, Gold > 40, Else Aluminum
SELECT c.FirstName, c.LastName, sum(i.Total) AS customer_total,
CASE
   WHEN sum(i.Total) >45 THEN 'Platinum'
   WHEN sum(i.Total) >40 THEN 'Gold'
   ELSE 'Aluminum'
END as customer_type
FROM customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId  
GROUP BY c.CustomerId 
ORDER BY customer_total DESC

SELECT c.FirstName AS fn, c.LastName, sum(i.Total) AS total_dollars, 
CASE
	WHEN sum(i.Total) > 45 THEN 'Platinum'
	WHEN sum(i.Total) > 40 THEN 'Gold'
	ELSE 'Aluminum'
END AS customer_type
FROM Customer c
JOIN Invoice i ON i.CustomerId = c.CustomerId 
GROUP BY c.CustomerID
ORDER BY total_dollars DESC





-- Count the # tracks for each artist 
-- add a new column called 'output' with this criteria
-- 'Prolific' artists have more than 100 tracks
-- 'Busy' artists have more than 10 tracks
-- 'Lazy' artists have 10 or less


SELECT a.Name, count(t.TrackId),
CASE
	WHEN count(t.TrackId) > 100 THEN 'Prolific'
	WHEN count(t.TrackId) > 10 THEN 'Busy'
	ELSE 'Lazy'
END AS output
FROM artist a
JOIN album al ON al.ArtistId = a.ArtistId 
JOIN track t ON t.AlbumId = al.AlbumId 
GROUP BY a.name 
ORDER BY COUNT(t.TrackId) DESC

