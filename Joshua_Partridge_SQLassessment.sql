 /* 1. Create a table called Orders, with :
  * -Primary Key called Order ID
  * -Company Name
  * -Address
  * -City
  * Phone
  * Order Date in DATE format
  */
CREATE TABLE Orders (
	order_ID integer PRIMARY KEY,
	company_name varchar(255),
	address varchar(255),
	city varchar(2),
	phone varchar(2),
	order_date date
 );
 /* 2. Write SQL statements to insert :
  * order_id, company_name, address, city, Phone, order_date
  * 1, Acme, 14 Hollywood Blvd, Los Angeles, 616-555-1234, 1/14/15
  * 2, Amazon, 2801 S Western Ave, Chicago, 234-345-5151, 5/2/15
  * 3, Netflix, 888 Broadway, New York, 642-612-6123 6/7/15
  */
INSERT INTO Orders VALUES
(1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '1/14/15'),
(2, 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '5/2/15'),
(3, 'Netflix', '888 Broadway', 'New York', '642-612-6123', '6/7/15');
 /* 3. Create a query that will select company name, address, city
  * from the Orders table for companies located in Chicago
  */
SELECT company_name, address, city
FROM Orders o 
WHERE city = 'Chicago';
 /* 4. Create a query that will select all records from Orders 
  * table where the company name starts with an 'A'
  */
SELECT * FROM Orders o 
WHERE company_name LIKE 'A%';
 /* 5. Write a query that will list all of the track names and
  * album names from the artist named 'Jamiroquai'
  */
SELECT t.name, a.title
FROM track t
JOIN album a
ON t.AlbumId = a.AlbumId 
JOIN artist art
ON a.ArtistId = art.ArtistId 
WHERE art.name LIKE '%Jamiroquai%';
 /* 6. Write a query that will determine the top 5 customer 
  * countries measured by total revenue (dollars) by billing country
  * Include country and total revenue
  */
SELECT billingcountry, sum(total) AS total_revenue 
FROM customer c
JOIN invoice i
ON c.customerid = i.CustomerId 
GROUP BY billingcountry
ORDER BY total_revenue DESC
LIMIT 5;
 /* 7. Write a query that determines the total invoice revenue by
  * global region. Use 'Asia Pacific' for India and Australia
  * 'North America' for Canada and USA, 'South America' for Chile
  * Brazil and Argentina, and 'Europe' for the rest
  */
SELECT 
CASE 
	WHEN billingcountry IN ('India', 'Australia') THEN 'Asia Pacific'
	WHEN billingcountry IN ('Canada', 'USA') THEN 'North America'
	WHEN billingcountry IN ('Chile', 'Brazil', 'Argentina') THEN 'South America'
	ELSE 'Europe'
END AS global_region,
sum(total)
FROM Invoice i
GROUP BY global_region;
--(SELECT DISTINCT billingcountry FROM invoice)
/* 8. Write a query that lists the artists and a count of their
 * albums. Include artists that don't have albums
 * */ 
SELECT a.name, count(al.albumid)
FROM artist a
LEFT JOIN album al
ON al.ArtistId = a.ArtistId 
GROUP BY a.name;
/* 9. Write a query that will list the invoiceID's that include the
 * most genres. You will want to make sure that you don't count
 * duplicate genres, and there might be a tie for the most. Include
 * invoiceID and genre count in the output
 */
WITH invoice_genres AS 
(
SELECT i.invoiceid, count(g.genreid) AS genre_counts
FROM invoice i
JOIN invoiceline il
ON il.InvoiceId = i.InvoiceId 
JOIN track t
ON il.TrackId = t.TrackId 
JOIN genre g
ON t.GenreId = g.GenreId 
GROUP BY i.invoiceid
)
SELECT invoiceid, genre_counts
FROM invoice_genres
WHERE genre_counts = 
(SELECT max(genre_counts) FROM invoice_genres);
/* 10. Write a query that lists all the invoiceIDs, the invoice 
 * totals, their billing country, and total amount of revenue from 
 * that country
 */
SELECT invoiceid, total, billingcountry, 
sum(total) OVER (PARTITION BY billingcountry) AS country_total
FROM invoice;