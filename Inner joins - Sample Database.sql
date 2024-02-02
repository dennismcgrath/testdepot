-- What are the Artists we sell and all their albums 
SELECT a.Name, a2.Title  FROM Artist a
INNER JOIN Album a2 ON a2.ArtistId = a.ArtistId 
ORDER BY a.Name


-- List all tracks and their genre 
SELECT t.Name, g.Name  FROM Genre g 
INNER JOIN Track t ON t.GenreId = g.GenreId  


-- List all of our tracks and their associated Artist
SELECT t.Name, ar.Name AS artist_name 
FROM Track t 
JOIN Album al ON al.AlbumId  = t.AlbumId 
JOIN Artist ar ON ar.ArtistId = al.ArtistId 
ORDER BY artist_name

SELECT t.Name AS track_name, a2.Name AS artist_name FROM Track t 
INNER JOIN Album a ON a.AlbumId = t.AlbumId 
INNER JOIN Artist a2 ON a2.ArtistId = a.ArtistId 
ORDER BY artist_name


-- List our customer (last name) and their total $ spent
SELECT c.LastName, sum(i.Total) AS total 
FROM Customer c 
JOIN Invoice i ON c.CustomerId = i.CustomerId 
GROUP BY c.LastName 
ORDER BY total DESC

SELECT c.LastName, sum(i.Total) AS total  FROM Customer c 
JOIN Invoice i ON i.CustomerId =c.CustomerId 
GROUP BY c.LastName 
ORDER BY total DESC
LIMIT 10

--what customers have the most invoices?
SELECT c.LastName, count(i.InvoiceId) AS invoices FROM Customer c 
JOIN Invoice i ON c.CustomerId = i.CustomerId 
GROUP BY c.LastName 
ORDER BY invoices DESC

--what genres have the most tracks? 
SELECT g.Name, count(t.TrackId) AS tracks  FROM Genre g 
JOIN Track t ON t.GenreId = g.GenreId 
GROUP BY g.Name
ORDER BY tracks DESC

--what artists have generated the most sales?
SELECT a.Name, sum(il.quantity*il.UnitPrice) AS total FROM Artist a 
JOIN album a2 ON a2.ArtistId = a.ArtistId 
JOIN Track t ON t.AlbumId = a2.AlbumId 
JOIN InvoiceLine il ON t.TrackId = il.TrackId 
GROUP BY a.Name 
ORDER BY total DESC