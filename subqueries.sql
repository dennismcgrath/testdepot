-- use dBeaver Sample Database

-- What's the average number of tracks per invoice?  
SELECT il.InvoiceId, avg(count(il.TrackId)) FROM InvoiceLine il 
GROUP BY il.InvoiceId 
--??

SELECT avg(track_count)
FROM (SELECT InvoiceId, count(TrackId) AS track_count FROM InvoiceLine GROUP BY invoiceid)


-- Subquery in the SELECT statement
-- List the total amount of $$ spent by each customer
-- This is equivalent to a JOIN 
SELECT c.CustomerId , c.FirstName, c.FirstName, 
	(SELECT SUM(total) 
	 FROM Invoice i
	 WHERE c.CustomerId  = i.CustomerId 
	 ) 
	AS total_sales_customer
FROM Customer c

-- Subquery in the FROM 
-- What's the shortest album in our inventory?
SELECT Title, min(length) FROM
(SELECT al.title, sum(t.Milliseconds) AS length 
FROM Album al
JOIN Artist a on a.ArtistId = al.ArtistId 
JOIN Track t on t.AlbumId = al.AlbumId 
JOIN Genre g on g.GenreId = t.GenreId 
GROUP BY al.title
)

-- Subquery in the WHERE
--ONLY list invoices that ARE higher than the average invoice total
SELECT i.CustomerId, c.LastName, i.InvoiceDate, i.Total 
FROM Invoice i 
JOIN Customer c ON c.CustomerId =i.CustomerId 
WHERE i.Total > (SELECT avg(total) FROM Invoice);