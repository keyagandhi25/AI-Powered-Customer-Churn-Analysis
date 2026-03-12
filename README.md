# Customer-Churn-Analysis
AI-powered telecom customer churn analysis using SQL ETL, Python Random Forest modeling, and Power BI dashboards to identify churn drivers and predict high-risk customers.

The goal of the project is to identify churn drivers, analyze customer behavior, and predict future churn risk to help telecom companies improve customer retention strategies.

**Tools & Technologies**

SQL for data cleaning and transformation
Python for predictive modeling
Random Forest Machine Learning Model
Power BI for interactive dashboard visualization

**Tools used:**

SQL Server Management Studio
Python
Jupyter Notebook
Microsoft Power BI Desktop

**Project Workflow**

Generated a telecom customer dataset with realistic values and inconsistencies.
Cleaned and transformed data using SQL views.
Performed exploratory data analysis to identify churn patterns.
Built a Random Forest machine learning model to predict churn risk.
Created an interactive Power BI dashboard to visualize churn insights and prediction results.

**Key Insights**
Customers with Month-to-Month contracts showed the highest churn rate.
Customers with low tenure (first 12 months) were more likely to churn.
Price sensitivity and competitor offers were major churn drivers.
Customers without additional services (security, backup, premium support) had higher churn probability.

**Dashboard Pages**
Page 1 – Customer Overview
Customer demographics
Contract distribution
Service usage analysis

Page 2 – Churn Analysis
Churn rate by contract type
Churn by payment method
Churn by tenure and services

Page 3 – Predictive Churn Risk
Machine learning prediction results
High-risk customers identification
Future churn probability analysis

**Machine Learning Model**

A Random Forest classification model was used to predict whether a customer is likely to churn based on features such as:
Tenure
Contract type
Monthly charges
Internet service
Payment method
Additional services

The model helps identify high-risk customers who may churn in the future, enabling proactive retention strategies.

**Project Structure**
Customer-Churn-Analysis
│
├── Dataset
├── SQL Queries
├── Python Machine Learning Model
├── Power BI Dashboard
└── Project Documentation

Dashboard Preview
![Db1](https://github.com/user-attachments/assets/7be89cf2-d65d-4ad1-8aa3-1434ec28cd9a)

Customer Churn Reason

![db2_churnreason](https://github.com/user-attachments/assets/f31f8c9a-0eb3-48f2-876a-e20df2b08444)

Predictive Churn Risk Dashboard
![db3_churnanalysisprediction](https://github.com/user-attachments/assets/c76fa686-716a-48ca-b106-59a4279c8264)

**Business Value**
This project simulates a real-world telecom analytics scenario in which data analytics and machine learning are used to reduce customer churn and improve retention strategies.

