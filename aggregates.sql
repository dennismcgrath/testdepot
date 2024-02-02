-- Get all of the invoice date, city, country, and total $$
SELECT InvoiceDate, BillingCity, BillingCountry, Total
FROM invoice


-- Add an aggregate functions ... How many rows will we get ??
SELECT InvoiceDate, BillingCity, BillingCountry, SUM(Total)
FROM invoice

-- that's no good
-- we need a GROUP BY clause
-- GROUP BY acts like the "rows" in Excel pivot tables
--


-- How many invoices were there for each country
SELECT BillingCountry, COUNT(Total)
FROM invoice
GROUP BY BillingCountry

-- It doesn't matter what we count, because we're counting rows
SELECT BillingCountry, COUNT(InvoiceId)
FROM invoice
GROUP BY BillingCountry


-- What were the total sales for each country ? 
SELECT BillingCountry, SUM(Total)
FROM invoice
GROUP BY BillingCountry


-- What were the average sales for each country ? 
SELECT BillingCountry, AVG(Total)  
FROM invoice
GROUP BY BillingCountry
ORDER BY AVG(Total) DESC

-- What was the max invoice amount for each country ? 
SELECT BillingCountry, MAX(Total)
FROM invoice
GROUP BY BillingCountry

-- What was the minimum invoice amount for each country ? 
SELECT BillingCountry, MIN(Total)
FROM invoice
GROUP BY BillingCountry

--How many invoices were there for each city in Germany? 
-- add a WHERE clause
SELECT BillingCity, COUNT(Total)
FROM invoice
WHERE BillingCountry = 'Germany'
GROUP BY BillingCity

-- What were the total sales for each city in France? 
SELECT BillingCity, SUM(Total)
FROM invoice
WHERE BillingCountry = 'France'
GROUP BY BillingCity

-- What were the total sales for cities with total sales above $40
-- will this work? 
SELECT BillingCity, SUM(Total)
FROM invoice
WHERE SUM(Total) > 40
GROUP BY BillingCity


--NO! We need a HAVING clause
SELECT BillingCity, SUM(Total)
FROM invoice
GROUP BY BillingCity
HAVING SUM(Total) > 40

--We can use both WHERE and HAVING
SELECT BillingCity, SUM(Total)
FROM invoice
WHERE BillingCountry = 'USA'
GROUP BY BillingCity
HAVING SUM(Total) > 40

--We can use all of SFWGHO
SELECT BillingCity, SUM(Total)
FROM invoice
WHERE BillingCountry = 'USA'
GROUP BY BillingCity
HAVING SUM(Total) > 40
ORDER BY SUM(Total) DESC
LIMIT 2

--TOP 5 cities by total sales in the USA with total sales > 40
SELECT BillingCity, SUM(Total)
FROM invoice
WHERE BillingCountry = 'USA'
GROUP BY BillingCity
HAVING SUM(Total) > 40 
ORDER BY SUM(Total) DESC
LIMIT 5


--TOP 5 cities by total sales in the USA offset by 3
SELECT BillingCity, SUM(Total)
FROM invoice
WHERE BillingCountry = 'USA'
GROUP BY BillingCity
HAVING SUM(Total) > 40
ORDER BY SUM(Total) DESC
LIMIT 5 OFFSET 3

SELECT BillingCity, Sum(Total) 
FROM Invoice
WHERE BillingCountry = 'USA'
GROUP BY BillingCity
HAVING sum(Total) > 40
ORDER BY Sum(Total) 
LIMIT 5


/*
Which table?  Invoice: column ‘total’ 
WHERE: BillingCountry = USA 
Which columns:  BillingCity 
Having:  sum sales > 40 
Top 5 -> order by sum sales, limit = 5 
*/


