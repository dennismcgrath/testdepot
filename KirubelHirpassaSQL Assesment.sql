--Part 1 - Table creation and basic queries
 --Create a table called Orders, with the following information:
   -- Primary Key called OrderID
   -- Company Name 
   -- Address
   -- City
   -- Phone
   -- Order Date in DATE format

CREATE TABLE Orders (
 orderID  PRIMARY KEY,
 CompanyName varchar(255),
 Address varchar(255),
 city varchar(255),
 phone Varchar(255),
 Orderdate date 
)
--Write SQL statements to insert the following into your table:

INSERT INTO Orders (OrderID, CompanyName, Address, City, Phone, OrderDate)
VALUES (1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '2015-01-14');

INSERT INTO Orders (OrderID, CompanyName, Address, City, Phone, OrderDate)
VALUES (2, 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '2015-05-02');

INSERT INTO Orders (OrderID, CompanyName, Address, City, Phone, OrderDate)
VALUES (3, 'Netflix', '888 Broadway', 'New York', '642-612-6123', '2015-06-07');

-- Create a query that will select company name, address, and city from the Orders table for companies located in Chicago.

SELECT CompanyName,Address,city
FROM Orders
WHERE city='Chicago'

SELECT * FROM Orders 
WHERE CompanyName LIKE 'A%'

-- Part 2 - Complex queries -- the remaining questions will use the dBeaver Sample Database (music store).  
   --Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.

SELECT t.Name AS Track_Name ,a.Title AS Album_Title  
FROM Track t 
JOIN Album a ON a.AlbumId =t.AlbumId 
JOIN Artist a2 ON a2.ArtistId =a.ArtistId 
WHERE a2.Name = 'Jamiroquai'

--Write a query that will determine the top 5 customer countries measured by total revenue (dollars) by billing country.   Include country and total revenue.

SELECT c.Country , SUM(il.Quantity*il.UnitPrice) AS Total_Revenue 
FROM Invoice i 
JOIN Customer c ON c.CustomerId =i.CustomerId 
JOIN InvoiceLine il ON il.InvoiceId =i.InvoiceId 
GROUP BY c.Country 
ORDER BY Total_Revenue  DESC 
LIMIT 5

 --Write a query that determines the total invoice revenue by global region.  Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, ‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.

SELECT SUM(il.Quantity*il.UnitPrice) AS Total_Revenue ,
 CASE 
 	WHEN c.Country IN ('India','Australia') THEN 'Asia Pacific'
 	WHEN c.Country IN ('Canada','USA') THEN 'North America'
 	WHEN c.Country IN ('Chile','Brazil','Argentina') THEN 'South America'
    ELSE 'Europe'
 	END AS GlobalRegion 
 FROM Invoice i 
  JOIN Customer c ON c.CustomerId =i.CustomerId 
  JOIN InvoiceLine il ON il.InvoiceId =i.InvoiceId 
GROUP BY GlobalRegion

 --Write a query that lists the artists and a count of their albums. Include artists that don’t have albums. 
 
SELECT a.Name , COUNT(a2.AlbumId) AS Album_count 
FROM Artist a 
LEFT JOIN Album a2 ON a2.ArtistId =a.ArtistId -- we use left join to include artists that don't have matching records in the Album table
GROUP BY a.ArtistId ,a.Name 

 --Write a query that will list the invoiceID’s that include the most genres. You will want to make sure you don’t count duplicate genres, and there might be a tie for the most. Include invoiceID and genre count in the output

WITH Invoice_Genre_count AS 
(
SELECT il.InvoiceId , COUNT(DISTINCT t.GenreId) AS genre_count 
FROM InvoiceLine il 
JOIN Track t ON t.TrackId =il.TrackId 
GROUP BY il.InvoiceId 
)
SELECT InvoiceId ,genre_count
FROM Invoice_Genre_count 
WHERE genre_count = (SELECT max(genre_count)FROM Invoice_Genre_count)

 --Write a query that lists all the invoiceIDs, the invoice totals, their billing country, and total amount of revenue from that country. 

SELECT i.InvoiceId ,c.Country AS Billing_Country,
SUM(il.UnitPrice*il.Quantity) AS invoice_total,
SUM(il.UnitPrice*il.Quantity) OVER (PARTITION BY c.Country)AS Total_Country_revenue
FROM Invoice i 
JOIN InvoiceLine il ON il.InvoiceId = i.InvoiceId
JOIN Customer c ON c.CustomerId =i.CustomerId 
GROUP BY i.InvoiceId ,c.Country 
ORDER BY i.InvoiceId 
 













