/*Part 1 - Table creation and basic queries
 Create a table called Orders, with the following information:
        Primary Key called OrderID
        Company Name 
        Address
        City
        Phone
        Order Date in DATE format
*/
CREATE TABLE Orders (
	OrderID INTEGER PRIMARY KEY,
	Company_Name varchar(255),
	Address varchar(255),
	City varchar(255),
	Phone varchar(255),
	Order_Date DATE 
);


/*Write SQL statements to insert the following into your table:
order_id company_name address city Phone order date

Acme 14 Hollywood Blvd Los Angeles 616-555-1234 1/14/15

Amazon 2801 S Western Ave Chicago 234-345-5151 5/2/15

Netflix 888 Broadway	New York 642-612-6123 6/7/15
*/
INSERT INTO Orders (Company_Name,Address,City,Phone,Order_Date)
VALUES 
	('Acme','14 Hollywood Blvd','Los Angeles','615-555-1234','1/14/15'),
	('Amazon','2801 S Western Ave','Chicago','234-345-5151','5/2/15'),
	('Netflix','888 Broadway','New York','642-612-6123','6/7/15');

--Create a query that will select company name, address, and city from the Orders table for companies located in Chicago.
SELECT Company_Name,Address,City
FROM Orders o 
WHERE City = 'Chicago'

--Create a query that will select all the records from the Orders table where the company name starts with an "A".
SELECT *
FROM Orders o 
WHERE Company_Name LIKE 'A%'
 



--Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.
SELECT t.Name, al.Title, a.Name AS Artist
FROM Artist a 
JOIN Album al ON a.ArtistId = al.ArtistId 
JOIN Track t ON al.AlbumId = t.AlbumId 
WHERE a.Name = 'Jamiroquai';

--Write a query that will determine the top 5 customer countries measured by total revenue (dollars) by billing country.   
--Include country and total revenue.
WITH billcountry_total AS 
( 
SELECT BillingCountry, sum(Total) AS total_revenue
FROM Invoice il2
GROUP BY BillingCountry
)
SELECT DISTINCT c.Country, bt.BillingCountry, bt.total_revenue
FROM Customer c 
JOIN Invoice i ON c.CustomerId = i.CustomerId 
JOIN billcountry_total bt ON i.BillingCountry = bt.BillingCountry
ORDER BY bt.total_revenue DESC 
LIMIT 5;

--Write a query that determines the total invoice revenue by global region.  
--Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, 
--‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.
SELECT sum(Total) AS total_revenue,
CASE 
	WHEN BillingCountry IN ('India','Australia') THEN 'Asia Pacific'
	WHEN BillingCountry IN ('Canada','USA') THEN 'North America'
	WHEN BillingCountry IN ('Chile','Brazil','Argentina') THEN 'South America'
	ELSE 'Europe'
END AS Global_Region
FROM Invoice i
GROUP BY Global_Region;


--Write a query that lists the artists and a count of their albums. 
--Include artists that don’t have albums. 
SELECT a.Name, count(al.AlbumId) AS album_count
FROM Artist a 
LEFT JOIN Album al ON a.ArtistId = al.ArtistId 
GROUP BY a.Name 
ORDER BY count(al.AlbumId);


--Write a query that will list the invoiceID’s that include the most genres. 
--You will want to make sure you don’t count duplicate genres, and there might be a tie for the most. 
--Include invoiceID and genre count in the output
WITH invoicegenres AS 
(
SELECT DISTINCT i.InvoiceId, count(g.GenreID) AS genre_count
FROM Genre g 
JOIN Track t ON g.GenreId = t.GenreId 
JOIN InvoiceLine il ON t.TrackId = il.TrackId 
JOIN Invoice i ON i.InvoiceId = il.InvoiceId 
GROUP BY i.InvoiceId 
)
SELECT InvoiceId, genre_count
FROM invoicegenres
WHERE genre_count = (SELECT max(genre_count) FROM invoicegenres)


--Write a query that lists all the invoiceIDs, the invoice totals, their billing country, 
--and total amount of revenue from that country.
SELECT InvoiceId, Total, BillingCountry,
sum(Total) OVER (PARTITION BY BillingCountry) AS country_revenue
FROM Invoice i 
GROUP BY InvoiceId;


