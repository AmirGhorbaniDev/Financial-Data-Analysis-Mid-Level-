# **Financial Data Analysis Project**

## **Overview**
This repository contains a financial data analysis project aimed at analyzing revenue, expenses, and profit trends using Python and Google Looker Studio. The project focuses on categorizing financial accounts, aggregating metrics, and visualizing insights.

### ***Note:***
- **The dataset used in this project is fake and intended solely for a case study.**

---

## **Project Objectives**
1. ***Categorize financial accounts*** into meaningful groups such as Revenue, Cost of Sales, Operating Expenses, etc.
2. ***Calculate financial metrics***, including Revenue, Expenses, Profit, and Budgeted figures.
3. ***Generate insights*** such as monthly trends and category-wise contributions.
4. ***Visualize the data*** using Google Looker Studio.

---

## **Files in This Repository**

1. **`data.csv`**:
   - ***The fake dataset used for analysis.***

2. **`financial_analysis.ipynb`**:
   - ***Jupyter Notebook containing the Python code for data cleaning, transformation, and aggregation.***

3. **`monthly_summary.csv`**:
   - ***The processed dataset containing aggregated metrics for monthly and category-based analysis. This file is used for Looker Studio visualization.***

4. **`README.md`**:
   - ***This document, providing an overview of the project.***

5. **Looker Studio Dashboard**:
   - ***The visualization dashboard can be accessed [here](https://lookerstudio.google.com/reporting/f21e910c-3d6d-442a-aaee-164e96b157cb).***
![image](https://github.com/user-attachments/assets/e45805a0-cd2f-45c2-898f-68e707b9e97a)
---

## **Steps in the Analysis**

### **1. Data Cleaning**
- ***Standardized column names.***
  ```python


# Categorized accounts based on keywords in the account_name column
`def categorize_account(name):
    name = name.lower()
    if "revenue" in name:
        return "Revenue"
    elif "cost of" in name or "shipping" in name:
        return "Cost of Sales"
    elif "salary" in name or "marketing" in name:
        return "Operating Expenses"
    elif "tax" in name or "interest" in name or "depreciation" in name:
        return "Other Expenses/Income"
    elif "fringe benefits" in name:
        return "Fringe Benefits"
    elif "it" in name or "training" in name or "software" in name:
        return "IT Costs"
    else:
        return "Uncategorized"`

# Apply categorization function
data['category'] = data['account_name'].apply(categorize_account)

# Metrics Calculation
`data['profit'] = data['revenue'] - data['expenses']
data['budgeted_revenue'] = data['revenue'] * 1.05
data['budgeted_expenses'] = data['expenses'] * 1.05
data['budgeted_profit'] = data['budgeted_revenue'] - data['budgeted_expenses']`

# Normalize column names
data.columns = data.columns.str.lower().str.replace(' ', '_')

# Group data by month and category
`monthly_summary = data.groupby(['month', 'category']).agg({
    'revenue': 'sum',
    'expenses': 'sum',
    'profit': 'sum',
    'budgeted_revenue': 'sum',
    'budgeted_expenses': 'sum',
    'budgeted_profit': 'sum'
}).reset_index()`

###`Visualization in Looker Studio`
Built the following charts in Looker Studio:
![image](https://github.com/user-attachments/assets/e45805a0-cd2f-45c2-898f-68e707b9e97a)

Revenue vs. Expenses Comparison (Actual vs. Budgeted):
A bar/line chart comparing actual revenue and expenses against budgeted values.
https://lookerstudio.google.com/reporting/f21e910c-3d6d-442a-aaee-164e96b157cb
Profit Trends (Monthly and Budgeted):
A line chart showing profit trends over months, including budgeted profit.

Category Breakdown (Contribution by Category):
A pie or bar chart illustrating the contribution of each category to revenue and expenses.

YTD Analysis (Cumulative Metrics):
A cumulative line chart or scorecard showing year-to-date (YTD) figures for revenue, expenses, and profit.
