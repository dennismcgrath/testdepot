/*
Far Lindo
SQL Assessment
FullStack Academy
 * 
--------------------------------------------------------------
Create a table called Orders, with the following information:
    Primary Key called OrderID
    Company Name (include a NOT NULL constraint)
    Address
    City
    Phone
    Order Date in DATE format
*/
--1. Define Table
CREATE TABLE Orders(
	OrderID INT PRIMARY KEY, 
    Company_nane VARCHAR(255) NOT NULL, 
    Address VARCHAR (255),
    City	VARCHAR (255),
    Phone 	TEXT,
    OrderDate DATE    
);

--- Insert table data
INSERT INTO Orders
VALUES (1, "Acme","14 Hollywood Blvd", "Los Angeles", "616-555-1234","1/14/15"),
	   (2, "Amazon","2801 S Western Ave", "chicago","234-345-5151","5/2/15"),
	   (3, "Netflix","888 Broadway", "New York","642-612-6123","6/7/15");

--2. 
SELECT Company_name, Address, City
FROM Orders 
WHERE City = "chicago" 

--3.
SELECT * 
FROM Orders 
WHERE company_name LIKE 'A%';

--4.
---List all Genre names
---Count number of tracks
---Count number of tracks per genre
SELECT g.Name, count(t.GenreId) AS num_of_tracks --OVER(PARTITION BY Name) AS num_of_tracks
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId 
GROUP BY g.Name 
ORDER BY num_of_tracks DESC 

--5. 
SELECT t.Name AS track_name, a2.Title AS album_name
FROM Artist a 
LEFT JOIN Album a2 ON a.ArtistId = a2.ArtistId 
LEFT JOIN Track t ON a2.AlbumId = t.AlbumId 
GROUP BY t.Name, a2.Title  
HAVING a.name = "Jamiroquai";

--6.find total revenue
---Find Total Revenue 
SELECT i.BillingCountry AS Country, SUM(i.Total*il.Quantity) AS total_revenue  
FROM Invoice i 
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId 
GROUP BY i.BillingCountry
ORDER BY total_revenue DESC 
LIMIT 5

--7.Write a query that determines the total sales (in dollars) 
--by global region.  Create a new column for global_region, and 
--use ‘Asia Pacific’ for India and Australia, ‘North America’
--for Canada and the USA, ‘South America’ for Chile, Brazil 
--and Argentina, and ‘Europe’ for the rest.

--I had some issues with this one, I learned a lot, however I 
--need more practice. 
WITH total_sales_cte AS 
(
SELECT i.BillingCountry, c.Country, SUM(il.Unitprice*il.Quantity) AS total_sales 
FROM Customer c  
JOIN Invoice i  ON c.CustomerId  = i.CustomerId 
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId 
GROUP BY i.BillingCountry, c.Country  
ORDER BY total_sales DESC 
)
SELECT 
CASE 
	WHEN Country IN ('India','Australia') THEN 'Asia Facific'
	WHEN Country IN ('Canada','USA') THEN 'North America'
	WHEN Country IN ('Chile','Brazil','Argentina') THEN 'South America'
	ELSE 'Europe'
END AS global_region,
FROM total_sales_cte
GROUP BY global_region

SELECT BillingCountry, c.country  
FROM  global_region





--8.List the artists that don't have albums.
SELECT a.Name, count(a.ArtistId) 
FROM Artist a 
LEFT JOIN Album a2 ON a.ArtistId = a2.ArtistId 
WHERE a2.ArtistId IS NULL 
GROUP BY a.Name; 

--9. List the invoice amounts
--Billing counrty
--A column of revenue from that country
--sort from largest to smallest--Desc 
 SELECT BillingCountry, i.Total AS invoice_amount, il.Quantity 
 AS quantitiy_amount, SUM(il.Quantity*i.Total) 
 AS total_amount_revenue
 FROM Invoice i 
 JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
 GROUP BY i.Total, BillingCountry 
 ORDER BY total_amount_revenue DESC 
 
 
 
 
