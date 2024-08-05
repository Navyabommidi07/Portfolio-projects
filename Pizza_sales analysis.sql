select @@SERVERNAME
use [PIZZA DB]

--KPI'S--
select * from pizza_sales
--total revenue=The sum of the total price of all pizza orders total orders
select sum(quantity * unit_price)as Total_revenue 
from pizza_sales
select sum(total_price) as tr 
from pizza_sales  

--Avg order value=avg amount spend per order,
--calculated by dividing the total revenue by the total # of orders
select sum(total_price)/count(distinct(order_id)) as avg_order_value 
from pizza_sales 
 
--Total pizza sold= sum of the quantites of all pizzas sol
select sum(quantity) as total_pizza_sold from pizza_sales

--total orders=distinct_order value
select count(distinct(order_id)) as total_orders from pizza_sales

--Average pizza per order=avg # of pizzas sold per order,
--+calculated by dividing the total # of pizzas sold by the total # of orders
select cast((cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)))as decimal(10,2)) as avg_pizzas_per_order from pizza_sales

--CHART REQUIREMENT--
--Daily Trend for Total Orders
select DATENAME(dw,order_date) as order_day, count(distinct order_id) as Total_orders
from pizza_sales
group by DATENAME(dw,order_date)
--Hourly trend for total orders--peak hours
select Datepart(hour,order_time) as order_hours, count(distinct order_id) as total_orders
from pizza_sales
group by Datepart(hour,order_time)
order by total_orders desc
--Percentage of sales by pizza category
select pizza_category,sum(total_price) as total_sales,(sum(total_price)*100/(select sum(total_price) from pizza_sales where month(order_date)=1)) as PCT
from pizza_sales
where month(order_date)=1-- for month of january 7 aggregate functions cannot be done in where.
--where datepart(quarter,order_date)=1-- for quarter data
group by pizza_category-- another method please 

--percentage of sales by pizza size
select pizza_size,cast(sum(total_price) as decimal(10,2)) as total_sales,
cast((sum(total_price)*100/(select sum(total_price) from pizza_sales where datepart(quarter,order_date)=1 ))as decimal(10,2)) as PCT
from pizza_sales
where datepart(quarter,order_date)=1
group by pizza_size
order by PCT desc
-- total pizza sold by pizza category
select* from pizza_sales
select pizza_category,sum(quantity) as pizza_sold_per_quantity from pizza_sales
group by pizza_category
--top 5 bestsellers by total pizza sold
select top 5 pizza_name,sum(quantity) as pizza_sold_per_quantity from pizza_sales
group by pizza_name
order by pizza_sold_per_quantity desc
--bottom 5 sellers by total pizza sold
select  top 5 pizza_name,sum(quantity) as pizza_sold_per_quantity from pizza_sales
group by pizza_name
order by pizza_sold_per_quantity asc
