## Displaying tables in the dataset
select * from sales;

select SaleDate, Amount, Customers from sales;

select Amount, Customers, GeoID from sales;

Select * from geo;

Select * from people;
 
## Calculating Amount per box
Select SaleDate, Amount, Boxes, round(Amount/Boxes,2) as Amount_Per_Box from Sales;

## Filtering data by Amount
Select * from sales where Amount > 10000 order by Amount desc;

## Filtering Data with GeoID and PID 
Select * from sales where GeoID="G1"
order by PID, Amount desc;

## Filtering data with specific Amount and SaleDate
Select * from sales
where Amount > 10000 and SaleDate >='2022-01-01';

## Using year() function to select all data in a specific year
select SaleDate, Amount from sales
where amount > 10000 and year(SaleDate) = 2022
order by amount desc;

## Applying the operators
select * from sales where boxes > 0 and boxes <=50; 

select * from sales where boxes between 0 and 50;

## Applying the weekday() function
Select SaleDate, Amount, Boxes, weekday(SaleDate) as 'Day of week' from sales
where weekday(SaleDate) = 4;

## Filtering the Salesperson by Team
select * from people where Team = 'Delish' or Team = 'Jucies';

select * from people where team in ('Delish', 'Jucies');

Select * from people where Salesperson like '%J%';

## Using Case syntax
select SaleDate, Amount,
case when amount < 1000 then 'Under 1k'
when amount < 5000 then 'Under 5k'
when amount < 10000 then 'Under 10k'
else '10k or more' end as Amount_as_Category
from sales;

## Using JOINS
Select s.saledate, s.Amount, p.Salesperson, p.SPID from sales s join people p on p.SPID=s.SPID;

Select s.saledate,s.amount, pr.product,pr.PID from sales s join products pr on pr.PID=s.PID;

Select s.saleDate,s.amount,pr.product,p.salesperson, p.team,g.geo from sales s join people p on p.SPID=s.SPID
join products pr on pr.PID=s.PID 
join geo g on g.geoid=s.geoid 
where s.amount < 500 and p.team = '' and g.geo in ('New zealand','India');

## Using Multiple JOINS with conditions
select pr.PID, year(s.SaleDate), s.SPID, pr.Product, s.Amount, p.team
from sales as s inner join people as p
using(SPID) left join products as pr using(PID);

select pr.PID, year(s.SaleDate), s.SPID, pr.Product, s.Amount, p.team
from sales as s inner join people as p
using(SPID) left join products as pr
using(PID) where s.amount < 500 and (p.team = 'Delish');

select pr.PID, year(s.SaleDate), s.SPID, pr.Product, s.Amount, p.team, g.geo
from sales as s inner join people as p using(SPID) left join products as pr
using(PID) left join geo as g using(geoid) where s.amount < 500
and (p.team = 'Delish') and g.geo in ('India', 'New Zealand') order by s.saleDate;

## Calculating Sum and Avg
Select g.geo, sum(amount), avg(amount) from sales s join geo g on g.GeoID=s.GeoID group by Geo;

## Calculating Total amount of each product
Select pr.product, sum(s.amount) as 'Total amount' from sales s 
join products pr on pr.PID=s.PID group by pr.product order by 'Total amount' desc limit 10;
