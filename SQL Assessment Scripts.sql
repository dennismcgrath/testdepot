--list all genre names and track counts; sort by largest count to smallest
select genre.name, count(track.trackid) as trackcount
from genre
join track on genre.genreid = track.genreid
group by genre.name
order by trackcount desc;

--write a query that determines the total sales (in dollars) by global region.  create a new column for global_region, and use ‘asia pacific’ for india and australia, ‘north america’ for canada and the usa, ‘south america’ for chile, brazil and argentina, and ‘europe’ for the rest.
 
select case 
    when country in ('india', 'australia') then 'asia pacific'
    when country in ('canada', 'usa') then 'north america'
    when country in ('chile', 'brazil', 'argentina') then 'south america'
    else 'europe'
end as global_region,
sum(unitprice * quantity) as total_sales
from invoiceline
join invoice on invoiceline.invoiceid = invoice.invoiceid
join customer on invoice.customerid = customer.customerid
group by global_region;

???????????

--write a query that lists the artists that don’t have albums. 
select artist.name
from artist
left join album on artist.artistid = album.artistid
where album.albumid is null;


--write a query that lists all the invoice amounts, their billing country, and another column with the total amount of revenue from that country.  sort largest to smallest.  
select invoice.total, invoice.billingcountry, sum(invoice.total) as totalrevenue
from invoice
group by invoice.billingcountry
order by totalrevenue desc;