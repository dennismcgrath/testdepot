CREATE TABLE Orders(
Orderid Integer PRIMARY KEY,
CompanyName Varchar (255),
Address varchar (255),
City Varchar (255),
Phone Varchar (255),
OrderDate date
);
INSERT INTO Orders VALUES (1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '6165551234', '2015-1-14');
INSERT INTO Orders VALUES (2, 'Amazon', '2801 S Western Ave', 'Chicago', '2343455151', '2015-5-2');
INSERT INTO Orders VALUES (3, 'Netflix', '888 Broadway', 'New York', '6426126123', '2015-6-7');
SELECT companyname, address, city FROM Orders 
WHERE city = 'Chicago';
SELECT * FROM Orders 
WHERE companyname LIKE 'A_%';

--Write a query that will list all of the track 
--names and the album names from the artist named ‘Jamiroquai’.
SELECT a.name, t.Name, al.title  FROM Artist a 
JOIN Album al
ON al.ArtistId = a.ArtistId 
JOIN Track t 
ON t.AlbumId = al.AlbumId  
WHERE a.name = 'Jamiroquai';
 
--Write a query that will determine the top 5 customer countries measured by total 
--revenue (dollars) by billing country.   
--Include country and total revenue.
SELECT i.BillingCountry, sum(total) AS Rev FROM Customer c 
JOIN Invoice i 
ON i.CustomerId =c.CustomerId 
GROUP BY i.BillingCountry 
ORDER BY rev DESC 
LIMIT 5;

--Question 3

SELECT sum(Total) AS Schmoney, 
(CASE
	WHEN BillingCountry = 'India' OR BillingCountry = 'Australia' THEN 'Asia Pacific'
	WHEN BillingCountry = 'Canada' OR BillingCountry = 'USA' THEN 'North America'
	WHEN BillingCountry = 'Chile' OR BillingCountry = 'Brazil' OR BillingCountry = 'Argentina' THEN 'South America'
	ELSE 'Europe'
END) AS Continent
FROM Invoice i 	
GROUP BY BillingCountry 
ORDER BY Schmoney DESC 

-- Question 4

SELECT ar.name, al.Title  FROM Album al 
Right JOIN Artist ar
ON al.ArtistId =ar.ArtistId 
ORDER BY ar.name asc 

-- Question 5
SELECT i.InvoiceId, count(DISTINCT g.GenreId) AS Types  FROM Invoice i 
JOIN InvoiceLine il 
ON il.InvoiceId = i.InvoiceId 
JOIN track t
ON t.TrackId = il.TrackId 
JOIN Genre g 
ON g.GenreId =t.GenreId 
GROUP BY i.InvoiceId 
ORDER BY types DESC  
LIMIT 4

--Question 6
SELECT BillingCountry, InvoiceId, Total, 
sum(total) OVER(PARTITION BY BillingCountry) AS Country_Revenue
FROM Invoice

