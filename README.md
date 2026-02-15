# 📊 HR Analytics & Employee Attrition Analysis (SQL Project)

---

## 📌 Project Overview

This project analyzes employee data to identify patterns and key factors influencing employee attrition.

Using SQL, the analysis focuses on salary distribution, overtime impact, age trends, and department-level attrition to provide actionable HR insights and business recommendations.

The goal is to support data-driven workforce management and improve employee retention strategies.

---

## 🛠 Tools & Technologies Used

- 🗄 MySQL
- 🧮 SQL (CTE, Window Functions, CASE Statements, Aggregations)
- 📊 Data-driven business analysis

---

## 📂 Dataset

The dataset used is the **IBM HR Analytics Employee Attrition Dataset**, containing 1,470 employee records with 35 attributes including:

- Age
- Department
- Gender
- MonthlyIncome
- Attrition
- Overtime
- YearsAtCompany
- PerformanceRating
- JobRole

---

## 🧹 Data Preparation

- Imported CSV into MySQL
- Cleaned column names
- Verified row counts (1470 records)
- Structured database for analytical querying

---

## 📊 Key Analysis Performed

### 1️⃣ Overall Attrition Rate

- Total Employees: 1470
- Employees Left: 237
- Attrition Rate: **16.12%**

This indicates moderate employee turnover requiring attention.

---

### 2️⃣ Department-wise Attrition

| Department | Attrition Rate |
|------------|---------------|
| Sales | **20.63%** |
| Human Resources | 19.05% |
| Research & Development | 13.84% |

**Insight:** Sales department shows highest attrition.

---

### 3️⃣ Overtime Impact Analysis

| Overtime | Attrition Rate |
|----------|---------------|
| Yes | **30.53%** |
| No | 10.44% |

**Key Finding:** Employees working overtime are nearly 3x more likely to leave.

---

### 4️⃣ Salary vs Attrition

- Avg Salary (Attrition = Yes): ₹4,787
- Avg Salary (Attrition = No): ₹6,833

**Insight:** Lower salary strongly correlates with higher attrition.

---

### 5️⃣ Age Group Analysis

| Age Group | Attrition Rate |
|-----------|---------------|
| Under 30 | **27.91%** |
| 30–40 | 13.84% |
| 41–50 | 10.56% |
| Above 50 | 12.59% |

**Insight:** Young employees under 30 show significantly higher turnover.

---

## 🔥 Advanced SQL Implementation

### ✅ Window Function
Ranked employees by salary within each department using:

- `RANK() OVER (PARTITION BY department ORDER BY monthlyincome DESC)`

Used to analyze internal salary distribution.

---

### ✅ CTE (Common Table Expression)
Identified high-risk employees based on:

- Age < 30  
- Overtime = Yes  
- Salary below company average  

This helped proactively detect employees with high attrition probability.

---

## 💡 Key Business Insights

- Sales department requires urgent retention focus.
- Overtime is the strongest driver of attrition.
- Lower-income employees are more likely to resign.
- Young workforce is highly volatile.
- Salary distribution is structured but may require adjustment in lower bands.

---

## 🎯 Business Recommendations

- Reduce overtime dependency.
- Review compensation strategy for junior roles.
- Introduce mentorship and career growth programs for young employees.
- Conduct department-specific retention analysis.
- Monitor high-risk employees proactively.

---

## 🚀 Conclusion

This project demonstrates:

✔ Strong SQL querying skills  
✔ Use of Window Functions & CTE  
✔ Business-focused analytical thinking  
✔ Ability to translate data into actionable insights  

The analysis provides a structured approach to understanding employee attrition and supports strategic HR decision-making.

---

✨ This project highlights practical SQL skills applied to real-world HR analytics and workforce management challenges.

