-- select count(*) as row_count
-- from Superstore;

#Q1  Revenue & Profit by Region/Which region makes the most / least money?

-- Insight: Central region shows low profitability despite strong revenue, indicating cost 
--		  or discount inefficiencies. West Region Leads

SELECT 
	Region, 
	ROUND(sum(sales),2) as Total_Revenue,
	ROUND(sum(profit),2) as Total_Profit,
	ROUND((sum(Profit) / sum(sales)) * 100,2) as Total_profit_percentage
FROM Superstore
GROUP By Region
ORDER BY Total_Revenue DESC;


## Q2 — Revenue & Profit by Category & Sub-Category?
-- Insight: Furniture Is a Volume Trap
--		  Furniture category generates high sales but suffers from negative margins, making it a 
--		  profitability risk."

SELECT 
	Category,
	"Sub-Category",
	round(sum(sales),2) as Total_Revenue,
	round(sum(profit),2) as Total_Profit,
	round((sum(profit) / sum(sales)) * 100, 2) as Total_Margin_percentage
FROM Superstore
GROUP BY Category, "Sub-Category"

ORDER BY Total_Margin_percentage;
-- ORDER BY  Category, "Sub-Category" DESC;
	

-- Key Numbers:

-- Worst sub-category: Tables (-8.56%)
-- Best margin: Labels (44.42%)
-- Best absolute profit: Copiers ($55,618)
-- Most dangerous high-revenue item: Machines (1.79% on $189K revenue)



# Q3 — Top 10 Products by Revenue
-- Insight: High revenue does not guarantee profitability, as some top-selling products generate losses."

SELECT 
	"Product Name",
	Category,
	"Sub-Category",
	round(sum(sales),2) AS Total_Revenue,
	round(sum(profit),2) AS Total_profit,
	round((sum(profit) / sum(sales) * 100), 2) AS Total_Margin_percentage,
	count(DISTINCT "Order ID" ) AS Total_Orders
FROM Superstore
GROUP BY "Product Name", Category, "Sub-Category"
ORDER BY Total_Revenue DESC
LIMIT 10;



# Q4 — Loss-Making Products
-- Insight: Certain products consistently generate negative profit, indicating pricing or cost issues."


SELECT
	"Product Name",
	Category,
	"Sub-Category",
	ROUND(SUM(sales),2) AS Total_Revenue,
	ROUND(SUM(Profit),2) AS Total_Profit,
	ROUND((SUM(Profit)/SUM(sales))*100,2) AS Total_Revenue_Per,
	COUNT(DISTINCT "Order ID") AS Total_Orders
FROM Superstore
GROUP BY "Product Name", Category, "Sub-Category"
HAVING Total_Profit<0
ORDER BY Total_Profit ASC
LIMIT 15;


#Q5 Sales by region and segment
-- Insight: Central region underperforms across all segments, confirming systemic profitability issues."


SELECT 
    Region,
    Segment,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Region, Segment
ORDER BY total_sales DESC; 


# Q6 — Sales Trend by Year & Month
-- Insight: Sales show strong seasonality with Q4 peaks, while Q1 remains consistently weak."


SELECT
	SUBSTR("Order Date",-4) AS Order_Year,
	SUBSTR("Order Date", 1, INSTR("Order Date", '/') - 1) AS order_month,
	ROUND(SUM(Sales),2) 	 AS Total_Revenue,
	ROUND(SUM(Profit),2)	 AS Total_Profit,
	COUNT(DISTINCT "Order ID") AS Total_Orders
FROM Superstore
WHERE INSTR("Order Date", '/') > 0
GROUP BY Order_Year, Order_Month
HAVING order_month IS NOT NULL AND order_month != ''
ORDER BY order_year ASC, CAST(order_month AS INTEGER) ASC;


-- Q1 (Jan-Mar) --> Weak / loss risk
-- Q2 (Apr-Jun) --> Recovery
-- Q3 (Jul-Sep) --> Strong spike in Sep
-- Q4 (Oct-Dec) --> Consistently strongest


# Q7 — Profit Margin by Region & Category
-- Insight: Profitability varies significantly by region and category, highlighting uneven performance."

SELECT 
	Region,
	Category,
	ROUND(SUM(Sales),2) AS Total_Revenue,
	ROUND(SUM(Profit),2) AS Total_Profit,
	ROUND((SUM(Profit) / SUM(Sales) * 100),2) AS Total_Margin_Per,
	COUNT(DISTINCT "Order ID") AS Total_Orders
FROM Superstore
GROUP BY Region, Category
ORDER BY Total_Margin_Per ASC;


Q8 — Shipping Mode Impact on Profit

-- Does offering faster shipping modes cost the business profitability — or do customers who pay for 
-- premium shipping actually generate better margins?"

-- Insight: Standard shipping generates high revenue but lower margins compared to premium shipping modes.

SELECT 
	"Ship Mode",
	ROUND(SUM(Sales), 2) AS Total_sales,
    ROUND(SUM(Profit), 2) AS Total_profit,
	ROUND((SUM(Profit) / SUM(Sales) * 100),2) AS Profit_Margin_Per,
	ROUND(SUM(sales) / COUNT(DISTINCT "Order ID"), 2) AS Avg_Order_Value
FROM Superstore
GROUP BY "Ship Mode"
ORDER BY Profit_Margin_Per ;


	
# Q9 — Running Total Sales by Month (Window Function)
-- Insight: Revenue growth accelerated significantly in 2017, indicating a business growth inflection point.
	
WITH monthly_sales AS (
    SELECT
        substr("Order Date", -4)                                    AS order_year,
        CAST(substr("Order Date", 1, instr("Order Date", '/') - 1) 
             AS INTEGER)                                            AS order_month,
        ROUND(SUM(Sales), 2)                                        AS total_revenue
    FROM superstore
    WHERE instr("Order Date", '/') > 0
    GROUP BY order_year, order_month
)
SELECT
    order_year,
    order_month,
    total_revenue,
    ROUND(SUM(total_revenue) OVER (
        PARTITION BY order_year
        ORDER BY order_month
    ), 2) AS running_total
FROM monthly_sales
ORDER BY order_year, order_month;



# Q10 — Customer Ranking by Revenue using CTE + RANK()?
-- Insight: High-revenue customers are not always profitable, emphasizing the need to focus on margin over volume."

WITH customer_revenue AS (
    SELECT
        "Customer Name",
        Segment,
        Region,
        ROUND(SUM(Sales), 2)  AS total_revenue,
        ROUND(SUM(Profit), 2) AS total_profit,
        ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_pct,
        COUNT(DISTINCT "Order ID") AS total_orders
    FROM superstore
    GROUP BY "Customer Name", Segment, Region
)
SELECT
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
    "Customer Name",
    Segment,
    Region,
    total_revenue,
    total_profit,
    profit_margin_pct,
    total_orders
FROM customer_revenue
ORDER BY revenue_rank
LIMIT 15;

