show tables;

desc sales;

select * from sales;

select SaleDate, Amount, Customers from sales;
select Amount, Customers, GeoID from sales;

select SaleDate, Amount, Boxes, Amount/Boxes as 'Amount per box' from sales;

select * from sales
where Amount > 10000;

select * from sales
where Amount > 10000
order by Amount desc;

select * from sales
where GeoID = 'g1'
order by PID, Amount desc;

select * from sales
where Amount > 10000 and SaleDate >= '2022-01-01';

select SaleDate, Amount from sales
where Amount > 10000 and year(SaleDate) = 2022
order by Amount desc;

select * from sales
where Boxes > 0 and Boxes <=50;

select * from sales
where Boxes between 0 and 50;

select SaleDate, Amount, Boxes, weekday(SaleDate) as "Day of week"
from sales
where weekday(SaleDate) = 4;

select * from people;

select * from people
where team = 'Delish' or team = 'Jucies';

select * from people
where team in ('Delish','Jucies');

select * from people
where Salesperson like 'B%';

select * from people
where Salesperson like '%B%';

-- Amount Category as column

select SaleDate, Amount,
		case	when Amount < 1000 then 'Under 1k'
				when Amount < 5000 then 'Under 5k'
                when Amount < 10000 then 'Under 10k'
			else '10k or more'
		end as 'Amount Category'
from sales;

-- Joins

select * from sales;

select * from people;

select s.SaleDate, s.Amount, p.Salesperson, s.SPID, p.SPID
from sales s
join people p on  p.SPID = s.SPID;

select s.SaleDate, s.Amount, pr.Product
from sales s
left join products pr on pr.PID = pr.PID;

select s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID;

select s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
where s.Amount < 500;

select s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
where s.Amount < 500
and p.Team = 'Delish';

select s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
where s.Amount < 500
and p.Team = '';

select s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team, g.Geo
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
join geo g on g.GeoID = s.GeoID
where s.Amount < 500
and p.Team = ''
and g.Geo in ('New Zealand', 'India')
;

select s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team, g.Geo
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
join geo g on g.GeoID = s.GeoID
where s.Amount < 500
and p.Team = ''
and g.Geo in ('New Zealand', 'India')
order by SaleDate
;



-- Group by gives a pivot Report

select GeoID, sum(Amount), avg(Amount), sum(Boxes)
from sales
group by geoID;

select g.Geo, sum(Amount), avg(Amount), sum(Boxes)
from sales s
join geo g on s.GeoID = g.GeoID
group by g.geo;

select pr.Category, p.Team, sum(Boxes), sum(Amount)
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
group by pr.Category, p.Team;

select pr.Category, p.Team, sum(Boxes), sum(Amount)
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
where p.Team <> ''
group by pr.Category, p.Team
order by pr.Category, p.Team;

select pr.Product, sum(s.Amount) as 'Total Amount'
from sales s
join products pr on pr.PID = s.PID
group by pr.Product
order by 'Total Amount' desc;

select pr.Product, sum(s.Amount) as 'Total Amount'
from sales s
join products pr on pr.PID = s.PID
group by pr.Product
order by 'Total Amount' desc
limit 10;

