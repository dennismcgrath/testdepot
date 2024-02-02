---1. CREATE TABLE: 

CREATE TABLE Orders (
OrderID integer PRIMARY KEY,
CompanyName varchar (255),
Adress varchar (255),
City varchar (255), 
Phone varchar (20),
OrderDate DATE
);

--2. INSERT VALUES:
INSERT INTO Orders (OrderID, CompanyName, Adress, City, Phone,OrderDate)
VALUES ('1','Acme','14 Hollywood Blvd','Los Angeles','616-555-1234','
1/14/15'),
('2','Amazon','2801 S Western Ave','Chicago','234-345-5151', '5/2/15'),
('3','Netflix', '888 Broadway','New York','642-612-6123','6/7/15');

--3. Create a query that will select company name, address, and city from the Orders table for companies located in Chicago.
SELECT CompanyName, Adress, City 
FROM Orders o  
WHERE City  = 'Chicago'
GROUP BY CompanyName; 

--4.Create a query that will select all the records from the Orders table where the company name starts with an "A".
SELECT * 
FROM Orders o  
WHERE CompanyName  LIKE 'A%';  

--5. Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.
SELECT a.Name, a2.Title, t.Name 
FROM Artist a 
JOIN Album a2  ON a.ArtistId  = a2.ArtistId 
JOIN Track t ON a2.AlbumId = t.AlbumId 
WHERE a.Name = 'Jamiroquai';

--6. Write a query that will determine the top 5 customer countries measured by total revenue (dollars) by billing country.   Include country and total revenue.
SELECT BillingCountry, sum(Total) AS total_revenue
FROM Invoice i 
GROUP BY BillingCountry 
ORDER BY total_revenue DESC 
LIMIT 5; 

--7. Write a query that determines the total invoice revenue by global region.  Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, ‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.

SELECT
CASE 
	WHEN BillingCountry IN ('India','Australia') THEN 'Asia Pacific'
	WHEN BillingCountry IN ('Canada','USA') THEN 'North America'
	WHEN BillingCountry IN ('Chile','Brazil','Argentina') THEN 'South America'
	ELSE 'Europe'
END AS Global_region,
sum(Total) AS total_invoice_revenue
FROM Invoice i 
GROUP BY Global_region;

--8. Write a query that lists the artists and a count of their albums. Include artists that don’t have albums. 

SELECT a.Name, COUNT(a2.AlbumId) AS count_of_albums
FROM Artist a 
LEFT JOIN Album a2  ON a.ArtistId  = a2.ArtistId 
GROUP BY a.Name; 

--9. Write a query that will list the invoiceID’s that include the most genres.
--You will want to make sure you don’t count duplicate genres, and there might be a tie for the most. 
--Include invoiceID and genre count in the output

WITH InvCount_PerGenre AS 
(
SELECT il.InvoiceId , count(DISTINCT g.Name) AS count_per_genre
FROM InvoiceLine il 
INNER JOIN Track t ON il.TrackId = t.TrackId 
INNER JOIN Genre g ON g.GenreId = t.GenreId 
GROUP BY il.InvoiceId
)
SELECT InvoiceId, count_per_genre
FROM InvCount_PerGenre
WHERE count_per_genre = (SELECT max (count_per_genre) FROM InvCount_PerGenre);

--10. Write a query that lists all the invoiceIDs, the invoice totals, their billing country, and total amount of revenue from that country. 

SELECT InvoiceId, Total AS invoice_total, BillingCountry, 
sum(Total) OVER (PARTITION BY BillingCountry)AS total_revenue_per_country 
FROM Invoice i; 


