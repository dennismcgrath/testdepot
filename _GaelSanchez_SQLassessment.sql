Part One

CREATE TABLE ORDERS 
(OrderId Integer PRIMARY KEY,
Company Name Varchar (255),
Address varchar(255),
City varchar (255),
Phone varchar (255),
ORDERdate Date );

INSERT INTO Orders 
VALUES (1,'Acme','14 Hollywood Blvd','Los Angeles','616-555-1234','1/14/15'),
(2,'Amazon','2801 S Western Ave','Chicago','234-345-5151','5/2/15'),
(3,'Netflix','888 Broadway','New York','642-612-6123','6/7/15');

SELECT Company Name, Address, city FROM ORDERS 
WHERE city LIKE 'Chicago'

SELECT * FROM ORDERS 
WHERE Company LIKE '%A%'


 Part Two 
  
 SELECT a.name,t.name,a2.title FROM Artist a
  JOIN Album a2 
  ON a.ArtistId=a2.ArtistId 
  JOIN Track t
  ON t.AlbumId=a2.AlbumId
  WHERE a.name LIKE 'Jamiroquai'
  
  -- A bit confused on Q2 so I did two interpretations
  SELECT i.Billingcountry, Round(CAST(SUM(il.UnitPrice*il.Quantity*i.Total) AS NUMERIC),2) AS TotalRevenue
  FROM Invoice i
  JOIN Invoiceline il
  ON i.InvoiceId=il.InvoiceId
  GROUP BY i.BillingCountry
  ORDER BY TotalRevenue
  LIMIT 5
 
  SELECT c.country,SUM(il.UnitPrice*il.Quantity*i.Total) OVER (PARTITION BY I.BillingCountry) AS TotalRevenue 
  FROM Invoice i
  JOIN customer c
  ON c.CustomerId=i.CustomerId 
  JOIN Invoiceline il
  ON i.InvoiceId=il.InvoiceId
  GROUP BY c.country 
 ORDER BY TotalRevenue
 limit 5
 
 SELECT SUM(total) AS TotalRevenue,
CASE 
WHEN BillingCountry IN ('USA','Canada') THEN 'North America'
WHEN BillingCountry IN ('India','Australia') THEN 'Asia Pacific'
WHEN BillingCountry IN ('Chile','Brazil','Argentina') THEN 'South America'
ELSE 'Europe'
END  AS 'GLOBALRegion'
FROM Invoice i
GROUP BY GLOBALRegion
ORDER BY TotalRevenue

SELECT a.name,COUNT(a2.title) AS Albums FROM Artist a 
LEFT JOIN Album a2 
ON a.ArtistId=a2.ArtistId 
GROUP BY a.Name 
ORDER BY Albums


SELECT invoiceid,max(NumofG) from
(SELECT il.invoiceid, COUNT(g.name) AS NumofG  FROM InvoiceLine il 
JOIN track t
ON il.TrackId =t.TrackId 
JOIN Genre g 
ON t.GenreId=g.GenreId
GROUP BY il.InvoiceId)

SELECT il.invoiceid, COUNT(g.name) AS NumofG  FROM InvoiceLine il 
JOIN track t
ON il.TrackId =t.TrackId 
JOIN Genre g 
ON t.GenreId=g.GenreId
GROUP BY il.InvoiceId
HAVING NumofG=14

-- Though Id 5 is listed as the one with most Genre, It's actually a tie.
 
SELECT i.billingcountry,il.invoiceid,sum(i.total) AS TotalRevenue 
FROM Invoice i 
JOIN InvoiceLine il 
ON i. InvoiceId=il.InvoiceId 
GROUP BY i.BillingCountry 
