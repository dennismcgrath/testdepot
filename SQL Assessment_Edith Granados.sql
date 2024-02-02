-----PART 1
CREATE TABLE orders (
	OrderID integer PRIMARY KEY,
	Company VARCHAR(255),
	Address VARCHAR(255),
	City VARCHAR(255),
	Phone VARCHAR(15),
	OrderDate DATE
	);

DROP TABLE orders;

INSERT INTO orders VALUES 
(1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '1/14/15'),
(2, 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '5/2/15'),
(3, 'Netflix', '888 Broadway', 'New York', '642-612-6123', '6/7/15');

--Create a query that will select company name, address, and city from the Orders table for companies located in Chicago.
SELECT company, address, City FROM orders o 
WHERE City = 'Chicago'

--Create a query that will select all the records from the Orders table where the company name starts with an "A".
SELECT company FROM orders o 
WHERE company LIKE '%A%'


-----PART 2
--Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.
SELECT t.name, a.Title FROM Album a 
JOIN Track t ON a.AlbumId = t.AlbumId
JOIN Artist ar ON ar.ArtistId = a.ArtistId 
WHERE ar.Name = 'Jamiroquai'

--Write a query that will determine the top 5 customer countries measured by total revenue (dollars) by billing country.   Include country and total revenue.
SELECT c.country, SUM(i.Total)  FROM Customer c 
JOIN Invoice i ON c.CustomerId = i.CustomerId 
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY c.Country
ORDER BY SUM(i.Total) DESC 
LIMIT 5

--Write a query that determines the total invoice revenue by global region
--Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, ‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.
WITH country_total AS 
(
SELECT BillingCountry, SUM(Total) AS order_total,
CASE 
	WHEN BillingCountry IN ('India', 'Australia') THEN 'Asia Pacific'
	WHEN BillingCountry IN ('USA', 'Canada') THEN 'North America'
	WHEN BillingCountry IN ('Chile', 'Brazil', 'Argentina') THEN 'South America'
	ELSE 'Europe'
 END global_region
FROM Invoice i 
GROUP BY BillingCountry 

)
SELECT global_region, SUM(order_total) FROM country_total
GROUP BY global_region

--Write a query that lists the artists and a count of their albums. Include artists that don’t have albums. 
SELECT a.Name, COUNT(a2.Title) AS album_count
FROM Artist a 
LEFT JOIN Album a2 ON a.ArtistId = a2.ArtistId 
GROUP BY a.Name

--Write a query that will list the invoiceID’s that include the most genres.
--You will want to make sure you don’t count duplicate genres, and there might be a tie for the most.
--Include invoiceID and genre count in the output
WITH total_genre AS
(
SELECT il.InvoiceId, g.name, COUNT(DISTINCT g.Name) AS genre_count
FROM Genre g 
JOIN Track t ON g.GenreId = t.GenreId 
JOIN InvoiceLine il ON il.TrackId = t.TrackId 
GROUP BY il.InvoiceId 
)
SELECT invoiceID, genre_count
FROM total_genre
WHERE genre_count = (SELECT MAX(genre_count) FROM total_genre)


--Write a query that lists all the invoiceIDs, the invoice totals, their billing country, and total amount of revenue from that country. 
WITH order_total AS
(
SELECT i.BillingCountry, SUM(Total) AS invoice_total
FROM Invoice i 
GROUP BY i.BillingCountry
)
SELECT i.InvoiceId, i.Total, i.BillingCountry, invoice_total FROM order_total AS o
JOIN invoice i
ON i.BillingCountry = o.BillingCountry

