select * from blinkit_data;



UPDATE blinkit_data
SET Item_Fat_Content=
case 
when Item_Fat_Content IN ('LF','low fat') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
else Item_Fat_Content
end

select distinct(Item_Fat_Content) from blinkit_data;

select sum(Sales) as Total_Sales from blinkit_data;

select Concat(CAST(sum(Sales)/1000000 as decimal(10,2)),' M') as Total_Sales_Millions from blinkit_data;

select cast(avg(Sales) as decimal(10,1)) as Average_sales from blinkit_data;


select count(*) from blinkit_data;

select cast(avg(Rating) as decimal(10,2)) as Avg_Rating from blinkit_data;
-------------------
select Item_Fat_Content,concat(cast(Sum(Sales)/1000 as decimal(10,2)),' K') as Total_Sales_Thousands,
cast(Avg(Sales) as decimal(10,1)) as Avg_Sales,
cast(Avg(Rating) as decimal(10,2)) as Avg_Rating
from blinkit_data
group by Item_Fat_Content
order by Total_Sales_Thousands desc;

select top 5 Item_Type,
cast(Sum(Sales) as decimal(10,2))as Total_Sales,
cast(Avg(Sales) as decimal(10,1)) as Avg_Sales,
cast(Avg(Rating) as decimal(10,2)) as Avg_Rating
from blinkit_data
group by Item_Type
order by Total_Sales Desc
;
-------------------
select Outlet_Location_Type,
	ISNULL([Low Fat],0) as Low_fat,
	ISNULL([Regular],0) as Regular
from
( 
	select Outlet_Location_Type,Item_Fat_Content,
	cast(sum(Sales) as decimal(10,2)) as Total_Sales
	from blinkit_data
	group by Outlet_Location_Type,Item_Fat_Content
) as sourcetable
pivot
(	
	sum(Total_Sales)
	for Item_Fat_Content in ([Low Fat], [Regular])
) as pivottable
;
select Outlet_Location_Type,
	isnull([Low Fat],0) as Low_Fat,
	isnull([Regular],0) as Regular
from
(
	select Outlet_Location_Type,Item_Fat_Content,
	cast(avg(Sales) as decimal(10,2)) as Avg_Sales
	from blinkit_data
	group by Outlet_Location_Type,Item_Fat_Content
) as sourcetable
pivot
(
	avg(Avg_Sales)
	for Item_Fat_Content in ([Low Fat],[Regular])
) as pivottable;

select Outlet_Location_Type,
	isnull([Low Fat],0) as Low_Fat,
	isnull([Regular],0) as Regular
from
(
	select Outlet_Location_Type,Item_Fat_Content,
	count(*)as no_of_items
	from blinkit_data
	group by Outlet_Location_Type,Item_Fat_Content
) as sourcetable
pivot
(
	count(no_of_items)
	for Item_Fat_Content in ([Low Fat],[Regular])
) as pivottable;


select Outlet_Establishment_Year,
cast(Sum(Sales) as decimal(10,2))as Total_Sales,
cast(Avg(Sales) as decimal(10,1)) as Avg_Sales,
cast(Avg(Rating) as decimal(10,2)) as Avg_Rating,
count(*) as no_of_items
from blinkit_data
group by Outlet_Establishment_Year
order by Outlet_Establishment_Year Desc;