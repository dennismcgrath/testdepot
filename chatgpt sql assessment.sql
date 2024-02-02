-- Order Date in DATE format
-- Phone
-- City
-- Address
-- Company Name (include a NOT NULL constraint)
-- Primary Key called OrderID
-- Create a table called Orders, with the following information:
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CompanyName TEXT NOT NULL,
    Address TEXT,
    City TEXT,
    Phone TEXT,
    OrderDate DATE
);

-- (3, 'Netflix', '888 Broadway', 'New York', '642-612-6123', '2015-06-07')
-- (2, 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '2015-05-02'),
-- (1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '2015-01-14'),
-- insert the following data into the Orders table
 INSERT INTO Orders (OrderId, Company, Address, City, Phone, OrderDate)
VALUES (1, 'Acme', '14 Hollywood Blvd', 'Los Angeles', '616-555-1234', '2015-01-14'),
       (2, 'Amazon', '2801 S Western Ave', 'Chicago', '234-345-5151', '2015-05-02'),
       (3, 'Netflix', '888 Broadway', 'New York', '642-612-6123', '2015-06-07');

-- Create a query that will select company name, address, and city from the Orders table for companies located in Chicago
SELECT Customer.Company, Customer.Address, Customer.City
FROM Customer
WHERE Customer.City = 'Chicago';      
      
-- Create a query that will select all the records from the Orders table where the company name starts with an "A".
SELECT * FROM Orders
WHERE Company LIKE 'A%';


-- Write a query that will list all of the genre names and a count of the tracks for each genre.   Sort the list by largest track count to smallest.
SELECT Genre.Name, COUNT(Track.TrackId) AS TrackCount
FROM Genre
JOIN Track ON Genre.GenreId = Track.GenreId
GROUP BY Genre.Name
ORDER BY TrackCount DESC;


-- Write a query that will list all of the track names and the album names from the artist named ‘Jamiroquai’.
SELECT Track.Name, Album.Title
FROM Track
JOIN Album ON Track.AlbumId = Album.AlbumId
JOIN Artist ON Album.ArtistId = Artist.ArtistId
WHERE Artist.Name = 'Jamiroquai';



-- Write a query that will determine the top 5 countries measured by total revenue (dollars) sold by billing country.   Include country and total revenue.
SELECT BillingCountry, SUM(Total) AS TotalRevenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalRevenue DESC
LIMIT 5;

-- Write a query that determines the total sales (in dollars) by global region.  Create a new column for global_region, and use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada and the USA, ‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.
SELECT CASE 
    WHEN Country IN ('India', 'Australia') THEN 'Asia Pacific'
    WHEN Country IN ('Canada', 'USA') THEN 'North America'
    WHEN Country IN ('Chile', 'Brazil', 'Argentina') THEN 'South America'
    ELSE 'Europe'
END AS global_region,
SUM(UnitPrice * Quantity) AS total_sales
FROM InvoiceLine
JOIN Invoice ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
GROUP BY global_region;


-- Write a query that lists the artists that don’t have albums.
SELECT Artist.Name
FROM Artist
LEFT JOIN Album ON Artist.ArtistId = Album.ArtistId
WHERE Album.AlbumId IS NULL;

-- Write a query that lists all the invoice amounts, their billing country, and another column with the total amount of revenue from that country.  Sort largest to smallest.
SELECT Invoice.Total, Invoice.BillingCountry, SUM(Invoice.Total) AS TotalRevenue
FROM Invoice
GROUP BY Invoice.BillingCountry
ORDER BY TotalRevenue DESC;
