# HR-Attrition-Analytics
###  Note : The dashobard is only related to employees with attrition = "yes"
Employee attrition (people quitting the company) is expensive and risky for any organization.
This project helps:

  - Understand why employees are leaving

  - Identify patterns (e.g. which departments, age groups, or roles have high attrition)

  - Support HR decisions with real data

  - Improve employee retention and reduce future attrition

----------------------------------------------------------------------------------------------------

## ** Phase (0) Project Goals **

(1) Who is the audience?

  - HR Managers

  - Business Intelligence Analysts

(2) What decisions will this report support?

  - Improve retention strategies

  - Launch programs for younger or less satisfied workers

  - Reduce costs of hiring

  - Improve salaries or reduce overtime for specific roles

(3) What questions will it answer?

  - What is the overall employee attrition rate?

  - Which departments have the highest attrition?

  - Do gender or marital status influence churn?

  - Are younger employees more likely to leave?

  - Do overtime or low income lead to quitting?

  - Does job satisfaction affect attrition?

(4) Define Key Metrics (KPIs)

  - Attrition Rate	

  - Attrition Count	

  - Total Employees

  - Avg Monthly Income

----------------------------------------------------------------------------------------------------

## ** Phase (1) Cleaning Data **
### By using MySQL to :

(1) create database and import data from csv file

(2) Check missing values in all columns

(3) Standardize text fields

(4) Remove invalid numeric values

(5) Ensure YearsAtCompany <= TotalWorkingYears

(5) Remove duplicates based on EmployeeID

(6) Add helper columns (Age Group)

----------------------------------------------------------------------------------------------------

## ** Phase (2) Data Analysis **
### By using Power BI to :

(1) Creating all the measures and columns needed.

(2) creating the charts to answer questions and gain insights

(2) Adding filters (job role)

----------------------------------------------------------------------------------------------------

## ** Phase (3) Some Insights **

(1) Attrition rate is (18.2 %) which is very high and indicates a problem to solve.

(2) HR and R&D departments are close for high attrition, this indicates high pressure.

(3) Tenure (10+ years) are the highest. 

(4) Single females indicate high attrition.

