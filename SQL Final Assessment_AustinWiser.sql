--Part 1

CREATE table Orders
	(order_id int primary key,
	company_name varchar(255),
	address varchar(255),
	city varchar(255),
	Phone int,
	order_date date);
	
INSERT INTO Orders (order_id, company_name, address, city, phone, order_date)
Values ('1', 'Acme','14 Hollywood Blvd', 'Los Angeles', '616-555-1234','1/14/15');

INSERT INTO Orders (order_id, company_name, address, city, phone, order_date)
Values ('2', 'Amazon', '2801 S Western Ave', 'Chicago', '243-345-5151', '5/02/15');
	
INSERT INTO Orders (order_id, company_name, address, city, phone, order_date)
Values ('3', 'Netflix', '888 Broadway', 'New York', '642-612-6123', '6/07-15');


SELECT company_name, address, city
from Orders 
where city = 'Chicago';

SELECT *
from Orders 
where company_name like 'A%';


--Part 2

--Write a query that will list all of the track names and the album names 
--from the artist named ‘Jamiroquai’.

select t.Name , al.Title 
from Artist a 
join Album al
on a.ArtistId = al.ArtistId 
join Track t 
on al.AlbumId = t.AlbumId 
where a.Name = 'Jamiroquai';


--Write a query that will determine the top 5 customer countries measured 
--by total revenue (dollars) by billing country.   Include country and total revenue.

SELECT BillingCountry , sum(Total)
from Invoice i 
group by BillingCountry 
order by sum(Total) DESC 
limit 5;


--Write a query that determines the total invoice revenue by global region.  
--Use ‘Asia Pacific’ for India and Australia, ‘North America’ for Canada 
--and the USA, ‘South America’ for Chile, Brazil and Argentina, and ‘Europe’ for the rest.

with regions as 
(
SELECT sum(Total) as region_total,
CASE 
	when BillingCountry in ('India', 'Australia') then 'Asia Pacific'
	when BillingCountry in ('Canada', 'USA') then 'North America'
	when BillingCountry in ('Chile', 'Brazil', 'Argentina') then 'South America'
	else 'Europe'
END as global_region
from Invoice i 
group by BillingCountry
)
SELECT global_region, sum(region_total) as sum_region_total
from regions
group by global_region;


--Write a query that lists the artists and a count of their albums.
-- Include artists that don’t have albums.

SELECT a.Name , count(al.AlbumId) as album_count
from Artist a 
left join Album al
on a.ArtistId = al.ArtistId 
group by a.Name;


--Write a query that will list the invoiceID’s that include the most genres.
-- You will want to make sure you don’t count duplicate genres, and there might be a tie for the most.
-- Include invoiceID and genre count in the output

SELECT il.InvoiceId , count(distinct g.Name) as genre_count
from Genre g 
join Track t 
on g.GenreId = t.GenreId 
join InvoiceLine il 
on t.TrackId = il.TrackId 
group by il.InvoiceId 
order by count(DISTINCT g.Name) DESC 
limit 5;

--Write a query that lists all the invoiceIDs, the invoice totals, 
--their billing country, and total amount of revenue from that country. 

with country_total as 
(
SELECT InvoiceId , BillingCountry , sum(i.Total) as invoice_total
from Invoice i 
group by i.InvoiceId , i.BillingCountry 
)
SELECT InvoiceId , BillingCountry , invoice_total, 
sum(invoice_total) over(partition by BillingCountry) as total_revenue
from country_total
order by BillingCountry ;


