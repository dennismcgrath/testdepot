-- List invoiceID, total, AND
-- the sum of all totals for that
-- customer's country 

-- Individual table with pivot info in it
SELECT invoiceID, total, BillingCountry, 
sum(total) OVER(PARTITION BY BillingCountry)
FROM invoice

-- "pivot" table by country using "GROUP BY"
SELECT BillingCountry, sum(total)  
FROM invoice 
GROUP BY BillingCountry 


-- Invoice, total, city, and city total
SELECT invoiceID, total, BillingCity, 
sum(total) OVER(PARTITION BY BillingCity) AS city_total
FROM invoice

-- order by city_total instead
SELECT invoiceID, total, BillingCity, 
sum(total) OVER(PARTITION BY BillingCity) AS city_total
FROM invoice
ORDER BY city_total DESC

-- List all tracks and their length and album and album length
SELECT t.Name, t.Milliseconds/1000 AS tracklength, a.Title,  
sum(t.Milliseconds/1000) OVER (PARTITION BY a.AlbumId) AS albumlength,
count(t.trackID) OVER (PARTITION BY a.AlbumId) AS trackcount
FROM Track t 
JOIN Album a 
ON a.AlbumId = t.AlbumId 






