--Create a table called Orders, with the following information:
--Primary Key called OrderID
--Company Name 
--Address
--City
--Phone
--Order Date in DATE format
--Write SQL statements to insert the following into your table:
CREATE TABLE Orders (
	OrderID INTEGER PRIMARY KEY,
	Company_Name VARCHAR(255),
    Address VARCHAR(255), 
    City VARCHAR(255),
    Phone VARCHAR(255),
    Order_Date DATE
	);
	
INSERT INTO Orders VALUES 
(1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '2015-01-14'),
(2, 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '2015-05-02'),
(3, 'Netflix', '888 Broadway', 'New York', '642-612-6123', '2015-06-07');
--Create a query that will select company name, address, and city from the Orders table for companies located in Chicago.
SELECT Company_Name, Address, City FROM Orders 
WHERE City = 'Chicago'

--Create a query that will select all the records from the Orders table where the company name starts with an "A".
SELECT * FROM Orders 
WHERE Company_Name LIKE 'A%' 

Part 2 - Complex queries -- the remaining questions will use the dBeaver Sample Database (music store).  

 

--Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.
SELECT a2.Name, a.Title AS Album, t.Name AS Track
FROM Artist a2
JOIN Album a 
ON a.ArtistId = a2.ArtistId
JOIN Track t 
ON t.AlbumId = a.AlbumId 
WHERE a2.Name = 'Jamiroquai'

--Write a query that will determine the top 5 customer countries measured by total revenue (dollars) by billing country.   Include country and total revenue.
SELECT c.Country, sum(i.Total) AS Total_Revenue
FROM Customer c 
JOIN Invoice i  
ON c.CustomerId = i.CustomerId 
GROUP BY c.Country  
ORDER BY Total_Revenue DESC
LIMIT 5

--Write a query that determines the total invoice revenue by global region.  Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, ‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.
SELECT BillingCountry, SUM(Total) AS Total_Invoice_Revenue,
CASE 
	WHEN BillingCountry IN ('India', 'Australia') THEN 'Asia Pacific'
	WHEN BillingCountry IN ('USA', 'Canada') THEN 'North America'
	WHEN BillingCountry IN ('Chile', 'Brazil', 'Argentina') THEN 'South America'
	ELSE 'Europe'
END AS Global_Region
FROM Invoice i
GROUP BY BillingCountry 

--Write a query that lists the artists and a count of their albums. Include artists that don’t have albums. 
SELECT a2.Name AS Artist, COUNT(a.AlbumId) AS Album_Count
FROM Artist a2 
LEFT JOIN Album a
ON a.ArtistId = a2.ArtistId
GROUP BY a2.Name

--Write a query that will list the invoiceID’s that include the most genres. You will want to make sure you don’t count duplicate genres, and there might be a tie for the most. Include invoiceID and genre count in the output
SELECT DISTINCT il.InvoiceId, COUNT(t.GenreId) AS Genre_Count
FROM InvoiceLine il 
LEFT JOIN Track t
ON il.TrackId = t.TrackId
GROUP BY il.InvoiceId
ORDER BY Genre_Count DESC

--Write a query that lists all the invoiceIDs, the invoice totals, their billing country, and total amount of revenue from that country. 
WITH invoice_total AS
(
SELECT il.InvoiceId, i.BillingCountry,
SUM(i.Total) AS Total 
FROM Invoice i 
JOIN InvoiceLine il 
ON il.InvoiceId = i.InvoiceId 
GROUP BY i.InvoiceId
ORDER BY Total DESC
)
SELECT *, SUM(Total) OVER (PARTITION BY BillingCountry) AS Country_Sum
FROM invoice_Total
