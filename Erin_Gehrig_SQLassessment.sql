--PART 1--Create a table called Orders, with the following information:
--Primary Key called OrderID
--Company Name 
--Address
--City
--Phone
--Order Date in DATE format
CREATE TABLE Orders (
	OrderID integer PRIMARY KEY,
	Company_name varchar(255),
	Address varchar (255),
	City varchar (255),
	Phone varchar (255),
	Order_Date DATE
);

--Write SQL statements to insert the following into your table:
--order_id--company_name--address--city--Phone--order date
--1--Acme--14 Hollywood Blvd--Los Angeles--616-555-1234--1/14/15
--2--Amazon--2801 S Western Ave--Chicago--234-345-5151--5/2/15
--3--Netflix--888 Broadway--New York--642-612-6123--6/7/15
INSERT INTO Orders VALUES
(1,'Acme','14 Hollywood Blvd','Los Angeles','616-555-1234','2015-01-14'),
(2,'Amazon','2801 S Western Ave','Chicago','234-345-5151','2015-05-02'),
(3,'Netflix','888 Broadway','New York','642-612-6123','2015-06-07');

--Create a query that will select company name, address, and city
--from the Orders table for companies located in Chicago.
SELECT Company_name , Address , City 
FROM Orders
WHERE City = 'Chicago'

--Create a query that will select all the records from the Orders table
--where the company name starts with an "A".
SELECT * 
FROM orders
WHERE Company_name LIKE 'A%'

--PART 2--Write a query that will list all of the track names and 
--the album names from the artist named ‘Jamiroquai’.
SELECT t.Name , a.Title , a2.Name
FROM Track t 
LEFT JOIN Album a 
ON t.AlbumId = a.AlbumId 
LEFT JOIN Artist a2 
ON a.ArtistId = a2.ArtistId 
WHERE a2.Name = 'Jamiroquai'

--Write a query that will determine the top 5 customer
--countries measured by total revenue (dollars) by 
--billing country.   Include country and total revenue.
SELECT c.Country , SUM(i.Total) AS total_revenue
FROM Customer c 
JOIN Invoice i 
ON i.CustomerId = c.CustomerId 
GROUP BY c.Country 
ORDER BY total_revenue DESC 
LIMIT 5

--Write a query that determines the total invoice 
--revenue by global region.  Use ‘Asia Pacific’ for 
--India and Australia, ‘North America’ for Canada and 
--the USA, ‘South America’ for Chile, Brazil and 
--Argentina, and ‘Europe’ for the rest.
SELECT SUM(Total) AS Total_revenue,
CASE
	WHEN BillingCountry IN('India','Australia') THEN 'Asia Pacific'
	WHEN BillingCountry IN('Canada','USA') THEN 'North America'
	WHEN BillingCountry IN('Chile','Brazil','Argentina') THEN 'South America'
	ELSE 'Europe'
END AS Global_Region
FROM Invoice i 
GROUP BY Global_Region

--Write a query that lists the artists and a count of 
--their albums. Include artists that don’t have albums. 
SELECT a.Name , COUNT(a2.AlbumId) AS album_count 
FROM Artist a 
LEFT JOIN Album a2 
ON a.ArtistId = a2.ArtistId 
GROUP BY a.Name 

--Write a query that will list the invoiceID’s that 
--include the most genres. You will want to make sure 
--you don’t count duplicate genres, and there might be 
--a tie for the most. Include invoiceID and genre count
--in the output
WITH unique_genres AS 
(
SELECT InvoiceId , COUNT(name) AS genre_count
FROM (SELECT DISTINCT g.Name , il.InvoiceId 
FROM Genre g  
JOIN Track t ON g.GenreId = t.GenreId 
JOIN InvoiceLine il ON il.TrackId = t.TrackId)
GROUP BY invoiceid
)
SELECT invoiceid, genre_count
FROM unique_genres
WHERE genre_count = (SELECT max(genre_count) FROM unique_genres)

--Write a query that lists all the invoiceIDs, 
--the invoice totals, their billing country, and total 
--amount of revenue from that country. 
SELECT InvoiceId , Total , BillingCountry,
sum(Total) over(PARTITION BY BillingCountry)
AS revenue_by_country FROM Invoice i 