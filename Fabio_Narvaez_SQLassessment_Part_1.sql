-- Part 1 - Table creation and basic queries

-- Create a table called Orders, with the following information:
-- Primary Key called OrderID
-- Company Name 
-- Address
-- City
-- Phone
-- Order Date in DATE format

CREATE TABLE Orders (
	OrderID 	int,
	Company_Name 	varchar (255),
	address	varchar (255),
	City 		varchar(255),
	phone varchar (255),
	order_date date
)

-- Write SQL statements to insert the following into your table:

INSERT INTO orders (orderid, company_name, address, city, phone, order_date)
VALUES  (1,'Acme', '14 Hollywood Blvd', 'Los Angeles','616-555-1234','01/14/15'),
		(2,'Amazon', '2801 S Western Ave', 'Chicago','234-345-5151','05/02/15'),
		(3,'Netflix', '888 Broadway', 'New York','642-612-6123','06/07/15')
		
-- Create a query that will select company name, address, and city from the Orders table for companies located in Chicago.

SELECT Company_Name , address ,City  FROM Orders o 
WHERE City  = 'Chicago'
		
-- Create a query that will select all the records from the Orders table where the company name starts with an "A".

SELECT * FROM Orders o 
WHERE Company_Name LIKE 'A%'
