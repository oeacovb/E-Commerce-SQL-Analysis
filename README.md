# E-Commerce Sales & Customer Analysis Using SQL

## 📌 Project Overview

This project focuses on analyzing an e-commerce business using SQL to extract meaningful business insights from customer, order, product, seller, payment, and review data.

The analysis uses the Brazilian E-Commerce dataset and answers a series of business questions related to revenue, customers, orders, payment methods, product categories, sellers, geographical performance, and delivery time.

The main objective of this project is to demonstrate how SQL can be used to transform raw transactional data into useful information for business analysis and decision-making.

---

## 🎯 Project Objectives

The project aims to:

* Analyze overall e-commerce revenue and order performance
* Understand customer purchasing behavior
* Identify top-spending customers
* Analyze repeat customers
* Identify popular payment methods
* Analyze monthly order trends
* Identify high-performing product categories
* Compare revenue across customer states
* Analyze seller performance
* Identify top product categories within each state
* Identify customers spending above the average
* Analyze month-over-month revenue
* Compare seller delivery performance

---

## 🗃️ Database Schema

The project uses the following tables:

### 1. Customers

Contains customer information such as:

* Customer ID
* Customer Unique ID
* Customer City
* Customer State

### 2. Sellers

Contains seller information:

* Seller ID
* Seller City
* Seller State

### 3. Products

Contains product information:

* Product ID
* Product Category

### 4. Category Translation

Contains Portuguese-to-English product category translations.

### 5. Orders

Contains order-level information:

* Order ID
* Customer ID
* Order Status
* Purchase Date
* Delivery Date
* Estimated Delivery Date

### 6. Order Items

Contains information about products purchased in each order:

* Order ID
* Product ID
* Seller ID
* Price
* Freight Value

### 7. Payments

Contains:

* Order ID
* Payment Type
* Payment Installments
* Payment Value

### 8. Reviews

Contains:

* Review ID
* Order ID
* Review Score
* Review Creation Date

---

## 🔎 Business Questions

The project answers the following questions:

1. What is the total revenue generated?
2. What is the average order value?
3. How many total orders were placed?
4. How many unique customers exist?
5. Which payment method is most used?
6. What are the monthly sales trends?
7. Which month generated the highest revenue?
8. What are the top 10 selling product categories?
9. Who are the top-spending customers?
10. How many repeat customers are there?
11. Which states generate the highest revenue?
12. Which sellers generated the highest revenue?
13. Which 3 product categories generated the highest revenue in every customer state?
14. Which customers have spending above the average customer spending?
15. What is the month-over-month revenue growth?
16. What is the average delivery time for each seller?

---

## 🛠️ SQL Concepts Used

This project demonstrates several important SQL concepts:

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `LIMIT`
* `DISTINCT`
* Aggregate functions

  * `SUM()`
  * `AVG()`
  * `COUNT()`
* `JOIN`
* `USING`
* Subqueries
* Common Table Expressions (`CTE`)
* `CASE`
* Window Functions
* `RANK()`
* `LAG()`
* Date functions

  * `MONTH()`
  * `DATE_FORMAT()`
  * `DATEDIFF()`
* Filtering aggregated data using `HAVING`

---

## 📊 Key Analysis Areas

### Revenue Analysis

Revenue was calculated using product price and freight value. This provides an overall view of the financial performance of the e-commerce business.

### Customer Analysis

Customer-level analysis was performed to identify:

* Top-spending customers
* Repeat customers
* Customers spending above the average

This helps understand customer purchasing behavior and customer value.

### Product Analysis

Product categories were analyzed based on:

* Number of sales
* Total revenue
* Performance across different customer states

A window function with `RANK()` was used to identify the top three categories within each state.

### Seller Analysis

Seller performance was analyzed using:

* Number of orders
* Number of products sold
* Total revenue
* Average delivery time

This helps compare seller contribution and operational performance.

### Payment Analysis

Payment methods were compared based on their usage frequency to understand customer payment preferences.

### Time-Based Analysis

Monthly order and revenue trends were analyzed to understand changes in e-commerce activity over time.

The `LAG()` window function was used for month-over-month revenue analysis.

### Geographical Analysis

Customer states were analyzed to identify regions generating higher revenue and to understand product-category performance across different states.

---

## 💡 Business Insights

The analysis provides a framework for understanding:

* Overall revenue performance
* Customer purchasing patterns
* Repeat customer behavior
* Product-category performance
* Seller contribution to revenue
* Regional revenue distribution
* Payment preferences
* Monthly sales patterns
* Seller delivery performance

These insights can help an e-commerce business understand where its revenue comes from and identify areas that may require further investigation.

---

## 📚 What I Learned

Through this project, I learned how to convert real-world business questions into SQL queries.

The project helped me strengthen my understanding of:

* Working with multiple related tables
* Joining tables using primary and foreign keys
* Performing aggregation and grouping
* Writing subqueries and CTEs
* Using window functions for advanced analysis
* Performing ranking within groups
* Comparing current and previous periods
* Working with dates
* Extracting business insights from transactional data

The most important learning was understanding that SQL is not only about retrieving data, but also about using data to answer meaningful business questions.

---

## 🏁 Conclusion

This project demonstrates how SQL can be used to analyze an e-commerce business from multiple perspectives, including customers, products, sellers, payments, revenue, geography, and delivery performance.

By combining basic SQL queries with advanced techniques such as CTEs, subqueries, window functions, ranking, and date-based analysis, the project transforms raw transactional data into structured business insights.

Overall, the project strengthened my practical SQL and data-analysis skills and provided experience in approaching real-world business problems using data.

---

## 👨‍💻 Tools & Technologies

* **SQL**
* **MySQL**
* **GitHub**
* **Brazilian E-Commerce Dataset (Olist)**

---

## 📂 Project Files

```text
E-Commerce-SQL-Analysis/
│
├── README.md
├── ecommerce_analysis.sql
└── screenshots/
```

---

## 🚀 Future Improvements

Possible future improvements include:

* Adding a Power BI dashboard
* Adding customer segmentation
* Performing customer lifetime value analysis
* Analyzing review scores and customer satisfaction
* Adding delivery-delay analysis
* Performing cohort analysis
* Creating more advanced revenue and retention metrics
