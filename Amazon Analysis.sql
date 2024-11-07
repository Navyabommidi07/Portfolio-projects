use Amazon;
Go

select * from Amazon_Sales;

/* Total Revenue */
SELECT 
Round(sum(Amount),0) as Total_Revenue
FROM Amazon_Sales;

/*Total Orders*/
SELECT 
COUNT(Order_id) as Count_of_Orders
FROM Amazon_Sales

/* Sum of Quantity*/
SELECT 
Sum(Qty) as Quantity
FROM Amazon_Sales

/* Average order value*/
SELECT 
Round(SUM(Amount)/COUNT(Order_id),1) as Avg_order_value
FROM Amazon_Sales

/* Max sales in Category*/
SELECT 
Max(Category) 
From Amazon_Sales

/* Top 5 Most ordered product*/
SELECT 
Top 5
Max(Category) as Most_popular
From Amazon_Sales
Group by Category
Order by Category desc

/* Month wise Revenue */
SELECT 
    DATENAME(MONTH, Date) AS Month,
    ROUND(SUM(CONVERT(FLOAT, Amount)), 0) AS Total_Revenue
FROM 
    Amazon_Sales
GROUP BY 
    DATENAME(MONTH, Date)
ORDER BY 
  Month desc;

/* Top Revenue by month */
SELECT 
	Top 1
	DATENAME(Month, Date) as Month,
	Round(Sum(convert(Float, Amount)), 0) AS Total_Revenue
From
	Amazon_Sales
Group By 
	DATENAME(Month,Date)
Order by Total_Revenue desc;

/* Day_wise Revenue*/
SELECT 
	Day(Date) As Days,
	Round(Sum(amount),0) As Revenue
FROM Amazon_Sales
Where date is not null
Group by Day(Date)
Order by Days Asc;
 
/*Peak Revenue Days*/
SELECT
	TOP 3 Datename(weekday,Date) As Days,
	Round(Sum(Amount),0) As Revenue
FROM Amazon_Sales
Where date is not null
Group By Datename(weekday, Date)
Order By Days desc;

/*Revenue By Category */
SELECT 
	Top 5
	Category,
	Round(Sum(Amount),0) As Revenue
FROM Amazon_Sales
Group By Category
Order By Revenue desc;

/* Percentage of Revenue by Category*/
SELECT 
      category,
      SUM(amount) AS Revenue,
      ROUND(
            100 * SUM(amount) / SUM(SUM(amount)) OVER (),2
			) AS Revenue_Percentage
FROM 
      Amazon_Sales
GROUP BY 
      category
ORDER BY 
      Revenue_Percentage DESC;

/*Revenue per Size */
SELECT 
	Size,
	Round(Sum(Amount),0) As Revenue
FROM Amazon_Sales
Group By Size
Order By Revenue desc;

/*Percentage of Revenue Per size*/
SELECT
	Size,
	Round(
	Sum(Amount)*100/Sum(sum(Amount)) over(),2
	) As Percentage_per_size
FROM Amazon_Sales
Group By Size
Order By Percentage_per_size desc;

/* Top cities by Revenue */ 
SELECT 
	Top 5 ship_city,
	Round(Sum(Amount),0) as Revenue
FROM Amazon_Sales
Group By ship_city
Order By Revenue Desc 

/*Percentage of revenue per city*/
SELECT 
	Top 15 Ship_city,
	Round(Sum(Amount),0)as Revenue,
	Round(
		Sum(Amount)*100/Sum(Sum(Amount)) over(),2
		) AS Percentage_of_revenue_per_city
FROM Amazon_Sales
Group By ship_city
ORder By Revenue desc;

/*Top states by Orders count */
SELECT
	TOP 10 
	ship_state,
	Count(Order_id) as Total_orders
FROM Amazon_Sales
Group By ship_state
Order By Total_orders desc

/* Percentage of orders contribution from states*/
SELECT 
	TOP 10 
	ship_state,
	Count(order_id) as Total_orders,
	Round(
		Count(Order_id)*100/(SELECT count(order_id) FROM Amazon_Sales),2
		) As Percentage_of_Revenue
FROM Amazon_Sales
Group By ship_state
Order By Percentage_of_Revenue desc;

/*Top state by Revenue */
SELECT
	TOP 10 
	ship_state,
	Round(Sum(Amount),0)as Revenue
FROM Amazon_Sales
Group By ship_state
Order By Revenue desc;

/*Percentage of Revenue by States*/
SELECT 
	TOP 10
	ship_state,
	Round(Sum(Amount),0) as Revenue
	Round(
		Sum(Amount)*100/Sum(Sum(Amount)



















