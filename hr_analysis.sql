CREATE DATABASE hr_project;
USE hr_project;

show tables;
describe hr_any;
select count(*) from hr_any;
ALTER TABLE hr_any
CHANGE `Ã¯Â»Â¿age` age INT;

# Overall Attrition Rate
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 
        2
    ) AS attrition_rate_percentage
FROM hr_any;

/* Overall Attrition (16.12%)
🔎 Insight
Total Employees: 1470
Employees Left: 237
Attrition Rate: 16.12% 

Business Recommendations :-

Conduct employee satisfaction survey.
Identify high-risk departments.
Review compensation and work-life balance policies. */

# Department Wise Attrition
SELECT 
    department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 
        2
    ) AS attrition_rate_percentage
FROM hr_any
GROUP BY department
ORDER BY attrition_rate_percentage DESC;

/* Key Insights
Sales Department Highest Attrition (20.63%) (446 employees)
HR Department Second Highest (19.05%) (63 employees)
R&D Lowest Attrition (13.84%) (961 employees)

Business Interpretation :-

👉 Sales roles often:
High pressure
Target-based performance
Stressful environment
Overtime involved

👉 HR :
Internal dissatisfaction?
Compensation issue?

R&D relatively stable:
Possibly better job security
Structured work culture

Business Recommendations :- 
1. For Sales Department
Introduce performance incentives
Reduce burnout (workload management)
Improve commission structure
Conduct exit interviews to identify root cause

2. For HR Department
Review salary competitiveness
Improve internal culture & recognition
Provide growth opportunities

Company-Wide Strategy :-

Focus retention efforts primarily on Sales
Monitor high-risk departments quarterly
Develop department-specific retention programs

The highest attrition rate was observed in the Sales department at 20.63%, 
indicating potential performance pressure or incentive structure issues. 
R&D showed comparatively stable retention. 
This suggests targeted retention strategies are needed particularly in Sales. */

# Attrition by Overtime
SELECT 
    overtime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 
        2
    ) AS attrition_rate_percentage
FROM hr_any
GROUP BY overtime
ORDER BY attrition_rate_percentage DESC;

/*
Key Insight :-
Employees who work overtime:
👉 30.53% attrition rate

Employees who don’t work overtime:
👉 10.44% attrition rate

That’s almost 3x higher attrition in overtime employees.

Business Recommendations :-
Immediate Actions
Reduce mandatory overtime
Monitor workload distribution
Introduce flexible work policies

📌 Strategic Actions
Hire additional staff in high workload teams
Track employee burnout metrics
Conduct engagement survey for overtime employees */

# Salary Comparison: Attrition vs Non-Attrition
SELECT 
    attrition,
    COUNT(*) AS total_employees,
    ROUND(AVG(monthlyincome), 2) AS avg_salary
FROM hr_any
GROUP BY attrition;

/* Key Insight :-
Employees who left earn:
👉 ₹4,787 average

Employees who stayed earn:
👉 ₹6,833 average

⚠ That’s a ~30% salary difference.

Lower-paid employees are significantly more likely to leave.

Business Interpretation :-

This suggests:
Compensation dissatisfaction may be driving attrition.
Employees with lower salaries feel undervalued.
Salary structure may not be competitive.
Salary + Overtime together → very strong attrition drivers.

Business Recommendations :-
Short-Term Actions
Review salary bands for lower-income roles.
Provide retention bonuses for high-risk employees.
Adjust pay for overtime-heavy roles.

📌 Long-Term Strategy
Conduct compensation benchmarking.
Introduce performance-linked salary increments.
Implement transparent salary growth pathways. */

# Attrition by Age Group
SELECT 
    CASE 
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 40 THEN '30-40'
        WHEN age BETWEEN 41 AND 50 THEN '41-50'
        ELSE 'Above 50'
    END AS age_group,
    
    COUNT(*) AS total_employees,
    
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 
        2
    ) AS attrition_rate_percentage

FROM hr_any
GROUP BY age_group
ORDER BY attrition_rate_percentage DESC;

/* Key Insight

Under 30 age group has the highest attrition rate (27.91%)

That’s nearly:
👉 1 out of every 3 young employees leaving.
Other age groups are much more stable (10–14%).

Business Interpretation :-
Younger employees:
Often early in career
Exploring better opportunities
Salary sensitive
Growth & learning driven
Less organizational loyalty

Higher attrition in under 30 suggests:
Lack of career growth clarity
Competitive job market
Possibly dissatisfaction with compensation

Business Recommendations :-
For Under 30 Employees
Create structured career growth paths
Provide mentorship programs
Introduce skill development programs
Offer performance-based increments
Conduct early-career engagement surveys

Company Strategy :-
Focus retention programs on young workforce
Track promotion timelines
Review entry-level compensation competitiveness */


# Rank Employees by Salary Within Each Department
SELECT *
FROM (
    SELECT 
        department,
        employeenumber,
        monthlyincome,
        RANK() OVER (
            PARTITION BY department 
            ORDER BY monthlyincome DESC
        ) AS salary_rank
    FROM hr_any
) ranked
WHERE salary_rank <= 3;

/* 💼 Business Interpretation
Salary structure relatively consistent across departments.
High-paying roles concentrated in R&D and Sales.
HR comparatively lower salary distribution.

Business Recommendation :-
Review pay equity across departments.
Ensure lower salary brackets align with performance expectations.
Analyze whether low-income employees overlap with high attrition groups. */

# High Risk Employee
WITH avg_salary AS (
    SELECT AVG(monthlyincome) AS company_avg
    FROM hr_any
),

high_risk AS (
    SELECT 
        employeenumber,
        age,
        department,
        monthlyincome,
        overtime
    FROM hr_any, avg_salary
    WHERE age < 30
      AND overtime = 'Yes'
      AND monthlyincome < company_avg
)

SELECT * FROM high_risk;

/* High-Risk Employees (CTE Result)

Employees:
Age < 30
Overtime = Yes
Salary below company average

Key Insight

Young + Overtime + Low Salary
= High attrition probability

Majority are from:
Research & Development
Sales
Departments.

Business Interpretation :-

In Company:
Young employees are burningout
Low salary + overtime combination is dangerous.
workload heavy in Sales & R&D 

Business Recommendations :-
Immediate Action
Identify current employees matching same criteria
Conduct retention discussion
Offer skill-based increment plan

Long-Term Strategy
Reduce overtime for junior employees
Create fast-track promotion program
Introduce early-career mentorship */

