# 🎓 Problem Statement 2: Do Dual Language Program Applicants Face Disparities in Admissions Compared to General Applicants?

This analysis investigates whether students applying to **Dual Language programs** within LAUSD during 2018–2019 faced **systemic disparities** in seat offers compared to those applying to general programs. It further examines **geographic and program-level trends**, helping identify areas for intervention.

---

## 🌟 Objective

To determine whether **Dual Language applicants are underserved** relative to general applicants, and if so:

* In **which ZIP codes** or **communities** this occurs
* Whether certain **school types** have skewed acceptance patterns
* What systemic **policy recommendations** can improve equity

---

## 📂 Dataset Summary

**File Name:** `ApplicationsandSeatOffersbyApplicantDualLanguageStatus20182019.csv`  
**Source:** LAUSD Open Data Portal  
**Rows:** Each row aggregates applications and seat offers by school, zip, and applicant type (Dual Language: Yes/No).

---

## 🧠 Key Columns Used

| Column                 | Description                                                     |
| ---------------------- | --------------------------------------------------------------- |
| `Program_Name`         | Name of program (e.g., DL Two-Way Spanish)                      |
| `School`               | School name                                                     |
| `School_Type`          | Type of school (e.g., DUAL LANGUAGE, MAGNET, GENERAL)           |
| `Community_Of_Schools` | Regional zone within LAUSD (e.g., CARSON COS, DOWNTOWN COS)     |
| `Zip_Code`             | Applicant’s ZIP code                                            |
| `Dual_Language`        | YES / NO – whether applicant applied under Dual Language status |
| `Applications`         | Number of applications from that group                          |
| `Seat_Offers`          | Number of seat offers granted to that group                     |

---

# ✅ Full Analysis in Structured Format

### Problem Statement 2:  
Do Dual Language Program Applicants Face Disparities in Admissions Compared to General Applicants?

---

### 🎯 Key Insights for LAUSD Decision-Makers  
- Dual Language applicants have a **lower overall acceptance rate** (14.58%) than non-Dual applicants (20.06%)
- Some **ZIP codes and schools** show 0% acceptance for Dual applicants despite 10+ applications
- Disparities are visible across certain **school types** and **communities of schools**
- Some schools show a **25%+ rate gap** between general and Dual Language applicants

---

### 📢 Recommendations  
- Expand capacity in high-demand Dual Language programs and ZIP codes
- Investigate and correct regional or institutional disparities in Dual Language admissions
- Increase outreach and support for Dual Language program applicants
- Implement policy checks for equitable admission practices across school types

---

### 📂 Dataset Used  
**Name:** Applications and Seat Offers by Applicant Dual Language Status (2018–2019)  
**Source:** LAUSD Open Data Portal  
**Format:** CSV

---

### 🧰 Tools Used  
- Excel  
- PostgreSQL  
- pgAdmin  

---

### 🔍 Step-by-Step Data Preparation  

**Step 1: Understanding the Columns**  
We retained only relevant columns like `school`, `zip_code`, `dual_language`, `applications`, and `seat_offers`

**Step 2: Cleaning in Excel**  
- Cleaned and renamed columns to snake_case  
- Removed nulls from ZIP where necessary  
- Dropped irrelevant rows  

**Step 3: Importing to PostgreSQL**  
```sql
CREATE TABLE dual_language_applications (
    program_name TEXT,
    school TEXT,
    school_type TEXT,
    community_of_schools TEXT,
    zip_code VARCHAR(5),
    dual_language TEXT,
    applications INT,
    seat_offers INT
);
```

---

### 🔎 SQL Queries & Insights  

Each query is included in the original content block with the following structure:  

- **Query N:** Description  
- **Purpose:** Reason for running it  
- **Insight:** What was found  

> Refer to the original markdown block content for full SQL code, output summaries, and interpretation.

---

### ✅ Final Summary

The analysis uncovered consistent disparities in admission outcomes between Dual Language and general program applicants. While some schools and programs offer equitable access, others show substantial exclusion patterns, with zero seat offers for Dual Language students despite comparable application volume.  

This gap is especially stark in certain ZIP codes and school types, prompting the need for policy review and proactive inclusion strategies by LAUSD leadership.
