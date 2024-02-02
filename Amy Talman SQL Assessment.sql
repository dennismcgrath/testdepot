--Part 1

CREATE TABLE Orders (
OrderID PRIMARY KEY, 
CompanyName varchar(255), 
Address varchar(255), 
City varchar(255),
Phone varchar(255),
OrderDate date);

INSERT INTO Orders values
(1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', 2015-01-14),
(2, 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', 2015-05-02),
(3, 'Netflix', '888 Broadway', 'NEW York', '642-612-6123', 2015-06-07);

-- Create a query that will select company name, address, 
--and city from the Orders table for companies located in Chicago.
SELECT CompanyName, Address, City 
FROM Orders 
WHERE City = 'Chicago';

--Create a query that will select all the records from the Orders table where the 
--company name starts with an "A".
SELECT *
FROM Orders 
WHERE CompanyName LIKE 'A%';




--PART 2

--Write a query that will list all of the track names and 
--the album names from the artist named ‘Jamiroquai’.
SELECT t.Name, a.Title AS Album
FROM Track t 
JOIN Album a 
ON t.AlbumId = a.AlbumId 
JOIN Artist a2
ON a2.ArtistId = a.ArtistId 
WHERE a2.Name = 'Jamiroquai';

--Write a query that will determine the top 5 customer countries measured by total revenue (dollars) by billing country.
--Include country and total revenue.

SELECT c.Country, SUM(i.Total) 
FROM Invoice i 
JOIN Customer c 
ON c.CustomerId = i.CustomerId 
GROUP BY c.Country 
ORDER BY SUM(i.Total) DESC
LIMIT 5;

--Write a query that determines the total invoice revenue by global region.  
--Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, 
--‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.
SELECT SUM(i.Total) ,
CASE	
	WHEN c.Country IN ('India', 'Austrailia') THEN 'Asia Pacific'
	WHEN c.Country IN ('Canada', 'USA') THEN 'North America'
	WHEN c.Country IN ('Chile', 'Brazil', 'Argentina') THEN 'South America'
	ELSE 'Europe'
END GlobalRegion
FROM Invoice i 
JOIN Customer c 
ON c.CustomerId = i.CustomerId 
GROUP BY GlobalRegion;


--Write a query that lists the artists and a count of their albums.
--Include artists that don’t have albums. 
SELECT a.Name, COUNT(a2.AlbumId) 
FROM Artist a 
LEFT JOIN Album a2 
ON a.ArtistId = a2.ArtistId 
GROUP BY a.ArtistId;

--Write a query that will list the invoiceID’s that include the most genres. 
--You will want to make sure you don’t count duplicate genres, and there might be a tie for the most. 
--Include invoiceID and genre count in the output
SELECT il.InvoiceId, COUNT(DISTINCT g.Name) 
FROM InvoiceLine il 
JOIN Track t 
ON t.TrackId = il.TrackId 
JOIN Genre g 
ON g.GenreId = t.GenreId 
GROUP BY il.InvoiceId 
ORDER BY COUNT(DISTINCT g.Name) desc


--Write a query that lists all the invoiceIDs, the invoice totals, their billing country,
--and total amount of revenue from that country. 
WITH CountryTotal AS 
(
SELECT i.InvoiceId, SUM(i.Total),
i.BillingCountry 
FROM Invoice i 
GROUP BY i.BillingCountry 
ORDER BY SUM(i.Total) DESC
)
SELECT InvoiceId, Total, BillingCountry, SUM(Total) OVER (PARTITION BY BillingCountry) 
FROM invoice