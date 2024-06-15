# Budgeting-analysis
Budgeting analysis with overall profit and loss
Project Overview
This project is an end-to-end retail analysis focused on customer transactions, product stock, and generating meaningful insights to understand customer engagement. The analysis considers various factors such as product type, price, store type, and seasonality.

Objectives
Customer Analysis: Understand customer behavior and preferences.
Transaction Analysis: Identify trends and patterns in transaction data.
Product Stock Analysis: Evaluate stock levels and identify popular products.
Insights Generation: Provide actionable insights based on product, price, store type, and season
**No data has provided as sensitive** 
_**Data Schema**_
**_FACT_TABLE_**
Date: DATE
ProductID: INT PRIMARY KEY IDENTITY (1,1)
Profit: INT
Sales: INT
Margin: INT
COGS: INT (Cost of Goods Sold)
Total_Expenses: INT
Marketing: INT
Inventory: INT
Budget_Profit: INT
Budget_COGS: INT
Budget_Margin: INT
Budget_Sales: INT
Area_Code: INT
**ProductTable**
Product_Type: VARCHAR(20)
Product: VARCHAR(20)
ProductID: INT REFERENCES FACT_TABLE(ProductID)
Type: VARCHAR(10)
**LocationTable**
Area_Code: INT
State: VARCHAR(10)
Market: VARCHAR(10)
Market_Size: INT
