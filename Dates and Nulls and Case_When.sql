-- Use the dBeaver sample database

--Current date
SELECT date()

-- Current time (GMT)
SELECT time()

-- Current date and time 
SELECT datetime()

-- # days since January 1, 4713 BC
SELECT JULIANDAY(date()) 


-- calculate # days between 2 dates
SELECT JULIANDAY(date())-JULIANDAY(InvoiceDate) FROM invoice

-- Who are our customers that are not affiliated with a company
SELECT * FROM customer 
WHERE company IS NULL

-- list our customer and their company, put No Company if NULL
SELECT FirstName, LastName, IFNULL(company, 'No Company') 
FROM customer; 

-- list invoices as gold, platinum, or loser based on total $
SELECT customerID, invoiceDate, total,
CASE
   WHEN total >10 THEN 'good'
   WHEN total >5 THEN 'cheap'
   ELSE 'loser'
END as customer_type
FROM invoice

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


