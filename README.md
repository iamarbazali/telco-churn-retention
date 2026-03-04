# telco-churn-retention
Predicts telecom customer churn risk using SQL, Python machine learning, and Power BI dashboards. Targets high-risk customers and actionable insights.

# Project Goal
Predict which telecom customers will churn so retention team can target them with proactive offers. Identifies 71% of churners while keeping 56% precision using tuned logistic regression model.

# Dataset
Telco Customer Churn dataset: 7,043 customers, 20 features

Demographics, contract details, services, billing information

Target: Churn (Yes/No), 26.5% positive class (imbalanced)

# Key Cleaning Steps
Removed customerID (non-predictive identifier)

Converted TotalCharges from object to numeric

Handled 11 invalid blanks → filled with 0 for tenure=0 customers

Created tenure bands: 0-12, 13-24, 25-48, 49-72 months

Added high monthly charge flag (>80)

# EDA Insights
Churn Rate by Contract:
- Month-to-month: 43%
- One year: 11% 
- Two year: 3%

Churn Rate by Tenure Band:
- 0-12 months: 47%
- 13-24 months: 29%
- 25-48 months: 20%
- 49+ months: 10%

Highest Risk Segments:
- Fiber optic + month-to-month
- Electronic check payments
- High monthly charges (>90)

# Model performance 
| Model               | AUC  | Churn Recall | Churn Precision | Use Case            |
| ------------------- | ---- | ------------ | --------------- | ------------------- |
| Logistic Regression | 0.84 | 52%          | 65%             | General ranking     |
| Balanced Logistic   | 0.84 | 79%          | 51%             | Retention campaigns |
| Random Forest       | 0.83 | 47%          | 63%             | Feature importance  |

# Production Model: Class-balanced logistic regression with 0.6 probability threshold
Detects 267/374 churners (71% recall)

56% precision (acceptable false positive rate for retention)

# Top Model Features (Absolute Coefficients)
Contract_Two_year: -1.42 (long contracts prevent churn)

InternetService_Fiber_optic: +1.29 (high churn risk)

Contract_One_year: -0.70

tenuregroup_49-72: +0.56 (late tenure risk)

# Business Recommendations
Priority Retention Targets:

1. Month-to-month + fiber optic + electronic check
   
2. High monthly charges (>90) + early tenure (0-24 months)

3. High value customers (TotalCharges > 2000) with churn prob > 0.6

Expected Impact: 7/10 churners reached, >50% true positives

# File structure
├── EDA_-Churn_Analysis.ipynb          # Univariate + bivariate analysis

├── Data-cleaning-EDA-Regression-Summary.md  # Executive summary

├── Model_building.ipynb              # Model training + evaluation

├── telco_churn_insights_v01.sql      # Production SQL queries

└── Customer-Churn-Analysis-Dashboard.pdf  # Power BI dashboard export

# Tech Stack
Data Cleaning: Python (pandas)

Modeling: scikit-learn (LogisticRegression, RandomForestClassifier)

SQL: SQL Server (segmentation, risk scoring)

Visualization: Power BI (interactive churn dashboard)

# Model deployment window
1. Score all customers → telcochurnscore table

2. Flag high-risk: ChurnProb > 0.6
 
3. Segment by contract, tenure, payment method
 
4. Export TOP 100 high-risk + high-value for retention campaigns

# Results Summary
7043 total customers

1869 churned (27%)

Model flags 71% of churners

Dashboard deployed for retention campaign
