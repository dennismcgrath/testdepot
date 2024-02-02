--Part 1

CREATE TABLE orders_table
	(order_id INTEGER PRIMARY KEY,
	company_name VARCHAR(255),
	address VARCHAR(255),
	city VARCHAR(255),
	Phone VARCHAR(255),
	order_date DATE);
	
INSERT INTO orders_table VALUES 
('1', 'Acme','14 Hollywood Blvd', 'Los Angeles', '616-555-1234','1/14/15'),
('2', 'Amazon', '2801 S Western Ave', 'Chicago', '243-345-5151', '5/02/15'),
('3', 'Netflix', '888 Broadway', 'New York', '642-612-6123', '6/07-15');


SELECT company_name, address, city
FROM orders_table 
where city = 'Chicago';

SELECT *
FROM orders_table 
WHERE company_name LIKE 'A%';


--Part 2

--Write a query that will list all of the track names and the album names 
--from the artist named ‘Jamiroquai’.

SELECT t.Name , al.Title 
FROM Artist a 
JOIN Album al
ON a.ArtistId = al.ArtistId 
JOIN Track t 
ON al.AlbumId = t.AlbumId 
WHERE a.Name = 'Jamiroquai';


--Write a query that will determine the top 5 customer countries measured 
--by total revenue (dollars) by billing country.   Include country and total revenue.

SELECT BillingCountry , sum(Total)
FROM Invoice i 
GROUP BY BillingCountry 
ORDER BY 2 DESC 
LIMIT 5;


--Write a query that determines the total invoice revenue by global region.  
--Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada 
--and the USA, ‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.

 
SELECT sum(Total) as region_total,
CASE 
	WHEN BillingCountry in ('India', 'Australia') then 'Asia Pacific'
	WHEN BillingCountry in ('Canada', 'USA') then 'North America'
	WHEN BillingCountry in ('Chile', 'Brazil', 'Argentina') then 'South America'
	ELSE 'Europe'
END as global_region
FROM Invoice i 
GROUP BY global_region
 


--Write a query that lists the artists and a count of their albums.
-- Include artists that don’t have albums.

SELECT a.Name , count(al.AlbumId) as album_count
from Artist a 
LEFT JOIN Album al
ON a.ArtistId = al.ArtistId 
GROUP BY a.Name
ORDER BY 2

--Write a query that will list the invoiceID’s that include the most genres.
-- You will want to make sure you don’t count duplicate genres, and there might be a tie for the most.
-- Include invoiceID and genre count in the output

WITH gcount AS 
(
SELECT il.InvoiceId , count(distinct g.Name) as genre_count
FROM Genre g 
JOIN Track t 
ON g.GenreId = t.GenreId 
JOIN InvoiceLine il 
ON t.TrackId = il.TrackId 
GROUP BY  il.InvoiceId 
) 
SELECT * FROM gcount 
WHERE genre_count = (SELECT MAX(genre_count) FROM gcount)

--Write a query that lists all the invoiceIDs, the invoice totals, 
--their billing country, and total amount of revenue from that country. 


SELECT InvoiceId, total, BillingCountry , 
SUM(total) OVER(PARTITION BY BillingCountry) as country_revenue
FROM invoice 


