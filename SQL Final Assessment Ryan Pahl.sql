--Part 1 - Table creation and basic queries

--Create a table called Orders, with the following information:
--Primary Key called OrderID
--Company Name 
--Address
--City
--Phone
--Order Date in DATE format
--Write SQL statements to insert the following into your table:

CREATE TABLE Orders 
(OrderID INT PRIMARY KEY,
Company_Name varchar(255),
Address varchar(255),
City varchar (255),
Phone text,
Order_Date date)


INSERT INTO Orders 
VALUES ( '1', 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '2015-01-14'),
('2', 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '2015-05-02'),
('3', 'Netflix', '888 Broadway', 'New York', '642-612-6123', '2015-06-07')



--Create a query that will select company name, address, and city from the Orders table for companies located in Chicago.

SELECT company_name, address, city FROM Orders 
WHERE city = 'Chicago'



--Create a query that will select all the records from the Orders table where the company name starts with an "A".
 
SELECT * FROM Orders 
WHERE company_name LIKE 'A%'

--Part 2 - Complex queries -- the remaining questions will use the dBeaver Sample Database (music store).  


--Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.

SELECT t.name, a.title AS album_title, a2.name FROM Track t 
JOIN Album a 
ON a.AlbumId = t.AlbumId 
JOIN Artist a2 
ON a.ArtistId = a2.ArtistId 
WHERE a2.name = 'Jamiroquai'

--Write a query that will determine the top 5 customer countries measured by total revenue (dollars) by billing country.   Include country and total revenue.

SELECT sum(i.total) AS Total_revenue, i.BillingCountry FROM Invoice i 
JOIN InvoiceLine il 
ON il.InvoiceId = i.InvoiceId 
GROUP BY i.BillingCountry 
ORDER BY total_revenue DESC
LIMIT 5


--Write a query that determines the total invoice revenue by global region.  Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, ‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.

WITH country_totals AS 
(
SELECT sum(i.total) AS Total_revenue, i.BillingCountry, 
CASE 
	WHEN i.BillingCountry IN ('USA', 'Canada') THEN 'North America'
	WHEN i.billingcountry IN ('India', 'Australia') THEN 'Asia Pacific'
	WHEN i.billingcountry IN ( 'Chile', 'Brazil', 'Argentina') THEN 'South America'
	ELSE 'Europe'
END AS Global_region
FROM Invoice i 
JOIN InvoiceLine il 
ON il.InvoiceId = i.InvoiceId 
GROUP BY i.BillingCountry 
ORDER BY total_revenue DESC
)
SELECT *, sum(total_revenue) OVER (PARTITION BY global_region) AS global_region_revenue
FROM country_totals

--Write a query that lists the artists and a count of their albums. Include artists that don’t have albums. 

SELECT a.name, count(a2.AlbumId) FROM Artist a 
left JOIN Album a2 
ON a.ArtistId = a2.ArtistId 
GROUP BY a.name

--Write a query that will list the invoiceID’s that include the most genres. You will want to make sure you don’t count duplicate genres, and there might be a tie for the most. Include invoiceID and genre count in the output

SELECT il.invoiceid, count(DISTINCT g.Name) AS genre_count FROM Invoice i 
JOIN InvoiceLine il 
ON il.InvoiceLineId = i.InvoiceId 
JOIN Track t 
ON t.TrackId = il.TrackId 
JOIN Genre g 
ON g.GenreId = t.GenreId 
GROUP BY il.InvoiceId 
ORDER BY count(DISTINCT g.Name) desc



--Write a query that lists all the invoiceIDs, the invoice totals, their billing country, and total amount of revenue from that country. 

WITH invoice_country AS
(
SELECT InvoiceId, sum(Total) AS invoice_total, BillingCountry 
FROM Invoice i 
GROUP BY InvoiceId 
)
SELECT *, sum(invoice_total) OVER (PARTITION BY BillingCountry) FROM invoice_country

