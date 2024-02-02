--part 1
--CREATE TABLE Orders(OrderID, CompanyName, Address, City, Phone, Date);

--INSERT INTO Orders
--VALUES 
--('1', 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '2015-01-14'),
--('2', 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '2015-05-02'),
--('3', 'Netflix', '888 Broadway', 'New York', '642-612-6123', '2015-06-07');

--SELECT CompanyName, Address, City FROM Orders
--WHERE City =  'Chicago';

--SELECT * FROM Orders
--WHERE CompanyName LIKE 'A%'



--Part2
--Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.
SELECT t.Name, a2.Title, a.Name FROM Artist a
JOIN Album a2
ON a.ArtistId = a2.ArtistId 
JOIN Track t
ON a2.AlbumId = t.AlbumId 
WHERE a.Name = 'Jamiroquai';

--Write a query that will determine the top 5 customer countries measured 
--by total revenue (dollars) by billing country. Include country and total revenue.

SELECT i.BillingCountry, sum(i.Total)
FROM Customer c
JOIN Invoice i
ON c.CustomerId = i.CustomerId 
GROUP BY c.Country 
ORDER BY sum(i.Total) DESC 
LIMIT 5;

--Write a query that determines the total invoice revenue by global region.  
--Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, 
--‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.


WITH total_revenue AS
(
SELECT *,
CASE
	WHEN BillingCountry IN ('India', 'Australia') THEN 'Asia Pacific'
	WHEN BillingCountry IN ('Canada', 'USA') THEN 'North America'
	WHEN BillingCountry IN ('Chile', 'Brazil', 'Argentina') THEN 'South America'
	ELSE 'Europe'
END AS Global_Regions
FROM Invoice 
)
SELECT Global_Regions, sum(Total) FROM total_revenue
GROUP BY Global_Regions;


--Write a query that lists the artists and a count of their albums. 
--Include artists that don’t have albums. 

SELECT a.Name, count(A2.AlbumId) 
FROM Artist a
LEFT JOIN Album a2
ON a.ArtistId = a2.ArtistId 
GROUP BY a.Name;


--Write a query that will list the invoiceID’s that include the most genres. 
--You will want to make sure you don’t count duplicate genres, and there might be a 
--tie for the most. Include invoiceID and genre count in the output

SELECT count(DISTINCT t.GenreId) AS genre_count, i.InvoiceId
FROM Invoice i
JOIN InvoiceLine il
ON i.InvoiceId = il.InvoiceId 
JOIN Track t
ON il.TrackId = t.TrackId  
GROUP BY i.InvoiceId
ORDER BY count(t.GenreId) DESC;


--Write a query that lists all the invoiceIDs, the invoice totals, 
--their billing country, and total amount of revenue from that country.

SELECT InvoiceId, Total, BillingCountry, 
sum(Total) OVER (PARTITION BY BillingCountry) AS Total_Revenue 
FROM Invoice;

