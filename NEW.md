
# Problem Statement 1: Are Students in Certain Zip Codes Systematically Underserved in School Seat Offers?

This analysis investigates **whether students in specific ZIP codes are systematically underserved** in LAUSD’s school seat offer process. Using 2018–2019 data, we examined patterns in applications vs. offers, acceptance rates, and regional disparities to highlight geographic equity gaps.

---

## 🎯 Key Findings for LAUSD Decision-Makers

- Some ZIP codes consistently show **low or zero acceptance rates**, despite meaningful application volumes.
- **Outer and lower-access regions** like 935, 903, and 912 display significant seat shortages.
- **Only 3%** of students apply to schools within their own ZIP — suggesting neighborhood schools may not meet student preferences or needs.
- Local applicants (those applying within their own ZIP) had **much higher acceptance rates**, but the magnitude suggests potential **data anomalies** or **policy favoritism** worth reviewing.

These patterns signal an opportunity to:
- **Reassess program access across regions**
- Consider **transportation or policy updates**
- **Monitor schools consistently under-serving specific ZIPs**

---

## 📂 Dataset Used

**Dataset Name:** Applications and Seat Offers by Applicant Zip Code (2018–2019)  
**Source:** LAUSD Open Data Portal  
**Format:** CSV

---

## 🧰 Tools Used

- **Excel** – Cleaning & preprocessing  
- **PostgreSQL** – Data querying  
- **pgAdmin** – GUI interface for SQL analysis

---

## 🧠 Step 1: Understanding the Columns

Only the following columns were retained for analysis:
- `Program Name`
- `School Name`
- `School Zip Code`
- `Applicant Zip Code`
- `Applications`
- `Seat Offers`

Others were dropped as irrelevant to ZIP-level seat equity.

---

## 🧼 Step 2: Cleaning in Excel

- Removed unnecessary columns
- Renamed for SQL use (e.g., `Applicant Zip Code` → `applicant_zipcode`)
- Dropped rows with missing `program_name`
- Nullified missing `applicant_zipcode` entries
- Validated ZIP format and numeric types

---

## 🛠️ Step 3: Importing to PostgreSQL

- Database: `lausd`
- Table: `zipcode_insights`
- Columns: program_name, school_name, school_type, school_zipcode, applicant_zipcode, applications_count, seat_offers
- Data imported via pgAdmin

---

## 🔍 SQL Equity Queries Summary

Each of the 10 queries below addresses a different angle of ZIP-code-based inequity. Results were interpreted **holistically**, not in isolation.

---

### 🧪 Query 1: Top ZIP Codes by Application Volume
Revealed ZIPs like **90044**, **91342**, and **90019** had the highest demand for seats — our **starting point** for equity checks.

---

### 🧪 Query 2: Top ZIP Codes by Seat Offers
ZIPs like **90065**, **91342**, and **91402** received the most offers. Comparing this with Query 1 uncovered **misalignments in demand vs. supply**.

---

### 🧪 Query 3: Acceptance Rates by ZIP (≥10 Apps)
Exposed ZIPs with high success rates (e.g., **90065**, **90501**) and flagged others with **low but active participation**.

---

### 🧪 Query 4: Lowest Acceptance Rate ZIPs (≥10 Apps)
ZIPs like **93063**, **90212**, and **91801** showed **0% seat offer rates** — a strong indicator of systemic exclusion.

---

### 🧪 Query 5: Widest Application-Offer Gaps
ZIPs like **90044**, **91342**, and **90011** had **2,500–3,500+ unplaced students**, reinforcing underserved area flags.

---

### 🧪 Query 6: % of Local (Same-ZIP) Applications
Only **3.01%** of students applied to schools in their own ZIP. Indicates **low local school preference** — due to availability, quality, or program specialization.

---

### 🧪 Query 7: Acceptance Rate – Local vs Non-Local
Local applicants had **higher acceptance rates**, but data showed **over 1600% success**, hinting at **duplicated offers or policy-based bias**. Needs further clarification from LAUSD.

---

### 🧪 Query 8: ZIPs with 0 Offers Despite Applications
117 ZIPs had **non-zero applications** but **0 offers**. ZIPs like **90212** and **90650** appeared in multiple low-success queries — clear **red flags**.

---

### 🧪 Query 9: Statistically Underserved ZIPs (Z-Score)
Using average rate (17.35%) and SD (7.34), we found **24 ZIPs more than 1 SD below average** — statistically significant under-service. Examples: **90650**, **93063**, **90262**.

---

### 🧪 Query 10: Regional ZIP Prefix Trends
Grouped ZIPs by their 3-digit prefix. Found **935 (Antelope Valley)** and **903 (South Bay)** had lowest regional acceptance rates (5–10%). Valley and West LA fared better (~19%).

---

## 🧾 Overall Conclusion

This analysis confirms that **some LAUSD ZIP codes are systematically underserved** in the school seat offer process. Students from outer and certain inner-city regions face:

- **Lower acceptance rates**
- **Zero-offer outcomes**
- **High application–offer mismatches**

We recommend LAUSD:

- Conduct targeted **access audits** on low-performing ZIPs  
- Investigate local offer dynamics for data integrity  
- Consider **equity-based adjustments** in seat allocation, transportation, or program outreach  

These insights can help inform **data-driven policy decisions** that move LAUSD closer to true geographic equity in school access.

