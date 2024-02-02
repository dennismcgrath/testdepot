/* 
Part 1
Create a table called Orders, with the following information:

    Primary Key called OrderID
    Company Name 
    Address
    City
    Phone
    Order Date in DATE format
    
*/

CREATE TABLE orders (
OrderID integer, 
company_name varchar(255),
address varchar (255),
city varchar (255),
Phone varchar (255),
Order_Date DATE 
);

INSERT INTO orders (OrderID, company_name, address, city, Phone, Order_Date)
VALUES ('1', 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '1/14/15');
INSERT INTO orders (OrderID, company_name, address, city, Phone, Order_Date)
VALUES ('2', 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '5/2/15');
INSERT INTO orders (OrderID, company_name, address, city, Phone, Order_Date)
VALUES ('3', 'Netflix', '888 Broadway', 'New York', '642-612-6123', '6/7/15');

SELECT company_name, address, city 
FROM orders o 
WHERE city = 'Chicago'
GROUP BY company_name, address, city 

SELECT *
FROM orders o 
WHERE company_name LIKE 'A%'
GROUP BY company_name, address, city 

/*
PART 2

Write a query that will list all of the track names and the album names
from the artist named ‘Jamiroquai’.


Write a query that will determine the top 5 customer countries
measured by total revenue (dollars) by billing country.   
Include country and total revenue.


Write a query that determines the total invoice revenue by global region.  
Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, 
‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.


Write a query that lists the artists and a count of their albums. 
Include artists that don’t have albums. 


Write a query that will list the invoiceID’s that include the most genres. 
You will want to make sure you don’t count duplicate genres, and there might be a tie
 for the most. Include invoiceID and genre count in the output


Write a query that lists all the invoiceIDs, the invoice totals, 
their billing country, and total amount of revenue from that country. 

*/

-- 1 Write a query that will list all of the track names and the album names
-- from the artist named ‘Jamiroquai’.

SELECT t.Name, a.Title  
FROM Track t 
JOIN Album a 
ON t.AlbumId = a.AlbumId 
JOIN Artist a2 
ON a.ArtistId = a2.ArtistId 
WHERE a2.Name = 'Jamiroquai'
GROUP BY t.Name, a.Title 

-- 2. Write a query that will determine the top 5 customer countries
--		measured by total revenue (dollars) by billing country.   
--		Include country and total revenue.

SELECT BillingCountry, SUM(total) AS country_total_invoice
FROM Invoice i 
GROUP BY BillingCountry 
ORDER BY country_total_invoice DESC 
LIMIT 5

-- 3. Write a query that determines the total invoice revenue by global region.  
--	Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, 
--	‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.

SELECT SUM(Total) AS continent_revenue,
CASE 
	WHEN billingcountry in ('USA', 'Mexico', 'Canada') THEN 'North America'
	WHEN billingcountry IN ('Brazil', 'Venezuela', 'Argentina', 'Chile') THEN 'South America'
	WHEN BillingCountry IN ('Australia') THEN 'Australia'
	ELSE 'Europe'
END AS Continent
FROM Invoice i 
GROUP BY continent

-- 4. Write a query that lists the artists and a count of their albums. 
-- Include artists that don’t have albums. 

SELECT a.Name AS Artist, COUNT(al.Title) AS total_albums
FROM Artist a 
LEFT JOIN Album al 
ON a.ArtistId = al.ArtistId 
GROUP BY a.Name
ORDER BY total_albums DESC 

-- 5. Write a query that will list the invoiceID’s that include the most genres. 
--		You will want to make sure you don’t count duplicate genres, 
--		and there might be a tie
--		for the most. Include invoiceID and genre count in the output

SELECT count(DISTINCT g.GenreId) AS num_of_unique_genre, 
il.InvoiceId
FROM InvoiceLine il 
JOIN Track t 
ON il.TrackId = t.TrackId 
JOIN Genre g 
ON t.GenreId = g.GenreId
GROUP BY il.InvoiceId
HAVING count(DISTINCT g.GenreId) > 6
ORDER BY num_of_unique_genre DESC 

-- 6. Write a query that lists all the invoiceIDs, the invoice totals, 
--	  their billing country, and total amount of revenue from that country. 

SELECT InvoiceId, BillingCountry, Total AS invoice_revenue,  
SUM(Total) OVER (PARTITION BY BillingCountry) AS country_revenue
FROM Invoice i 
GROUP BY InvoiceId, Total, BillingCountry 



























