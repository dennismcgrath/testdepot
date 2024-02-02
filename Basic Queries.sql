SELECT Milliseconds/1000/60 AS minutes,
Milliseconds/1000 AS seconds,
Milliseconds 
FROM Track;

SELECT Composer, Name, UnitPrice FROM Track 
WHERE UnitPrice > 1.0

SELECT * FROM Invoice 
WHERE total > 10.0 AND total < 13.0
/*
Write SQL queries for the following:
Firstname, Lastname, City for Customers whose first name is Frank
Track names for songs composed by Miles Davis
Track names on the Album with AlbumID 120
The name of the music genre with GenreID 23
The Firstname and Lastname of Employees who live in Edmonton
*/

SELECT FirstName, LastName, City FROM customer
WHERE FirstName = 'Frank'
SELECT Name FROM Track WHERE Composer = 'Miles Davis'
SELECT name FROM track WHERE AlbumId = 120
SELECT Name FROM Genre WHERE GenreId = 20
SELECT FirstName, LastName FROM Employee WHERE city = 'Edmonton'
---

SELECT * FROM Employee 
WHERE city = 'Calgary' AND birthdate > '1970-01-01'


SELECT * FROM Employee 
WHERE city = 'Calgary' OR birthdate > '1970-01-01'

SELECT * FROM Employee 
WHERE NOT (city = 'Calgary' AND birthdate > '1970-01-01')

SELECT * FROM Employee 
WHERE city != 'Calgary' 

SELECT * FROM Employee 
WHERE NOT city = 'Calgary'

SELECT * FROM Employee 
WHERE city <> 'Calgary'

SELECT * FROM Employee 
WHERE birthdate BETWEEN '1962-02-18 00:00:00' AND '1968-01-09 00:00:00'

SELECT Name, Bytes FROM track 
WHERE Bytes BETWEEN 4331779 AND 8611245

SELECT * FROM Artist
WHERE Name = 'Santana' OR Name = 'Deep Purple' OR Name = 'Audioslave'

SELECT * FROM Artist
WHERE Name IN ('Santana','Deep Purple', 'Audioslave')

SELECT * FROM album
WHERE Title LIKE "Black%"

SELECT * FROM album
WHERE Title LIKE "%Black%"

SELECT * FROM album
WHERE Title LIKE "%Black";

SELECT * FROM Customer
WHERE Firstname LIKE "Robert_";

SELECT * FROM customer 
WHERE lastname LIKE '%ller';

/*
Write SQL queries for the following:
Customers (Firstname, Lastname) who live in Prague or London
Firstname, Lastname for Customers whose first name begins with M
Track names for songs with titles containing the word ‘Love’
Invoices between July 1, 2007 and July 31, 2007
The name of Tracks between 6 and 8 minutes long
*/

SELECT * FROM customer WHERE city IN ('Prague', 'London')
SELECT * FROM customer WHERE city = 'Prague' OR city = 'London'

SELECT * FROM customer WHERE firstname LIKE "M%"

SELECT * FROM track WHERE Name LIKE "%love%"

SELECT * FROM invoice 
WHERE InvoiceDate 
BETWEEN '2007-07-01 00:00:00' 
AND '2007-07-31 00:00:00'

SELECT * FROM track 
WHERE Milliseconds BETWEEN 6*60*1000 AND 8*60*1000

SELECT * FROM track 
WHERE Milliseconds/1000/60 BETWEEN 6 AND 8


