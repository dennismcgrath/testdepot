--  SaeedAlmuwali SQL Final Assessment.SQL  ---

-- Create a table called Orders, with the following information:
/*
1- Primary Key called OrderID
2- Company Name (include a NOT NULL constraint)
3- Address
4- City
5- Phone
6- Order Date in DATE format
*/

CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CompanyName TEXT NOT NULL,
    Address TEXT,
    City TEXT,
    Phone TEXT,
    OrderDate DATE
)

-- Write SQL statements to insert the following into your table:

INSERT INTO Orders (OrderID, CompanyName, Address, City, Phone, OrderDate)
VALUES
    (1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '2015-01-14'),
    (2, 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '2015-05-02'),
    (3, 'Netflix', '888 Broadway', 'New York', '642-612-6123', '2015-06-07')

-- Create a query that will select company name, address, and city from 
-- the Orders table for companies located in Chicago.

SELECT CompanyName, Address, City
FROM Orders
WHERE City = 'Chicago'

-- Create a query that will select all the records from the Orders table where 
-- the company name starts with an "A".

SELECT *
FROM Orders
WHERE CompanyName LIKE 'A%'

-- *> Use the dBeaver Sample Database (music store) <*
 
-- Write a query that will list all of the genre names and a count of 
-- the tracks for each genre. Sort the list by largest track count to smallest. 

SELECT g.Name AS GenreName, 
	COUNT(t.TrackId) AS TrackCount
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
GROUP BY g.Name
ORDER BY TrackCount DESC

-- Write a query that will list all of the track names and the album names from 
-- the artist named ‘Jamiroquai’.

SELECT ar.Name AS ArtistName, a.Title AS AlbumName, t.Name AS TrackName
FROM Track t
JOIN Album a ON t.AlbumId = a.AlbumId
JOIN Artist ar ON a.ArtistId = ar.ArtistId
WHERE ar.Name = 'Jamiroquai'

-- Write a query that will determine the top 5 countries measured by 
-- total revenue (dollars) sold by billing country (Include country and total revenue).

SELECT BillingCountry AS Country, 
	SUM(Total) AS TotalRevenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalRevenue DESC
LIMIT 5

/* Write a query that determines the total sales (in dollars) by global region.  
 * Create a new column for global_region, and use ‘Asia Pacific’ for India and Australia,
 * ‘North America’ for Canada and the USA, ‘South America’ for Chile, 
 * Brazil and Argentina, and ‘Europe’ for the rest.
 */

SELECT
CASE
WHEN BillingCountry IN ('India', 'Australia') THEN 'Asia Pacific'
WHEN BillingCountry IN ('Canada', 'USA') THEN 'North America'
WHEN BillingCountry IN ('Chile', 'Brazil', 'Argentina') THEN 'South America'
ELSE 'Europe'
END AS GlobalRegion,
    SUM(Total) AS TotalSales
FROM Invoice
GROUP BY GlobalRegion

-- Write a query that lists the artists that don’t have albums. 

SELECT ar.Name AS ArtistName, NULL AS Album
FROM Artist ar
LEFT JOIN Album al ON ar.ArtistId = al.ArtistId
WHERE al.ArtistId IS NULL

/* Write a query that lists all the invoice amounts, their billing country, 
 * and another column with the total amount of revenue from that country.  
 * (Sort largest to smallest)  
 */

SELECT BillingCountry, Total AS InvoiceAmount,
    (
SELECT SUM(Total)
FROM Invoice
WHERE BillingCountry = i.BillingCountry
    ) 
    AS TotalRevenue
FROM Invoice i
ORDER BY TotalRevenue DESC


-- :) ÍÅ´´Î ÅÒÂ¨„ÅÒˆ  That was Fun :) SaeedAlmuwali has left the SQL Building! 











