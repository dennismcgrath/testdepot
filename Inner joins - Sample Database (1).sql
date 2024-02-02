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


-- List our customer (last name) and their total $ spent
SELECT c.LastName, sum(i.Total) AS total 
FROM Customer c 
JOIN Invoice i ON c.CustomerId = i.CustomerId 
GROUP BY c.LastName 
ORDER BY total DESC