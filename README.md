🛍️ Customer Shopping Behavior Analysis

An end-to-end data analysis project that explores how customers shop: who spends the most, which products and categories perform best, how discounts and subscriptions affect spending, and how loyal customers differ from new ones.

The project covers the full analyst workflow: data cleaning and feature engineering in Python → loading into MySQL → business queries in SQL → an interactive Power BI dashboard.

📌 Project Overview

Retail businesses collect a lot of transaction data, but the real value is in understanding customer behavior. This project analyzes a customer shopping dataset to answer questions such as:

Which gender and age groups contribute the most revenue?
Do customers who use discounts still spend above average?
Which products have the highest review ratings, and which are discounted most often?
Do subscribers spend more than non-subscribers?
How can customers be segmented into New, Returning, and Loyal?
Are repeat buyers more likely to subscribe?
🛠️ Tools & Technologies
Tool	Purpose
Python (Pandas)	Data cleaning, transformation, feature engineering
Jupyter Notebook	Analysis environment
SQLAlchemy + PyMySQL	Loading the cleaned data into MySQL
MySQL	Business analysis with SQL (aggregations, CTEs, window functions)
Power BI	Interactive dashboard and visualization
📁 Repository Structure
├── Customer_Shopping_behavior_Analysis.ipynb   # Data cleaning & feature engineering (Python)
├── shopping_behavior.sql                       # SQL queries for business analysis (MySQL)
├── customer_shopping_behavior.pbix             # Power BI dashboard
└── README.md

The raw dataset (customer_shopping_behavior.csv) is read by the notebook. Add it to the repo (or link to its source) so others can reproduce the work.

🧹 1. Data Cleaning & Feature Engineering (Python)

Done in Customer_Shopping_behavior_Analysis.ipynb:

Loaded the dataset with Pandas and inspected it with info(), describe(), and null checks
Handled missing values in Review Rating by imputing the median within each product Category
Standardized column names (lowercase, underscores, e.g. purchase_amount_(usd) → purchase_amount)
Created age_group by splitting customers into four quartile-based groups: Young Adult, Adult, Middle-Aged, Senior
Created purchase_frequency_days by converting text frequencies (Weekly, Fortnightly, Monthly, Quarterly, Annually, etc.) into numeric day values
Checked that discount_applied and promo_code_used were identical, then dropped the redundant promo_code_used column
Loaded the cleaned data into a MySQL table (customer) in the shopping_behavior database
🗄️ 2. SQL Analysis (MySQL)

All queries are in shopping_behavior.sql:

#	Business Question	SQL Concepts Used
1	Revenue by gender	GROUP BY, SUM
2	Discount users who still spent above the average purchase	Subquery, WHERE
3	Top 5 products by average review rating	AVG, ROUND, ORDER BY, LIMIT
4	Average purchase by shipping type (Standard vs Express)	AVG, IN
5	Subscribers vs non-subscribers: customers, average spend, total revenue	COUNT, AVG, SUM
6	Top 5 products by discount percentage	CASE WHEN, conditional aggregation
7	Customer segmentation: New / Returning / Loyal	CTE, CASE WHEN
8	Top 3 most purchased products per category	CTE, ROW_NUMBER() window function
9	Are repeat buyers (more than 5 purchases) more likely to subscribe?	CASE WHEN, conditional aggregation
10	Revenue contribution by age group	Subquery, percent-of-total calculation

Segmentation logic

New: 1 or fewer previous purchases
Returning: 2–10 previous purchases
Loyal: more than 10 previous purchases
📊 3. Power BI Dashboard

The dashboard in customer_shopping_behavior.pbix gives an interactive, single-page view of the data.

KPI cards

Number of customers
Average purchase amount
Average review rating

Visuals

Sales by category (column chart)
Revenue by age group (bar chart)
Customers by subscription status (donut chart)

Interactive filters (slicers)

Gender
Category
Subscription status
Shipping type

To open it, download the .pbix file and open it in Power BI Desktop.

🚀 How to Run
Clone the repo
bash
   git clone <your-repo-url>
   cd <your-repo-name>
Install dependencies
bash
   pip install pandas sqlalchemy pymysql jupyter
Run the notebook to clean the data and load it into MySQL. Set your own MySQL credentials first (see the note below).
Run shopping_behavior.sql in MySQL Workbench or any MySQL client.
Open the .pbix file in Power BI Desktop to explore the dashboard.

🔐 Never commit database passwords. Keep credentials in environment variables or a .env file and add it to .gitignore.

💡 Skills Demonstrated
Data cleaning and handling missing values with Pandas
Feature engineering (binning, mapping, dropping redundant columns)
Connecting Python to a MySQL database
Writing analytical SQL: subqueries, CTEs, window functions, conditional aggregation
Customer segmentation and revenue contribution analysis
Building an interactive Power BI dashboard with KPIs and slicers
🔮 Possible Next Steps
Add RFM (Recency, Frequency, Monetary) segmentation
Build a churn or customer-spend prediction model
Add a seasonal or time-based trend analysis
Publish the dashboard to Power BI Service and add a screenshot or GIF here
