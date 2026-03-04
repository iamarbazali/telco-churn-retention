**Goal**

Predict which telecom customers are likely to churn so the retention team can target them with proactive offers instead of reacting after they leave.



**Dataset and key cleaning steps**

Used the Telco Customer Churn dataset with 7,043 customers and 20 usable features, including demographics, contract details, services, and billing information. Removed the customerID column because it is only an identifier. Converted TotalCharges from object to numeric, handled invalid blanks using errors='coerce', then filled the resulting 11 nulls with 0 for tenure 0 customers, which reflects that new customers have not accumulated charges yet. Verified there were no other missing values. Kept tenure as a continuous numeric variable and created a clean dataframe for modeling.



**Main EDA insights**

Univariate analysis showed a strong U shaped tenure distribution, many very new customers and many long term customers. MonthlyCharges and TotalCharges are right skewed, consistent with higher revenue coming from a subset of users. Churn is imbalanced, about 26.5 percent Yes and 73.5 percent No, so simple accuracy is not informative. Categorical analysis showed churn is much higher for month to month contracts, fiber optic internet, and electronic check payments, and is much lower for one year and two year contracts, automatic bank or credit card payments, and customers with online security and tech support add ons. Correlations showed churn is negatively related to tenure and TotalCharges, higher risk for newer, low total spend customers, and weakly positively related to MonthlyCharges.



**Best model and metrics**

Tried three main models on an 80,20 train test split with one hot encoded features. Baseline logistic regression achieved accuracy around 0.80, churn precision about 0.65, churn recall about 0.52, and AUC about 0.84. Random Forest reached similar accuracy and precision but lower churn recall around 0.47 and slightly lower AUC about 0.83. A class balanced logistic regression, using class\_weight set to balanced, kept AUC at about 0.84 but significantly improved churn recall to about 0.79, with churn precision about 0.50. After tuning the churn probability threshold to 0.6 for the balanced logistic model, the confusion matrix showed precision 0.56 and recall 0.71 for churn, with 267 true churners correctly flagged and 107 missed, out of 374 churners.



**Recommendation for retention team**

Use the class balanced logistic regression model as the primary churn scoring tool, with a 0.6 probability threshold to flag customers as high risk. At this operating point the model identifies roughly 7 out of 10 churners while keeping more than half of outreach focused on true at risk customers, a reasonable tradeoff for retention campaigns. Prioritize interventions for flagged customers who are on month to month contracts, use fiber optic internet, pay through electronic check, have high monthly charges, or are in early tenure groups, for example 0 to 12 or 13 to 24 months, because these features show the strongest association with churn. Export a scored customer file with actual churn, predicted probability, and churn flag so the retention team can run targeted offers, such as incentives to move to one or two year contracts, discounts or bundles for high charge fiber plans, and promotions for automatic payment methods.

