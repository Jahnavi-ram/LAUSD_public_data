
# Problem Statement 1: Are Students in Certain Zip Codes Systematically Underserved in School Seat Offers?

This project investigates whether **students from specific ZIP codes** within the Los Angeles Unified School District (LAUSD) are **systematically underserved** during the school seat allocation process. By analyzing 2018–2019 application and offer data, we identify disparities across neighborhoods and regions that point to actionable equity concerns.

---

## 🎯 Key Insights for LAUSD Decision-Makers

- 📍 **ZIP codes 90650, 90212, 93063** had **0% acceptance rates** with over 10 applications — a strong indicator of exclusion.
- 📍 ZIPs like **90044, 90011, and 91342** showed **3,000+ unmatched applications**, revealing areas with **high demand but low fulfillment**.
- 🚍 Students from **outer regions** (prefix 935 - Antelope Valley, 903 - South Bay) have **<10% acceptance rates**, compared to ~19% in central or valley ZIPs.
- 🧭 Only **3.01%** of students applied to schools in their own ZIP, and **local applicants were far more likely** to receive offers.
- ⚠️ **1600% acceptance rate for locals** may suggest **data duplications or batch offer reporting** that require validation.

---

### 📢 Recommendations:

- 🔍 **Conduct equity audits** in repeatedly underperforming ZIP codes (90650, 90212, 93063, 91801).
- 🚍 Expand access or transportation support for underserved regions (935, 903).
- 📊 Investigate **data integrity issues** behind inflated local acceptance rates.
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

### 🧪 Query 1: Top ZIP Codes by Application Volume
**Purpose:** Identify ZIPs with the highest demand  
**SQL:**
```sql
SELECT applicant_zipcode, SUM(applications_count) AS total_applications
FROM zipcode_insights
WHERE applicant_zipcode IS NOT NULL
GROUP BY applicant_zipcode
ORDER BY total_applications DESC
LIMIT 10;
```
**Insight:** ZIPs like **90044, 91342, 90019** submitted the most applications — baseline for demand assessment.

---

### 🧪 Query 2: Top ZIP Codes by Seat Offers
**Purpose:** Measure which ZIPs received the most seat offers  
**SQL:** 
```sql
SELECT applicant_zipcode, SUM(seat_offers) AS total_seat_offers
FROM zipcode_insights
WHERE applicant_zipcode IS NOT NULL
GROUP BY applicant_zipcode
ORDER BY total_seat_offers DESC
LIMIT 10;
```
**Insight:** ZIPs like **90065, 91342, 91402** were most served — but not always the highest applicants.

---

### 🧪 Query 3: Acceptance Rate by ZIP (Min 10 Applications)
**Purpose:** Compare success rate (offers ÷ applications)  
**SQL:**
```sql
SELECT applicant_zipcode, SUM(seat_offers), SUM(applications_count),
ROUND((SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications_count), 0)) * 100, 2) AS acceptance_rate_percent
FROM zipcode_insights
WHERE applicant_zipcode IS NOT NULL
GROUP BY applicant_zipcode
HAVING SUM(applications_count) >= 10
ORDER BY acceptance_rate_percent DESC;
```
**Insight:** ZIPs like **90065 (42%)** have high placement success; **90042, 90255** had lower odds despite high demand.

---

### 🧪 Query 4: ZIPs with Lowest Acceptance Rates (Min 10 Apps)
**Purpose:** Find ZIPs where students are least likely to receive offers  
**SQL:**
```sql
-- Same as Query 3, ordered ASC with LIMIT 10
```
**Insight:** **93063, 90212, 91801** had 0% seat offers — potential systemic exclusion.

---

### 🧪 Query 5: Widest Application-Offer Gaps
**Purpose:** Identify absolute mismatch volumes  
**SQL:**
```sql
SELECT applicant_zipcode,
SUM(applications_count) AS total_applications,
SUM(seat_offers) AS total_offers,
(SUM(applications_count) - SUM(seat_offers)) AS application_offer_gap
FROM zipcode_insights
WHERE applicant_zipcode IS NOT NULL
GROUP BY applicant_zipcode
HAVING SUM(applications_count) >= 10
ORDER BY application_offer_gap DESC
LIMIT 10;
```
**Insight:** ZIPs like **90044, 90011, 91342** have **3,000+ unplaced students** — clear demand–supply imbalance.

---

### 🧪 Query 6: % of Students Applying to Local Schools
**Purpose:** Measure neighborhood school preference  
**SQL:**
```sql
SELECT COUNT(*) AS total_applications,
COUNT(*) FILTER (WHERE applicant_zipcode = school_zipcode) AS local_applications,
ROUND((COUNT(*) FILTER (WHERE applicant_zipcode = school_zipcode) * 100.0) / COUNT(*), 2) AS local_application_percent
FROM zipcode_insights
WHERE applicant_zipcode IS NOT NULL AND school_zipcode IS NOT NULL;
```
**Insight:** Only **3.01%** of students applied to schools in their own ZIP — signals **weak neighborhood program coverage**.

---

### 🧪 Query 7: Acceptance Rate – Local vs Non-Local
**Purpose:** Compare outcomes for local vs. non-local applications  
**SQL:**
```sql
SELECT CASE WHEN applicant_zipcode = school_zipcode THEN 'Local' ELSE 'Non-Local' END AS application_type,
COUNT(*) AS total_applications, SUM(seat_offers) AS total_offers,
ROUND((SUM(seat_offers)::DECIMAL / NULLIF(COUNT(*), 0)) * 100, 2) AS acceptance_rate_percent
FROM zipcode_insights
WHERE applicant_zipcode IS NOT NULL AND school_zipcode IS NOT NULL
GROUP BY application_type;
```
**Insight:** Local applicants had **>1600% acceptance rate** — suggests potential data duplication or batch-based offer reporting.

---

### 🧪 Query 8: ZIPs with Applications but 0 Offers
**Purpose:** Spot total exclusion  
**SQL:**
```sql
SELECT applicant_zipcode, SUM(applications_count) AS total_applications
FROM zipcode_insights
WHERE applicant_zipcode IS NOT NULL
GROUP BY applicant_zipcode
HAVING SUM(applications_count) > 0 AND SUM(seat_offers) = 0
ORDER BY total_applications DESC;
```
**Insight:** **90212, 90650, 93063** submitted multiple applications but received **no seat offers** — requires urgent equity review.

---

### 🧪 Query 9: ZIPs >1 SD Below Mean (Z-score)
**Purpose:** Flag statistically underserved ZIPs  
**SQL:**
```sql
-- See original full z-score query with stddev & avg
```
**Insight:** **24 ZIPs** had acceptance rates >1 SD below the 17.35% mean. Repeated outliers (e.g., **90650, 90262**) validate systemic patterns.

---

### 🧪 Query 10: Regional Patterns by ZIP Prefix
**Purpose:** Spot macro geographic disparities  
**SQL:**
```sql
SELECT LEFT(applicant_zipcode, 3) AS zip_region,
SUM(applications_count), SUM(seat_offers),
ROUND((SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications_count), 0)) * 100, 2) AS acceptance_rate
FROM zipcode_insights
WHERE applicant_zipcode IS NOT NULL
GROUP BY LEFT(applicant_zipcode, 3)
HAVING SUM(applications_count) >= 30
ORDER BY acceptance_rate ASC;
```
**Insight:** **935 (Antelope Valley), 903 (Inglewood/South Bay)** had the **lowest regional acceptance rates (5–10%)**, while **913, 914 (Valley)** exceeded 19%.

---

## ✅ Final Summary

This investigation revealed **ZIP-level and regional inequities** in LAUSD’s 2018–2019 school seat allocation:

- Some areas — especially in **South Bay, East LA, and the outskirts** — had **repeated underperformance**, with 0% seat offers or massive unplaced demand.
- Students applying **outside their ZIP** dominate applications, yet **local students were favored**, with possible data inflation.
- Certain ZIPs are **statistical outliers** in a system meant to serve all equitably.

By acting on these findings, LAUSD can take meaningful steps toward **fairer, regionally balanced school access for all students**.

