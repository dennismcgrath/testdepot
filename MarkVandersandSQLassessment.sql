--**PART 1**

--Create a table called Orders with: OrderID (Primary), CompanyName, Address, City
--Phone, OrderDate (in DATE format) 
CREATE TABLE Orders(
OrderID integer,
CompanyName varchar(255),
Address varchar(255),
City varchar(255),
Phone varchar(255),
OrderDate datetime,
PRIMARY KEY (OrderID)
);

--Insert the following
INSERT INTO Orders VALUES (1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '1/14/15');
INSERT INTO Orders VALUES (2, 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '5/2/15');
INSERT INTO Orders VALUES (3, 'Netflix', '888 Broadway', 'New York', '642-612-6123', '6/7/15');

--Create a query that will select company name, address, and city 
--from the Orders table for companies located in Chicago.
SELECT o.CompanyName, o.Address, o.City 
FROM Orders o  
WHERE o.City LIKE 'Chicago';

--Create a query that will select all the records from the Orders table 
--where the company name starts with an "A".
SELECT *
FROM Orders o
WHERE o.CompanyName LIKE 'A%';

--**THIS IS ONLY HERE SO I DON'T HAVE EXTRA TABLES IN THE DATABASE**
DROP TABLE Orders;


--**PART 2**


--Write a query that will list all of the track names and the album names
--from the artist named ‘Jamiroquai’.
SELECT t.Name, a.Title 
FROM Track t 
JOIN Album a ON t.AlbumId = a.AlbumId 
JOIN Artist a2 ON a.ArtistId = a2.ArtistId 
WHERE a2.Name LIKE 'Jamiroquai';

--Write a query that will determine the top 5 customer countries
--measured by total revenue (dollars) by billing country.
--Include country and total revenue.
SELECT BillingCountry, SUM(Total)
FROM Invoice 
GROUP BY BillingCountry 
ORDER BY sum(Total) DESC 
LIMIT 5;

--Write a query that determines the total invoice revenue by global region.
--Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA,
--‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.
SELECT SUM(Total), 
CASE 
	WHEN BillingCountry IN ('India', 'Australia') THEN 'Asia Pacific'
	WHEN BillingCountry IN ('Canada', 'USA') THEN 'North America'
	WHEN BillingCountry IN ('Chile', 'Brazil', 'Argentina') THEN 'South America'
	ELSE 'Europe'
END AS GlobalRegion
FROM Invoice 
GROUP BY GlobalRegion;

--Write a query that lists the artists and a count of their albums.
--Include artists that don’t have albums. 
 SELECT a.Name , COUNT(a2.AlbumId) 
 FROM Artist a 
 LEFT JOIN Album a2 ON a.ArtistId = a2.ArtistId 
 GROUP BY a.Name ;
 
--Write a query that will list the invoiceID’s that include the most genres.
--You will want to make sure you don’t count duplicate genres, and there
--might be a tie for the most. Include invoiceID and genre count in the output
SELECT il.InvoiceId , COUNT(DISTINCT g.GenreId) AS GenreCount
FROM InvoiceLine il 
JOIN Track t ON il.TrackId = t.TrackId 
JOIN Genre g ON t.GenreId = g.GenreId 
GROUP BY il.InvoiceId 
ORDER BY GenreCount DESC ;

--Write a query that lists all the invoiceIDs, the invoice totals, their
--billing country, and total amount of revenue from that country. 
SELECT i.InvoiceId, i.Total, i.BillingCountry,
SUM(i.Total) OVER (PARTITION BY i.BillingCountry) AS CountryTotal
FROM Invoice i 
GROUP BY i.InvoiceId, i.Total, i.BillingCountry ;
