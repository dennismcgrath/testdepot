-- Part 2 - Complex queries

-- 1. Write a query that will list all of the track names 
--	and the album names from the artist named ‘Jamiroquai’.

SELECT t.Name ,a.Title  FROM Track t 
JOIN Album a 
ON t.AlbumId =a.AlbumId 
JOIN Artist a2 
ON a.ArtistId =a2.ArtistId 
WHERE a2.Name = 'Jamiroquai'

-- 2. Write a query that will determine the top 5 customer 
--	countries measured by total revenue (dollars) by billing country.  
--	Include country and total revenue.

SELECT c.Country, sum(i.Total)  FROM Customer c 
JOIN Invoice i 
ON c.CustomerId =i.CustomerId
GROUP BY c.Country 
ORDER BY sum(i.Total) DESC 
LIMIT 5

-- 3. Write a query that determines the total invoice revenue 
--	by global region.  Use ‘Asia Pacific’ for India and Australia, 
--	‘North America’ for Canada and the USA, ‘South America’ for Chile, 
--	Brazil and Argentina, and ‘Europe’ for the rest.

SELECT 
CASE 
	WHEN BillingCountry IN ('India','Australia') THEN 'Asia Pacific'
	WHEN BillingCountry IN ('Canada','USA') THEN 'North America'
	WHEN BillingCountry IN ('Chile','Brazil','Argentina') THEN 'South America'
	ELSE 'Europe'
END AS Global_region, 
sum(Total) AS Total_revenue
FROM Invoice i 
GROUP BY global_region

-- 4. Write a query that lists the artists and a count of their albums. 
--	Include artists that don’t have albums. 

SELECT a.Name ,count(a2.AlbumId) FROM Artist a 
LEFT JOIN Album a2 
ON a.ArtistId =a2.ArtistId 
GROUP BY a.Name 
ORDER BY count(a2.AlbumId) asc 

-- 5. Write a query that will list the invoiceID’s that include 
--	the most genres. You will want to make sure you don’t count 
--	duplicate genres, and there might be a tie for the most. 
--	Include invoiceID and genre count in the output

SELECT DISTINCT il.InvoiceId, 
Count(g.GenreId) OVER (PARTITION BY il.InvoiceId)
FROM Genre g 
JOIN Track t 
ON t.GenreId =t.GenreId 
JOIN InvoiceLine il 
ON t.TrackId =il.TrackId 

-- 6. Write a query that lists all the invoiceIDs, the invoice totals, 
--	their billing country, and total amount of revenue from that country. 

WITH invoice_t AS(
SELECT InvoiceId ,BillingCountry , 
sum(i.Total) OVER (PARTITION BY InvoiceId) AS invoice_total
FROM Invoice i 
)
SELECT InvoiceId ,invoice_total,BillingCountry ,
sum(invoice_total) OVER (PARTITION BY BillingCountry) AS total_revenue
FROM invoice_t 
