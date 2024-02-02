--Create a table called Orders, with the following information

CREATE TABLE Orders(
	OrderID Integer PRIMARY KEY,
	Company_Name varchar(255),
	Address Varchar(255),
	City Varchar(255),
	Phone Varchar(255),
	Order_Date DATE
);

--Write SQL statements to insert the following into your table

INSERT INTO Orders (OrderID, Company_Name, Address, City, Phone, Order_Date)
VALUES (1, 'Acme', '14 Hollywood Boulevard', 'Los Angeles', '616-555-1234', '01-14-15') , (2, 'Amazon', '2801 S Western Ave','Chicago', '234-345-5151', '05-02-15'),
(3, 'Netflix', '888 Broadway', 'NEW York', '642-612-6123', '06-07-15');

--Create a query that will select company name, address, 
--and city from the Orders table for companies located in Chicago.

SELECT Company_Name, Address, City FROM orders
WHERE City = 'Chicago';

--Create a query that will select all the records from the Orders 
--table where the company name starts with an "A".

SELECT * FROM Orders
WHERE company_name LIKE 'A%';

--Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.

SELECT t.Name , a2.Name  
FROM Track t 
JOIN Album a 
ON t.AlbumId = a.AlbumId 
JOIN Artist a2
ON a2.ArtistId = a.ArtistId 
WHERE a2.Name  = 'Jamiroquai';

--Write a query that will determine the top 5 customer countries measured by total revenue (dollars) 
--by billing country.  Include country and total revenue.

SELECT c.Country ,sum(i.Total) AS total_revenue 
FROM Customer c 
JOIN Invoice i 
ON c.CustomerId =i.CustomerId 
GROUP BY c.Country 
ORDER BY sum(i.total) DESC 
LIMIT 5;

--Write a query that determines the total invoice revenue by global region.
-- Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, 
--‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.

SELECT c.country , sum(i.total),
CASE 
	WHEN c.Country IN ('India',' Australia') THEN 'Asia_Pacific'
	WHEN c.country IN ('Canada','USA') THEN 'North_America'
	WHEN c.Country IN ('Chile','Brazil','Argentina') THEN 'South_America'
	ELSE 'Europe'
END AS Global_Region
FROM Customer c 
JOIN Invoice i 
ON c.CustomerId = i.CustomerId 
GROUP BY c.Country
ORDER BY sum(i.total)

--Write a query that lists the artists and a count of their albums. 
--Include artists that don’t have albums.

SELECT a.Name , COUNT(al.AlbumId)  FROM Artist a 
LEFT JOIN Album al 
ON a.ArtistId = al.ArtistId 
GROUP BY a.Name 
ORDER BY count(al.AlbumId)

--Write a query that will list the invoiceID’s that include the most genres. 
--You will want to make sure you don’t count duplicate genres, and there might be a tie for the most. 
--Include invoiceID and genre count in the output

WITH most_genre AS 
(
SELECT i.InvoiceId , g.Name, count(DISTINCT t.GenreId) AS total_genre  FROM Track t 
JOIN InvoiceLine il 
ON il.TrackId = t.TrackId 
JOIN Invoice i 
ON i.InvoiceId = il.InvoiceId 
RIGHT JOIN Genre g 
ON t.GenreId = g.GenreId 
GROUP BY i.InvoiceId 
ORDER BY count(DISTINCT t.GenreId) DESC 
)
SELECT invoiceID, name, total_genre  FROM most_genre
WHERE total_genre = (SELECT max(total_genre) FROM most_genre)

--Write a query that lists all the invoiceIDs, the invoice totals, 
--their billing country, and total amount of revenue from that country. 

WITH total_sales AS 
(
SELECT InvoiceId ,Total, BillingCountry  FROM Invoice i 
)
SELECT InvoiceId ,BillingCountry , total, 
sum(total) OVER ( PARTITION BY BillingCountry) AS total_revenue
FROM total_sales