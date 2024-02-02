--Part 1
CREATE TABLE Orders
 	(OrderID INT PRIMARY KEY,
 	CompanyName VARCHAR(255) NOT NULL,
 	Address VARCHAR(255),
 	City VARCHAR(255),
 	Phone VARCHAR(255),
 	OrderDate VARCHAR(255));
 	
INSERT INTO Orders
VALUES (1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '2015-01-14'),
 		(2, 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '2015-05-02'),
 		(3, 'Netflix', '888 Broadway', 'New York', '642-612-6123', '2015-06-07');

SELECT *
FROM Orders

SELECT CompanyName, Address, City
FROM Orders 
WHERE City ='Chicago'

SELECT *
FROM Orders
WHERE CompanyName LIKE 'A%'




--Part 2
--Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.
SELECT a2.Title, t.Name, a.Name 
FROM Artist a 
JOIN Album a2 
	ON a.ArtistId = a2.ArtistId 
JOIN Track t 
	ON a2.AlbumId = t.AlbumId 
WHERE a.Name = 'Jamiroquai'
	
--Write a query that will determine the top 5 customer countries measured by total revenue (dollars) by billing country.   
-- Include country and total revenue.
SELECT BillingCountry, SUM(Total)
FROM Invoice i 
GROUP BY BillingCountry 
ORDER BY SUM(Total) DESC
LIMIT 5

--OR
/*WITH TotalRevenueCountry AS
(
SELECT i.BillingCountry, c.Country, SUM(i.Total) AS TotalRevenue
FROM Customer c 
JOIN Invoice i
	ON c.CustomerId = i.CustomerId 
GROUP BY BillingCountry 
ORDER BY SUM(Total) DESC
)
SELECT trc.Country, TotalRevenue
FROM TotalRevenueCountry trc
LIMIT 5*/

--Write a query that determines the total invoice revenue by global region.  
-- Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, ‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.
SELECT 
	CASE
		WHEN BillingCountry IN ('India', 'Australia') THEN 'Asia Pacific'
		WHEN BillingCountry IN ('Canada', 'USA') THEN 'North America'
		WHEN BillingCountry IN ('Chile', 'Brazil', 'Argentina') THEN 'South America'
		ELSE 'Europe'
	END AS GlobalRegion, SUM(Total) AS TotalInvoiceRevenue
FROM Invoice i
GROUP BY GlobalRegion
ORDER BY TotalInvoiceRevenue DESC

--Write a query that lists the artists and a count of their albums. 
-- Include artists that don’t have albums.
SELECT a.Name, COUNT(a2.AlbumId) AS TotalAlbums
FROM Artist a 
LEFT JOIN Album a2 
	ON a.ArtistId = a2.ArtistId
GROUP BY a.Name 
ORDER BY TotalAlbums DESC 
	
--Write a query that will list the invoiceID’s that include the most genres. 
-- You will want to make sure you don’t count duplicate genres, and there might be a tie for the most. 
--  Include invoiceID and genre count in the output.
WITH genre_count AS 
(
SELECT il.InvoiceId, COUNT(DISTINCT g.GenreId) AS TotalGenres 
FROM InvoiceLine il
LEFT JOIN Track t 
	ON il.TrackId = t.TrackId 
LEFT JOIN Genre g  
	ON t.GenreId = g.GenreId 
GROUP BY il.InvoiceId 
ORDER BY TotalGenres DESC
)
SELECT gc.InvoiceId, TotalGenres
FROM genre_count gc
WHERE TotalGenres = (SELECT MAX(TotalGenres) FROM genre_count)

--Write a query that lists all the invoiceIDs, the invoice totals, their billing country, and total amount of revenue from that country.
WITH invoice_totals AS
(
SELECT InvoiceId, BillingCountry, SUM(Total) AS total_invoice
FROM Invoice i 
GROUP BY InvoiceId, BillingCountry 
)
SELECT InvoiceId, total_invoice, BillingCountry,
SUM(total_invoice) OVER(PARTITION BY BillingCountry) AS total_per_country
FROM invoice_totals
ORDER BY total_per_country DESC





	