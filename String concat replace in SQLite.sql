--use DBeaver Sample Datbase

SELECT FirstName, LastName FROM Employee e

SELECT FirstName ||' '|| LastName FROM Employee e

SELECT FirstName ||" "|| LastName FROM Employee e

--SELECT concat(FirstName, LastName) FROM Employee e
-- Doesn't work

SELECT REPLACE(composer, '&', 'and') FROM track

SELECT composer, length(composer) FROM track

-- the problem with apostrophes
SELECT * FROM artist
WHERE name = "Paul D'Ianno"

SELECT round(3.14159,2)*power(round(8.7654321,2),2) AS rounded,
3.14159*power(8.7654321,2) AS noround
