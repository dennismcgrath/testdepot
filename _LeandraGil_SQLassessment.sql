--Part 1 - Table creation and basic queries

CREATE TABLE Orders (
	OrderID Integer PRIMARY  KEY, 
	CompanyName VARCHAR(255),
	Address  VARCHAR(255),
	City VARCHAR(255),
	Phone VARCHAR(255),
	OrderDate Date 
)

--Write SQL statements to insert the following into your table

INSERT INTO Orders VALUES(1,'Acme','14 Hollywood Blvd','Los Angles','616-555-1234','2015-01-14');
INSERT INTO Orders VALUES(2,'Amazon','2801 S Western Ave','Chicago','234-345-5151','2015-05-02');
INSERT INTO Orders VALUES(3,'Netflix','888 Broadway','New York','642-612-6123','2015-06-07');

--Create a query that will select company name, address, and city from the Orders table for companies located in Chicago.

SELECT CompanyName, Address, City 
FROM Orders 
WHERE city = 'Chicago';

--Create a query that will select all the records from the Orders table where the company name starts with an "A".

SELECT * 
FROM Orders 
WHERE CompanyName LIKE 'A%';

--Part 2 - Complex queries -- the remaining questions will use the dBeaver Sample Database (music store).  

--Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.
SELECT a.name AS Artist , t.Name AS Track , al.Title  AS Album
FROM Artist a 
JOIN Album al 
ON al.ArtistId = a.ArtistId 
JOIN Track t 
ON t.AlbumId = al.AlbumId 
WHERE a.Name = 'Jamiroquai';


--Write a query that will determine the top 5 customer countries measured by total revenue (dollars) by billing country.  
-- Include country and total revenue.
SELECT BillingCountry AS country, sum(Total) AS total_Revenue 
FROM Invoice i 
GROUP BY BillingCountry
ORDER BY total_Revenue DESC 
LIMIT 5;


-- Write a query that determines the total invoice revenue by global region.  
--Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, 
--‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.
SELECT
CASE 
	WHEN BillingCountry IN ('India','Australia') THEN 'Asia Pacific'
	WHEN BillingCountry IN ('Canada','USA') THEN 'North America'
	WHEN BillingCountry IN ('Chile','Brazil','Argentina') THEN 'South America'
	ELSE 'Europe'
END AS Gobal_Region, 
Sum(total) AS Total_Invoice_Revenue
FROM Invoice i 
GROUP BY Gobal_Region 
ORDER BY Total_Invoice_Revenue DESC; 


--Write a query that lists the artists and a count of their albums. 
--Include artists that don’t have albums. 
SELECT a.Name AS Artisit, count(al.AlbumId) AS Album_Count 
FROM Artist a 
LEFT JOIN Album al
ON al.ArtistId = a.ArtistId 
GROUP BY a.Name; 


-- Write a query that will list the invoiceID’s that include the most genres.
--You will want to make sure you don’t count duplicate genres, 
--and there might be a tie for the most. Include invoiceID and genre count in the output


WITH genres_per_invoice AS
( 
 SELECT il.InvoiceId , COUNT(DISTINCT g.GenreId  ) AS genre_count
 FROM genre g
 JOIN track t 
 ON t.GenreId = g.GenreId
 JOIN InvoiceLine il
 ON il.TrackId = t.TrackId
 GROUP BY il.InvoiceId
 ) 
SELECT InvoiceId , genre_count 
FROM ( SELECT InvoiceId , genre_count, DENSE_RANK() OVER (ORDER BY genre_count DESC) AS rank 
 FROM genres_per_invoice )
WHERE rank = 1;

--Write a query that lists all the invoiceIDs, the invoice totals, their billing country, 
--and total amount of revenue from that country. 
WITH Country_revenue AS
(
SELECT BillingCountry, sum(Total) AS total_revenue 
FROM Invoice i 
GROUP BY BillingCountry 
)
SELECT il.InvoiceId , i.total AS invoice_total, i.BillingCountry , cr.total_revenue 
FROM Invoiceline il 
JOIN invoice i 
ON i.InvoiceId = il.InvoiceId 
JOIN Country_revenue cr 
ON cr.BillingCountry = i.BillingCountry; 