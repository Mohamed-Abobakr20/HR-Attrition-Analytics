# creating the database and the table of employee
# --------------------------------------------------
CREATE DATABASE hr_analytics;
USE hr_analytics;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE employee_attrition (
    EmployeeID VARCHAR(10),
    Age INT,
    Gender VARCHAR(10),
    Department VARCHAR(50),
    JobRole VARCHAR(50),
    MonthlyIncome DECIMAL(10,2),
    TotalWorkingYears INT,
    YearsAtCompany INT,
    Attrition VARCHAR(3),
    EducationField VARCHAR(50),
    JobSatisfaction INT,
    OverTime VARCHAR(3),
    MaritalStatus VARCHAR(10),
    PerformanceRating INT
);


-- ---------------------------------------------
-- HR Attrition Data Cleaning Script (SQL)
-- ---------------------------------------------

-- Step 1: Check for NULL values across all columns
SELECT 
  COUNT(*) AS total_rows,
  SUM(CASE WHEN EmployeeID IS NULL THEN 1 ELSE 0 END) AS null_EmployeeID,
  SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS null_Age,
  SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS null_Gender,
  SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS null_Department,
  SUM(CASE WHEN JobRole IS NULL THEN 1 ELSE 0 END) AS null_JobRole,
  SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS null_MonthlyIncome,
  SUM(CASE WHEN TotalWorkingYears IS NULL THEN 1 ELSE 0 END) AS null_TotalWorkingYears,
  SUM(CASE WHEN YearsAtCompany IS NULL THEN 1 ELSE 0 END) AS null_YearsAtCompany,
  SUM(CASE WHEN Attrition IS NULL THEN 1 ELSE 0 END) AS null_Attrition,
  SUM(CASE WHEN EducationField IS NULL THEN 1 ELSE 0 END) AS null_EducationField,
  SUM(CASE WHEN JobSatisfaction IS NULL THEN 1 ELSE 0 END) AS null_JobSatisfaction,
  SUM(CASE WHEN OverTime IS NULL THEN 1 ELSE 0 END) AS null_OverTime,
  SUM(CASE WHEN MaritalStatus IS NULL THEN 1 ELSE 0 END) AS null_MaritalStatus,
  SUM(CASE WHEN PerformanceRating IS NULL THEN 1 ELSE 0 END) AS null_PerformanceRating
FROM employee_attrition;


-- Step 3: Standardize categorical fields
-- Clean Gender
UPDATE employee_attrition SET Gender = lower(TRIM(Gender));

-- Clean Department
UPDATE employee_attrition SET Department = lower(TRIM(Department));

-- Clean JobRole
UPDATE employee_attrition SET JobRole = lower(TRIM(JobRole));

-- Clean Attrition
UPDATE employee_attrition SET Attrition = lower(TRIM(Attrition));

-- Clean EducationField
UPDATE employee_attrition SET EducationField = lower(TRIM(EducationField));

-- Clean OverTime
UPDATE employee_attrition SET OverTime = lower(TRIM(OverTime));

-- Clean MaritalStatus
UPDATE employee_attrition SET MaritalStatus = lower(TRIM(MaritalStatus));

-- Step 4: Remove invalid numeric values
-- Age: valid range 18–65
DELETE FROM employee_attrition WHERE Age < 18 OR Age > 60;

-- MonthlyIncome: remove unrealistic values
DELETE FROM employee_attrition WHERE MonthlyIncome < 2000 OR MonthlyIncome > 50000;

-- JobSatisfaction: must be 1–4
DELETE FROM employee_attrition WHERE JobSatisfaction NOT BETWEEN 1 AND 4;

-- PerformanceRating: must be 1–4
DELETE FROM employee_attrition WHERE PerformanceRating NOT BETWEEN 1 AND 4;

-- Step 5: Ensure YearsAtCompany <= TotalWorkingYears
DELETE FROM employee_attrition WHERE YearsAtCompany > TotalWorkingYears;

-- Step 6: Remove duplicates based on EmployeeID
WITH ranked_employees AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY EmployeeID ORDER BY EmployeeID) AS rn
  FROM employee_attrition
)

DELETE FROM employee_attrition
WHERE EmployeeID IN (
  SELECT EmployeeID FROM ranked_employees WHERE rn > 1
);


-- Step 7: Add Age Group column (optional feature engineering)
ALTER TABLE employee_attrition ADD COLUMN AgeGroup VARCHAR(20);

UPDATE employee_attrition
SET AgeGroup = CASE
  WHEN Age < 30 THEN 'Under 30'
  WHEN Age BETWEEN 30 AND 39 THEN '30-39'
  WHEN Age BETWEEN 40 AND 49 THEN '40-49'
  ELSE '50+'
END;

-- Final check: view sample cleaned data
SELECT * FROM employee_attrition LIMIT 10;
