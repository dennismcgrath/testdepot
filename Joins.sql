-- Joins!  

-- Inner joins first ... 
SELECT album.Title, artist.Name  FROM album 
INNER JOIN Artist
ON album.ArtistId = artist.ArtistId
-- "Inner" is not necessary
SELECT album.Title, artist.Name  FROM album 
JOIN Artist
ON album.ArtistId = artist.ArtistId
-- use aliases for Table Names
SELECT a.Title, ar.Name  
FROM album a 
JOIN Artist ar
ON a.ArtistId = ar.ArtistId
ORDER BY ar.name 
-- Swap the table order - doesn't matter for INNER
SELECT a.Title, ar.Name  
FROM Artist ar
JOIN Album a
ON a.ArtistId = ar.ArtistId

------------------------- Left Joins

SELECT ar.Name, a.title 
FROM artist ar 
LEFT JOIN album a 
ON a.ArtistId = ar.ArtistId
--WHERE Title IS NULL

-- find tracks that no one purchased
SELECT t.Name, sum(il.Quantity)  
FROM Track t
LEFT JOIN InvoiceLine il
ON il.TrackId = t.TrackId 
WHERE il.Quantity IS NULL
GROUP BY t.name

-- list employees and their total $ invoice
SELECT e.LastName, sum(i.Total) FROM Employee e 
LEFT JOIN Customer c 
ON c.SupportRepId = e.EmployeeId 
LEFT JOIN Invoice i 
ON i.CustomerId = c.CustomerId 
GROUP BY e.LastName 
ORDER BY 2 DESC 

-- same thing with INNER join
SELECT e.LastName, sum(i.Total) FROM Employee e 
JOIN Customer c 
ON c.SupportRepId = e.EmployeeId 
JOIN Invoice i 
ON i.CustomerId = c.CustomerId 
GROUP BY e.LastName 
ORDER BY 2 DESC
