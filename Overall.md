# LAUSD Equity in Enrollment Analysis (2018-2019)

## 📊 Project Overview

This data analysis project investigates equity in school enrollment patterns within the Los Angeles Unified School District (LAUSD) using publicly available 2018–2019 data. The focus is to uncover potential disparities based on applicant ZIP codes, school locations, and seat offerings — shedding light on access, demand, and possible barriers across neighborhoods.

The project is broken into **four problem statements**, each exploring a different equity dimension using SQL and Excel. These insights can support data-driven policymaking and help the district move closer to equitable education access.

---

## 🎯 Project Goals

* Identify geographic disparities in school applications and seat allocations.
* Understand which schools and programs are under or over-subscribed.
* Analyze whether students prefer local schools or seek opportunities outside their neighborhoods.
* Spot signs of exclusion, unmet demand, or inconsistent access to programs.

---

## 🧩 Problem Statements

### 1. ZIP Code-Based Enrollment Equity

Do certain applicant ZIP codes consistently receive fewer seat offers? Are some neighborhoods systematically disadvantaged compared to others?

### 2. Program-Level Acceptance Patterns

Are some programs disproportionately rejecting or accepting applicants? Which ones have the lowest and highest seat offer rates?

### 3. School-Level Overload or Underenrollment

Which schools are overburdened with applications versus those that receive few? Is the system optimally distributing demand?

### 4. Applicant Behavior & Preferences

Are students applying to schools outside their own ZIP code? Do they favor specialized programs, magnet schools, or local options?

---

## 🛠️ Tools & Technologies Used

* **Excel**: Data exploration, cleaning, and structure validation
* **PostgreSQL**: SQL querying and analysis (interchangeable with SQL Server)
* **pgAdmin**: Local PostgreSQL server management
* **GitHub**: Version control, project documentation, and portfolio showcase

```

---

## 📂 Dataset Used

* **Source**: LAUSD Open Data Portal
* **File**: Applications and Seat Offers by Applicant Zip Code (2018–2019)
* **Fields included**: Program Name, School Name, School Type, School Zip Code, Applicant Zip Code, Applications, Seat Offers, etc.

---

## 🚧 Methodology Summary

1. **Data Import & Cleaning in Excel**

   * Inspected columns for meaning and relevance
   * Renamed and simplified headers for clarity
   * Removed irrelevant fields and handled NA values
   * Saved cleaned version as `.csv`

2. **Database Setup**

   * Created local PostgreSQL database `lausd`
   * Imported cleaned `.csv` file into a table named `zipcode_insights`

3. **Query Design & Execution**

   * Designed exploratory queries aligned to each problem statement
   * Aggregated and filtered data using SQL logic
   * Generated insights using JOINs, CTEs, and calculations

4. **Insight Extraction & Documentation**

   * Summarized each finding in clear, policy-relevant language
   * Linked query results to equity-related questions
   * Created markdown summaries for GitHub documentation

---

## 🧠 Key Takeaways (So Far)

* Some ZIP codes apply more frequently but receive fewer seat offers.
* A few schools dominate application volume, suggesting uneven demand.
* Applicants often prefer schools outside their neighborhoods.
* Many schools attract diverse applicants but seat offer rates vary.

(See insights folder for deeper findings.)

---

## 🏁 Next Steps

* Complete and polish markdown insight files for each problem statement
* Run queries in SQL Server (SSMS) once environment is available
* Visualize key patterns using Tableau or Power BI

---

## 💬 Author

**Jahnavi Ram Polisetti**
24-year-old Data Analyst passionate about social equity, education, and data storytelling.

Feel free to reach out or explore more of my work on [LinkedIn](https://www.linkedin.com/)!

---

## ⭐ Acknowledgments

Special thanks to LAUSD for making public data accessible, and to the open-source community for PostgreSQL, pgAdmin, and SQL learning resources.



# 📊 LAUSD Equity in Enrollment Analysis

## Overview

This project investigates equity in school admissions across Los Angeles Unified School District (LAUSD), using publicly available datasets. We focused on answering four high-impact questions related to zip code-level access, absenteeism and outcomes, program fairness, and gender-based disparities.

By analyzing application and seat offer trends, program-level patterns, and demographic signals, we aim to uncover hidden inequities and guide fairer educational planning decisions.

## Problem Statements

### 1. Are Students in Certain Zip Codes Systematically Underserved in School Seat Offers?

We explore whether a student’s place of residence influences their access to school seats, identifying geographic patterns of exclusion.

### 2. How Does Chronic Absenteeism Influence Graduation and Dropout Rates Across High Schools?

We examine the correlation between chronic absenteeism rates and student outcomes like graduation and dropout across LAUSD high schools.

### 3. Do Dual Language Program Applicants Face Disparities in Admissions Compared to General Applicants?

We investigate if students applying to dual language programs experience lower admission rates or other patterns of unequal access.

### 4. Is There a Gender Imbalance in Seat Offers Within High-Demand Magnet and Gifted Programs?

We look into whether male and female students receive proportionate seat offers in elite academic programs, focusing on fairness in opportunity.

## Data Sources

All data comes from LAUSD’s open data portal and includes application-level and program-level CSVs from the 2018–2019 school year.

## Tools Used

* **Excel**: Initial data exploration and cleaning
* **PostgreSQL**: Data modeling and querying (mimicking SQL Server environment)
* **pgAdmin**: SQL interface used for running queries and visual analysis
* **GitHub**: Project documentation and version control

## Methodology

1. **Problem Identification** – We selected equity-focused questions that LAUSD stakeholders deeply care about.
2. **Dataset Selection** – Each question was matched with a relevant dataset from the LAUSD open data portal.
3. **Data Cleaning** – Conducted in Excel to address missing values, rename fields, and streamline analysis.
4. **Data Modeling** – Tables created and loaded into PostgreSQL for structured querying.
5. **Querying & Analysis** – SQL used to derive insights that answer each problem statement.
6. **Documentation** – All steps and findings shared via GitHub for transparency and impact.

## Repository Structure

```
LAUSD-Equity-Analysis/
│
├── README.md  ← Project overview
├── Problem1_Zipcode_Equity.md  ← Seat offers by zip code
├── Problem2_Absenteeism_Impact.md  ← Absenteeism vs. outcomes
├── Problem3_DualLanguage_Disparities.md  ← Program-level fairness
├── Problem4_Gender_MagnetBias.md  ← Gender disparities in elite programs
└── /data  ← Cleaned CSVs used for each problem
```

## Impact

This analysis provides a deeper lens into educational opportunity and systemic bias across LAUSD, equipping decision-makers with actionable insights.

---

✨ Let’s now dive into [Problem 1: Are Students in Certain Zip Codes Systematically Underserved in School Seat Offers?](Problem1_Zipcode_Equity.md) →












A. Demand vs. Supply Imbalance by ZIP Code

Top applicant zip codes by number of applications
Where is demand the highest?
Top applicant zip codes by number of seat offers
Where are seats being granted most?
Acceptance rate by applicant zip code
Which zip codes have low seat_offer/application ratios?
Zip codes with lowest acceptance rates (with a minimum number of applications, e.g. >10)
To avoid skew from single-applicant zip codes.
Top 10 zip codes with the widest gap between applications and seat offers
Potential red flags for underserved areas.
B. Local vs. Non-Local Preference

What % of applicants apply to schools within their own zip code?
Do students prefer neighborhood schools?
What % of seat offers go to local vs non-local applicants?
Are schools favoring outsiders over their own neighborhood kids?
C. School Perspective: ZIP Code Diversity

Which school zip codes receive applications from the widest variety of applicant zip codes?
Are some schools becoming regional hubs?
Which schools admit students mostly from their own zip code vs other zip codes?
May reveal equitable vs selective practices.
D. Severity Flags

Which zip codes have 0 seat offers despite receiving applications?
Strong signal of being overlooked.

