# Fetch---Data-Analyst-Take-Home
Solution For Fetch - Data Analyst Take Home
First: explore the data
	- Data from Users, Transactions, and Products was reviewed for structural consistency and integrity.
	- Major Data Quality Issues Identified:

Users Data:
language and gender fields contain inconsistent and unstandardized values, reducing demographic segmentation accuracy.
Only 91 users (out of 50,000 transactions) exist in the user's table, suggesting missing references or data ingestion issues.
Transactions Data:
Foreign Key Issues: Only 6,562 barcodes match the products table, meaning many transactions reference nonexistent products.
Duplicate Records: 161 duplicate transactions and 12,209 transactions with zero quantity were removed to ensure accurate reporting.
Products Data:
185 duplicate barcodes were removed before inserting into the final table.
Product categories (category_1 - category_4) contain missing, misclassified, or redundant values, making category-based analysis difficult.

For more details, refer to the reports: 
	1.) Query_1_explore_data.pdf 
	2.) Doc_First_explore.pdf

Second: provide SQL queries
SQL queries were developed to analyze.
For Closed-ended questions - Refer - Query_2.1_closed_ended.pdf
For Open-ended questions - Refer  - Query_2.2_open_ended.pdf

Third: Communicate with Stakeholders
An executive summary was prepared to communicate findings, insights, and next steps to business stakeholders.
Refer to the file: Email_Communication.pdf
