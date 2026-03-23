# 🛒 Retail Sales Performance Analysis



This project analyzes sales data using SQL and Power BI to identify key business insights such as top-performing products, loss-making products, and regional performance.





**Tools:** SQL (SQLite) · Power BI · Python (Pandas, Matplotlib)  
**Dataset:** Superstore Sales Dataset — 9,994 rows of US retail transaction data  
**Source:** [Kaggle — Superstore Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)



## 📌 Business Question

> "Which products, regions, and time periods are driving revenue — and where is the business losing money?"



## 📁 Project Structure



retail-sales-analysis/
│
├── README.md
│
├── SQL/
│   ├── 01\_regional\_revenue\_profit.sql
│   ├── 02\_category\_subcategory\_margin.sql
│   ├── 03\_top10\_products\_by\_revenue.sql
│   ├── 04\_loss\_making\_products.sql
│   ├── 05\_sales\_by\_region\_segment.sql
│   ├── 06\_sales\_trend\_by\_year\_month.sql
│   ├── 07\_profit\_margin\_by\_region\_category.sql
│   ├── 08\_shipping\_mode\_impact.sql
│   ├── 09\_running\_total\_sales\_window.sql
│   └── 10\_customer\_ranking\_cte\_rank.sql
│
├── PowerBI/
│   ├── Retail\_Sales\_Dashboard.pbix
│   └── screenshots/
│       ├── page1\_executive\_overview.png
│       ├── page2\_product\_analysis.png
│       └── page3\_regional\_performance.png
│
├── Python/
│   ├── retail\_sales\_analysis.py
│   └── charts/
│       ├── sales\_by\_region.png
│       ├── profit\_by\_category.png
│       └── monthly\_sales\_trend.png
│
└── data/
└── superstore\_sales.csv



## 

## 🔍 Key Business Insights



### 1\. 📍 Regional Performance Imbalance

The West region leads in both revenue and profitability, while the Central region generates strong sales but suffers from low margins, indicating cost inefficiencies or aggressive discounting strategies.

### 2\. 🪑 Furniture Is a Profitability Risk

Despite generating high sales volume, the Furniture category delivers consistently low or negative margins. Sub-categories like Tables are loss-making, suggesting structural pricing or cost issues.

### 3\. 📉 Loss-Making Products Impact Profitability

Several products generate consistent losses, with some showing extreme negative margins. This highlights the need for pricing optimisation and cost control.

### 4\. 📅 Strong Seasonality in Sales

Sales peak consistently in Q4 across all years, while Q1 remains the weakest period. This pattern can inform inventory planning and promotional strategies.

### 5\. 🧑‍💼 Customer Profitability vs Revenue

Some of the highest revenue-generating customers are unprofitable, while others with lower revenue deliver strong margins. This suggests the business should prioritise profitable customers over high-volume ones.

### 6\. 🚚 Shipping Strategy Insight

Standard Class shipping contributes the majority of revenue but delivers lower margins compared to premium shipping options, indicating potential discount-driven sales.

### 7\. 📈 Business Growth Acceleration

Running total analysis shows accelerated growth in 2017, suggesting a ley expansion phase or strategic shift in the business.

## 

## 🗄️ SQL Analysis

Ten queries were written in **SQLite via DB Browser** to investigate the business question systematically, progressing from basic aggregations through to window functions and CTEs.



|Query|Question|
|-|-|
|Q1|Which region generates the most / least revenue and profit?|
|Q2|Which categories and sub-categories have the worst profit margins?|
|Q3|What are the top 10 products by revenue?|
|Q4|Which products are loss-making?|
|Q5|How do sales and profit break down by region and customer segment?|
|Q6|What is the monthly and yearly sales trend?|
|Q7|What is the profit margin broken down by region and category?|
|Q8|Does shipping mode impact profitability?|
|Q9|What is the running total of sales by month? (Window Function)|
|Q10|Which customers generate the most revenue — and are they profitable? (CTE + RANK)|



**Sample Query — Customer Ranking by Revenue (CTE + Window Function):**

sql
WITH customer\_revenue AS (
SELECT
"Customer Name",
Segment,
Region,
ROUND(SUM(Sales), 2)  AS total\_revenue,
ROUND(SUM(Profit), 2) AS total\_profit,
ROUND((SUM(Profit) / SUM(Sales)) \* 100, 2) AS profit\_margin\_pct,
COUNT(DISTINCT "Order ID") AS total\_orders
FROM superstore
GROUP BY "Customer Name", Segment, Region
)



SELECT
RANK() OVER (ORDER BY total\_revenue DESC) AS revenue\_rank,
"Customer Name",
Segment,
Region,
total\_revenue,
total\_profit,
profit\_margin\_pct,
total\_orders
FROM customer\_revenue
ORDER BY revenue\_rank
LIMIT 15;

```

\\\\---



## 📊 Power BI Dashboard
===


A 3-page interactive dashboard was built in \\\*\\\*Power BI Desktop\\\*\\\*.


### Page 1 — Executive Overview

\\\* KPI Cards: Total Sales ($2.30M), Total Profit ($286K), Total Orders (5,009), Profit Margin % (12.47%)
\\\* Monthly Sales Trend line chart (2014–2017 year comparison)
\\\* Sales vs Profit by Category clustered bar chart
\\\* Year and Region slicers


### Page 2 — Product \\\\\\\& Category Analysis

\\\* Sales \\\\\\\& Profit by Sub-Category clustered bar chart
\\\* Top 10 Revenue-Generating Products
\\\* Products with Negative Profit table (with conditional red formatting)

### Page 3 — Regional Performance

\\\* Sales \\\\\\\& Profit by Region clustered bar chart
\\\* \\\*\\\*Profit by State filled map\\\*\\\* (red = loss, green = profitable)
\\\* Total Sales by Region donut chart
\\\* Region × Category profit matrix

KEY INSIGHTS:

\- Technology category generates the highest profit.

\- Furniture shows lower profit margins despite strong sales.

\- West region performs best in both sales and profitability.

\- Several products consistently generate negative profit, indicating pricing inefficiencies.




## 🐍 Python Analysis

Static visualisations were produced using \\\*\\\*Pandas and Matplotlib\\\*\\\* for reproducibility and GitHub presentation.

Charts produced:

\\\* Sales by Region (bar chart)
\\\* Profit by Category (bar chart)
\\\* Monthly Sales Trend (line chart)




## 🛠️ Tools \\\\\\\& Technologies

|Tool|Purpose|
|-|-|
|SQLite / DB Browser|Data investigation and querying|
|Power BI Desktop|Interactive dashboard and storytelling|
|Python (Pandas, Matplotlib)|Static visualisations for GitHub|
|GitHub|Portfolio hosting and version control|





## Business Recommendation:

#### 

#### \- Reduce discounts in Furniture category

#### \- Re-evaluate pricing for loss-making products

\- Focus on high-margin segments like Technology


## 👤 About

\\\*\\\*Nazeer Pinjari\\\*\\\* — Data Analyst  
MSc Data Science, Coventry University  
Background in QA \\\\\\\& Data Validation and Data \\\\\\\& Analytics Engineering

\\\[LinkedIn](#) · \\\[GitHub](#)

===

---

