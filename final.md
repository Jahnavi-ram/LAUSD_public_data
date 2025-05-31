# Problem Statement 1: Are Students in Certain Zip Codes Systematically Underserved in School Seat Offers?

This project investigates whether **students from specific ZIP codes** within the Los Angeles Unified School District (LAUSD) are **systematically underserved** during the school seat allocation process. By analyzing 2018–2019 application and offer data, we identify disparities across neighborhoods and regions that point to actionable equity concerns.

---

## 🎯 Key Insights for LAUSD Decision-Makers

- 📍 **ZIP codes 90650, 90212, 93063** had **0% acceptance rates** with over 10 applications, a strong indicator of exclusion.
- 📍 ZIPs like **90044, 90011, and 91342** showed **3,000+ unmatched applications**, revealing areas with **high demand but low fulfillment**.
- 🚍 Students from **outer regions** (prefix 935 - Antelope Valley, 903 - South Bay) have **<10% acceptance rates**, compared to ~19% in central or valley ZIPs.
- 🧭 Only **3.01%** of students applied to schools in their own ZIP, and **local applicants were far more likely** to receive offers.
- ✅ Local applicants had a **27.35% acceptance rate**, vs. 17.55% for non-local — a more reasonable but still significant advantage.

---

### 📢 Recommendations:

- 🔍 **Conduct equity audits** in repeatedly underperforming ZIP codes (90650, 90212, 93063, 91801).
- 🚍 Expand access or transportation support for underserved regions (935, 903).
- 📘 Review offer allocation policies to clarify how multiple seat offers are counted and communicated across applications — especially for local applicants.
- 🏫 Evaluate school/program coverage in low-offer areas to support targeted resource allocation.

---

## 📂 Dataset Used

**Name:** Applications and Seat Offers by Applicant Zip Code (2018–2019)  
**Source:** LAUSD Open Data Portal  
**Format:** CSV

---

## 🧰 Tools Used

- **Excel**: Cleaning & formatting  
- **PostgreSQL**: SQL-based querying  
- **pgAdmin**: GUI for PostgreSQL

---

## 🔍 Step-by-Step Data Preparation

### Step 1: Understanding the Columns
Columns selected:
- `program_name`, `school_name`, `school_zipcode`, `applicant_zipcode`, `applications`, `seat_offers`

### Step 2: Cleaning in Excel
- Removed unnecessary columns
- Renamed to snake_case
- Replaced missing applicant_zipcode with NULL
- Dropped rows with missing program_name
- Validated data types

### Step 3: Importing to PostgreSQL
```sql
CREATE TABLE zipcode_insights (
    program_name TEXT,
    school_name TEXT,
    school_type TEXT,
    school_zipcode VARCHAR(5),
    applicant_zipcode VARCHAR(5),
    applications_count INT,
    seat_offers INT
);
```
Imported using pgAdmin import tool.

---

## 🔎 SQL Queries & Insights

### Query 1: Top ZIP Codes by Application Volume
**Purpose:** Identify ZIPs with the highest demand  
**Insight:** ZIPs like **90044, 91342, 90019** submitted the most applications, baseline for demand assessment.

### Query 2: Top ZIP Codes by Seat Offers
**Purpose:** Measure which ZIPs received the most seat offers  
**Insight:** ZIPs like **90065, 91342, 91402** were most served, but not always the highest applicants.

### Query 3: Acceptance Rate by ZIP (Min 10 Applications)
**Purpose:** Compare success rate (offers ÷ applications)  
**Insight:** ZIPs like **90065 (42%)** have high placement success; **90042, 90255** had lower odds despite high demand.

### Query 4: ZIPs with Lowest Acceptance Rates (Min 10 Apps)
**Purpose:** Find ZIPs where students are least likely to receive offers  
**Insight:** **93063, 90212, 91801** had 0% seat offers, potential systemic exclusion.

### Query 5: Widest Application-Offer Gaps
**Purpose:** Identify absolute mismatch volumes  
**Insight:** ZIPs like **90044, 90011, 91342** have **3,000+ unplaced students**, clear demand–supply imbalance.

### Query 6: % of Students Applying to Local Schools
**Purpose:** Measure neighborhood school preference  
**Insight:** Only **3.01%** of students applied to schools in their own ZIP, signals **weak neighborhood program coverage**.

### Query 7: Acceptance Rate – Local vs Non-Local
**Purpose:** Compare outcomes for local vs. non-local applications  
**Insight:** Local applicants had **27.35% acceptance rate**, vs. **17.55%** for non-local applicants, indicating advantage from proximity or enrollment priority.

### Query 8: ZIPs with Applications but 0 Offers
**Purpose:** Spot total exclusion  
**Insight:** **90212, 90650, 93063** submitted multiple applications but received **no seat offers**, requires urgent equity review.

### Query 9: ZIPs >1 SD Below Mean (Z-score)
**Purpose:** Flag statistically underserved ZIPs  
**Insight:** **24 ZIPs** had acceptance rates >1 SD below the 17.35% mean. Repeated outliers (e.g., **90650, 90262**) validate systemic patterns.

### Query 10: Regional Patterns by ZIP Prefix
**Purpose:** Spot macro geographic disparities  
**Insight:** **935 (Antelope Valley), 903 (Inglewood/South Bay)** had the **lowest regional acceptance rates (5–10%)**, while **913, 914 (Valley)** exceeded 19%.

---

## ✅ Final Summary

This investigation revealed **ZIP-level and regional inequities** in LAUSD’s 2018–2019 school seat allocation:

- Some areas, especially in **South Bay, East LA, and the outskirts** — had **repeated underperformance**, with 0% seat offers or massive unplaced demand.
- Students applying **outside their ZIP** dominate applications, yet **local students were favored**, with a 10%+ better success rate.
- Certain ZIPs are **statistical outliers** in a system meant to serve all equitably.

By acting on these findings, LAUSD can take meaningful steps toward **fairer, regionally balanced school access for all students**.
