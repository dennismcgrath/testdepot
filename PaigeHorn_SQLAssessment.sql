/*Part 1 - Table creation and basic queries
Create a table called Orders, with the following information:

Primary Key called OrderID
Company Name 
Address
City
Phone
Order Date in DATE format*/

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
company_name VARCHAR(255)NOT NULL,
address VARCHAR(255),
city VARCHAR(255),
phone VARCHAR(255),
order_date DATE
);

INSERT INTO Orders VALUES
(1,'Acme','14 Hollywood Blvd','Los Angeles','616-555-1234','2015-01-14'),
(2,'Amazon','2801 S Western Ave','Chicago','234-345-5151','2015-05-02'),
(3,'Netflix','888 Broadway','New York','642-612-6123','2015-06-07');


--Create a query that will select company name, address, and city from the Orders table for companies located in Chicago.
SELECT company_name , address , city 
FROM Orders o 
WHERE city = 'Chicago';

--Create a query that will select all the records from the Orders table where the company name starts with an "A".

SELECT *
FROM Orders o 
WHERE company_name LIKE 'A%';

--PART 2: 
--Write a query that will list all of the genre names and a count of the tracks for each genre. 
--Sort the list by largest track count to smallest.
SELECT g.name, count(t.TrackId) AS total_tracks
FROM Genre g 
JOIN Track t ON g.GenreId = t.GenreId 
GROUP BY g.Name 
ORDER BY total_tracks DESC;

--Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.
SELECT t.name AS track_name, a.title AS album_title, ar.name AS artist
FROM Track t 
JOIN album a ON t.AlbumId = a.AlbumId 
JOIN artist ar ON a.ArtistId = ar.ArtistId 
WHERE ar.name = 'Jamiroquai';

--Write a query that will determine the top 5 countries measured by total revenue (dollars) by billing country.
--Include country and total revenue.
SELECT BillingCountry , sum(total) AS revenue
FROM Invoice i 
GROUP BY BillingCountry 
ORDER BY sum(total) DESC
LIMIT 5;

--Write a query that determines the total invoice revenue by global region.  Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA,
--‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.
SELECT sum(total) AS revenue, 
CASE 
	WHEN billingcountry IN ('India','Australia') THEN 'Asia Pacific'
	WHEN Billingcountry IN ('USA','Canada') THEN 'North America'
	WHEN billingcountry IN ('Chile','Brazil','Argentina') THEN 'South America'
	ELSE 'Europe'
END AS global_region
FROM Invoice i 
GROUP BY global_region;

--Write a query that lists the artists and a count of their albums. Include artists that don’t have albums.
SELECT a.name AS artist, count(a2.AlbumId) AS total_albums
FROM Artist a 
LEFT JOIN Album a2 ON a.ArtistId = a2.ArtistId 
GROUP BY a.Name 
ORDER BY total_albums ASC;

--Write a query that will list the invoiceID’s that include the most genres. You will want to make sure you don’t count duplicate genres, 
--and there might be a tie for the most. Include invoiceID and genre count in the output
WITH genre_count AS 
(
	SELECT il.InvoiceId , count (DISTINCT t.GenreId) AS total_genres
	FROM InvoiceLine il 
	JOIN Track t ON il.TrackId = t.TrackId 
	JOIN Genre g ON g.GenreId = t.GenreId 
	GROUP BY il.InvoiceId 
	ORDER BY total_genres DESC
)
SELECT *
FROM genre_count
WHERE total_genres = (SELECT max(total_genres) FROM genre_count)

--Write a query that lists all the invoiceIDs, the invoice totals, their billing country, and total amount of revenue from that country. 

SELECT InvoiceId , total, BillingCountry ,
sum(total) OVER (PARTITION BY BillingCountry) AS country_total
FROM Invoice i 
ORDER BY total DESC;