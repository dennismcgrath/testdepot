--Part 1 - Table creation and basic queries
--Create a table called Orders, with the following information:
--Primary Key called OrderID, Company Name, Address,City
--Phone, Order Date in DATE format
CREATE TABLE Orders(
OrderID int PRIMARY KEY,
company_name varchar(255),
Address varchar(255),
city varchar(255),
phone varchar(255),
order_date date);

--Write SQL statements to insert the following into your table:
INSERT INTO Orders values
(1,'Acme','14 Hollywood Blvd','Los Angeles','616-555-1234',2015-01-15-4),
(2,'Amazon','2801 S Western Ave','Chicago','234-345-5151',2015-05-02),
(3,'Netflix','888 Broadway','New York','642-612-6123',2015-06-07);

--Create a query that will select company name, address, 
--and city from the Orders table for companies located 
--in Chicago.
SELECT company_name, Address,city FROM Orders o 
WHERE city = 'Chicago';

--Create a query that will select all the records 
--from the Orders table where the company name 
--starts with an "A".
SELECT * FROM Orders o 
WHERE company_name LIKE 'A%'


--Part 2Complex queries 
-- dBeaver Sample Database (music store).  
--Write a query that will list all of the track names 
--and the album names from the artist named ‘Jamiroquai’.
SELECT t.name,al.Title FROM Track t 
JOIN Album al
ON t.AlbumId = al.AlbumId 
JOIN Artist ar
ON ar.ArtistId = al.ArtistId 
WHERE ar.name = 'Jamiroquai'

--Write a query that will determine the top 5 customer countries
--measured by total revenue (dollars) by billing country.
--Include country and total revenue.
SELECT BillingCountry, sum(total) AS total_revenue FROM Invoice i 
GROUP BY BillingCountry 
ORDER BY total_revenue DESC 
LIMIT 5


--Write a query that determines the total invoice revenue by global region.  
--Use ‘Asia Pacific’ for India and Australia, 
--‘North America’ for Canada and the USA, 
--‘South America’ for Chile, Brazil and Argentina, 
--and ‘Europe’ for the rest.
SELECT Sum(total), 
CASE 
	WHEN BillingCountry IN ('India','Australia') THEN 'Asia Pacific'
	WHEN BillingCountry IN ('Canada','USA') THEN 'North America'
	WHEN BillingCountry IN ('Chile','Brazil','Argentina') THEN 'South America'
	ELSE 'Europe'
END AS GlobalRegion
FROM Invoice i 
GROUP BY GlobalRegion

--Write a query that lists the artists and a count of their albums. 
--Include artists that don’t have albums. 
SELECT ar.name, count(al.AlbumId) 
FROM Artist ar
LEFT JOIN Album al
ON al.ArtistId = ar.ArtistId 
GROUP BY ar.Name 


--Write a query that will list the invoiceID’s that include 
--the most genres. You will want to make sure you don’t 
--count duplicate genres, and there might be a tie for the most. 
--Include invoiceID and genre count in the output
WITH genres_per_invoice AS 
(
SELECT count(DISTINCT t.GenreId) AS genres, InvoiceId 
FROM InvoiceLine i 
JOIN Track t 
ON t.TrackId = i.TrackId
GROUP BY InvoiceId 
)
SELECT InvoiceId, genres
FROM genres_per_invoice
GROUP BY InvoiceId 
HAVING genres = (SELECT max(genres) FROM genres_per_invoice)



--Write a query that lists all the invoiceIDs, 
--the invoice totals, their billing country, 
--and total amount of revenue from that country. 
SELECT InvoiceId, total AS invoice_total, BillingCountry, 
sum(total) over(PARTITION BY BillingCountry) AS country_total
FROM Invoice i 
GROUP BY InvoiceId 
