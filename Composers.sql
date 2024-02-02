--What are the Composers whose $0.99 tracks have an average track length greater than 5 minutes?
-- what tables: Track
-- what columns? milliseconds, unit_price, Compower
-- what WHERE unitprice = 0.99
-- what GROUP BY  Composer
-- what HAVING average track length > 5min   (min=milliseconds/1000/60)
-- what Order Average(milliseconds/1000/60)

SELECT Composer, round(avg(milliseconds/1000/60),2) AS average_length 
FROM Track
WHERE UnitPrice  = 0.99
GROUP BY Composer
HAVING average_length > 5
ORDER BY average_length DESC