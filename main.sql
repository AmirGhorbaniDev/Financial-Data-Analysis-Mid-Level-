# Import necessary libraries
import pandas as pd

# Load the dataset
file_path = "path_to_your_file.csv"  # Replace with your file path
data = pd.read_csv(file_path)

# Standardize column names
data.columns = data.columns.str.lower().str.replace(' ', '_')

# Define a function to categorize accounts
def categorize_account(name):
    name = name.lower()
    if "revenue" in name:
        return "Revenue"
    elif any(keyword in name for keyword in ["cost of", "shipping", "driver acquisition", "server", "google maps"]):
        return "Cost of Sales"
    elif any(keyword in name for keyword in ["salary", "rent", "marketing", "contractor", "hr", "travel", "saas", "support"]):
        return "Operating Expenses"
    elif any(keyword in name for keyword in ["tax", "interest", "depreciation", "loss", "donations", "bank fees", "rounding", "profit"]):
        return "Other Expenses/Income"
    elif "fringe benefits" in name:
        return "Fringe Benefits"
    elif any(keyword in name for keyword in ["it", "training", "software"]):
        return "IT Costs"
    else:
        return "Uncategorized"

# Apply categorization
data['category'] = data['account_name'].apply(categorize_account)

# Create separate columns for revenue and expenses
data['revenue'] = data.apply(lambda row: row['total_per_account'] if row['category'] == 'Revenue' else 0, axis=1)
data['expenses'] = data.apply(lambda row: row['total_per_account'] if row['category'] != 'Revenue' else 0, axis=1)

# Calculate profit
data['profit'] = data['revenue'] + data['expenses']

# Simulate budgeted data with a 5% increase
data['budgeted_revenue'] = data['revenue'] * 1.05
data['budgeted_expenses'] = data['expenses'] * 1.05
data['budgeted_profit'] = data['budgeted_revenue'] + data['budgeted_expenses']

# Assign months for analysis
data['month'] = ['January'] * (len(data) // 3) + ['February'] * (len(data) // 3) + ['March'] * (len(data) - 2 * (len(data) // 3))

# Aggregate data by month and category
monthly_summary = data.groupby(['month', 'category'])[['revenue', 'expenses', 'profit', 
                                                       'budgeted_revenue', 'budgeted_expenses', 'budgeted_profit']].sum().reset_index()

# Calculate Year-to-Date (YTD) metrics
monthly_summary['ytd_revenue'] = monthly_summary.groupby('category')['revenue'].cumsum()
monthly_summary['ytd_expenses'] = monthly_summary.groupby('category')['expenses'].cumsum()
monthly_summary['ytd_profit'] = monthly_summary.groupby('category')['profit'].cumsum()

# Save the processed data to CSV
monthly_summary.to_csv("monthly_summary.csv", index=False)
print("Processed data saved to 'monthly_summary.csv'")
