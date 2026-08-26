# Credit Card Customer Analytics

### SQL + Power BI Data Analytics Project

## 📌 Project Overview

This project analyzes customer demographics and credit card behavior to identify patterns in customer value, transaction activity, credit utilization, delinquency, acquisition cost, and financial performance.

The project combines two datasets — customer information and credit card information — using `Client_Num` as the common customer identifier.

The analysis was performed using **SQL Server** and **Power BI** to transform raw data into business-focused insights and an interactive dashboard.

---

## 🎯 Business Objectives

The main objectives of this analysis are:

- Understand customer demographics and segmentation
- Analyze credit card transaction behavior
- Compare performance across card categories
- Identify high-value customers
- Analyze credit utilization and delinquency
- Evaluate customer acquisition cost
- Analyze customer value and profitability
- Identify weekly and quarterly transaction trends
- Build an interactive Power BI dashboard

---

## 🗂️ Dataset

The project contains two datasets:

### Customer Dataset

The customer dataset contains information such as:

- Customer age
- Gender
- Income
- Education level
- Marital status
- Customer job
- Dependents
- Customer satisfaction score

### Credit Card Dataset

The credit card dataset contains information such as:

- Card category
- Credit limit
- Transaction amount
- Transaction volume
- Total revolving balance
- Credit utilization ratio
- Interest earned
- Annual fees
- Customer acquisition cost
- Delinquency
- Weekly and quarterly transaction information

### Relationship

The two datasets are connected using:

`Client_Num`

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| SQL Server | Data storage and analysis |
| SQL | Data querying and business analysis |
| Power BI | Interactive dashboard |
| DAX | KPI and measure creation |
| GitHub | Project documentation and version control |

---

## 🔎 SQL Analysis

The SQL analysis was organized into several business-focused areas.

### 1. Data Understanding

- Total customer count
- Duplicate customer identification
- Basic data exploration

### 2. Customer Analysis

- Customer distribution by education
- Customer distribution by occupation
- Average income by occupation
- Customer age segmentation
- Customer demographic analysis

### 3. Credit Card Analysis

- Transaction amount by card category
- Transaction volume by card category
- Interest earned by card category
- Credit card performance comparison

### 4. Customer Value Analysis

- Identification of high-spending customers
- Identification of high-income and high-spending customers
- Customer value by occupation
- Net customer value analysis

### 5. Risk Analysis

- Overall delinquency rate
- Delinquency by card category
- Delinquency by occupation
- High credit-utilization and delinquent customers

### 6. Acquisition & Profitability

- Customer acquisition cost by card category
- Customer value
- Net customer value

### 7. Time Analysis

- Quarterly transaction analysis
- Weekly transaction trends

### 8. Advanced SQL

The project also demonstrates:

- JOINs
- CASE statements
- Subqueries
- CTEs
- Aggregate functions
- Window functions
- RANK()
- PARTITION BY
- Moving averages

---

## 📊 Power BI Dashboard

An interactive Power BI dashboard was developed to visualize customer and credit card performance.

### Dashboard Preview

![Dashboard Overview](Images/dashboard_overview.png)

### Customer Analysis

![Customer Analysis](Images/customer_analysis.png)

### Financial Analysis

![Financial Analysis](Images/financial_analysis.png)

### Risk Analysis

![Risk Analysis](Images/risk_analysis.png)

---

## 💡 Key Insights

The analysis focuses on identifying:

- Customer segments contributing the highest transaction value
- Card categories with stronger transaction performance
- Customer segments generating higher financial value
- Segments with higher credit utilization
- Patterns in delinquency across customer groups
- Differences between customer acquisition cost and customer-generated value
- Weekly and quarterly transaction trends

> **Note:** The specific numerical findings and business recommendations are based on the results generated from the SQL analysis and Power BI dashboard.

---

## 📁 Project Structure

```text
Credit_card_analysis/
│
├── Dataset/
│   ├── credit_card.csv
│   └── customer.csv
│
├── SQL/
│   ├── 01_create_tables.sql
│   ├── 02_data_preview.sql
│   └── 03_credit_card_analysis.sql
│
├── PowerBI/
│   └── Credit_Card_Analysis.pbix
│
├── Images/
│   ├── dashboard_overview.png
│   ├── customer_analysis.png
│   ├── financial_analysis.png
│   └── risk_analysis.png
│
└── README.md



