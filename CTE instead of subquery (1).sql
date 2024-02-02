-- use dBeaver Sample Database

-- What's the average number of tracks per invoice?  
SELECT avg(track_count)
FROM (SELECT InvoiceId, count(TrackId) AS track_count FROM InvoiceLine GROUP BY invoiceid)
 
-- Same query using CTE instead of subquery 
WITH num_tracks AS 
(
SELECT InvoiceId, count(TrackId) AS track_count 
FROM InvoiceLine 
GROUP BY invoiceid
)
SELECT avg(track_count) FROM num_tracks

--------------------------------------------------
-- Subquery in the FROM 
-- What's the shortest album in our inventory?
SELECT album_name, min(album_length) FROM
(SELECT al.title AS album_name, sum(t.Milliseconds) AS album_length 
FROM Album al
JOIN Artist a on a.ArtistId = al.ArtistId 
JOIN Track t on t.AlbumId = al.AlbumId 
JOIN Genre g on g.GenreId = t.GenreId 
GROUP BY al.title
)
--- Same query but using CTE instead of a subquery 
WITH sum_album_length AS 
(SELECT al.title AS album_name, sum(t.Milliseconds) AS album_length 
FROM Album al
JOIN Artist a on a.ArtistId = al.ArtistId 
JOIN Track t on t.AlbumId = al.AlbumId 
JOIN Genre g on g.GenreId = t.GenreId 
GROUP BY al.title
)
SELECT album_name, min(album_length) FROM sum_album_length


--------------------------------------------------------------
-- What customer from CA, NY, NJ and FL has spent the most money?? 
-- First with a subquery 
SELECT LastName, max(total_dollars) FROM 
(
 SELECT c.LastName, sum(i.total) AS total_dollars
 FROM Invoice i 
 JOIN Customer c ON c.CustomerId = i.CustomerId
 WHERE i.BillingState in ('CA', 'NY', 'NJ', 'FL')
 GROUP BY c.LastName
 ORDER BY total_dollars DESC
)

-- Using both CTE and Subquery in case of a tie 
-- the CTE can be used twice!! 
WITH dollars AS (
 SELECT c.LastName, sum(i.total) AS total_dollars
 FROM Invoice i 
 JOIN Customer c ON c.CustomerId = i.CustomerId
 WHERE i.BillingState in ('CA', 'NY', 'NJ', 'FL')
 GROUP BY c.LastName
 ORDER BY total_dollars DESC
 )
 SELECT LastName, total_dollars
 FROM dollars
 WHERE total_dollars = (SELECT MAX(total_dollars) FROM dollars)
  