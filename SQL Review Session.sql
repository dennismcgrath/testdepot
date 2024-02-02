SELECT BillingCountry, sum(Total) 
FROM Invoice i 
WHERE BillingCountry IN ('USA', 'Canada', 'Mexico') --AND sum(Total) > 500
GROUP BY BillingCountry 
HAVING sum(Total) > 500 

-- GROUP BY must match columns in SELECT
-- SQLite will let you get away with mismatching SELECT and GROUP BY 
-- Postgres will NOT let you get away with IDENTITY 

-- HAVING is used for comparing aggregate values to something
-- WHERE is used for comparing database values to something


-- List Song Titles and Genre for each song
SELECT Track.Name, Genre.Name FROM Track 
JOIN Genre ON Track.GenreId = Genre.GenreId

-- Same inner join with tables reversed
SELECT Track.Name,Genre.Name FROM Genre 
JOIN Track ON Track.GenreId = Genre.GenreId


-- are there any artists with no albums? 
-- the 'Left Table' is whatever we put in FROM
SELECT * FROM Artist 
LEFT JOIN Album ON Artist.ArtistId = Album.ArtistId 
WHERE Album.AlbumId IS NULL


-- List track name and album title that it appeared on 
SELECT Track.Name, Album.Title FROM Track 
JOIN Album ON Track.AlbumId = Album.AlbumId 

-- same query with alias for tables
SELECT t.Name, a.Title FROM Track t
JOIN Album a ON t.AlbumId = a.AlbumId 


-- List Customer Lastname, and Invoice total for each purchase
SELECT c.Lastname, i.Total AS total_amount FROM Customer AS c 
JOIN Invoice i ON c.CustomerId = i.CustomerId 

-- list each artist and all Track UnitPrice
SELECT a.Name, t.Name, t.UnitPrice  FROM Artist a 
JOIN Album a2 ON a.ArtistId = a2.ArtistId 
JOIN Track t ON t.AlbumId = a2.AlbumId 

-- list each artist and total (i.e. SUM) $ sold for that artist
SELECT a.Name, sum(il.UnitPrice)  FROM Artist a 
JOIN Album a2 ON a.ArtistId = a2.ArtistId 
JOIN Track t ON t.AlbumId = a2.AlbumId 
JOIN InvoiceLine il ON il.TrackId = T.TrackId 
GROUP BY a.Name


-- list artist names and their associated track names (2 joins, no aggregate)
-- calculate the total $ for each genre.  List genre name and total $ (2 joins, 1 aggregate: sum (unit_price))
-- count the number of customers helped by each employee (1 join, 1 aggregate: count(customerID))
