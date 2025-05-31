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




# Problem Statement 2: Do Dual Language Program Applicants Face Disparities in Admissions Compared to General Applicants?

This analysis investigates whether students applying to **Dual Language (DL) programs** in LAUSD schools face different acceptance outcomes compared to general applicants. The focus is on exploring potential equity gaps based on language program participation — particularly whether **"ApplicantDualLanguage = Yes"** applicants are systematically disadvantaged in admissions.

---

## 🎯 Key Insights Sought

- Do Dual Language applicants have **lower acceptance rates** than general applicants?
- Are they **underrepresented** in high-demand schools or certain communities?
- Is there a difference in **acceptance by school type** (e.g., magnet vs. non-magnet)?
- Can LAUSD identify areas needing **program expansion** or **policy clarification**?

---

## 📢 Potential Recommendations for LAUSD

- Expand seat capacity or locations for **high-demand DL programs**.
- Clarify **eligibility and prioritization policies** for DL vs. non-DL applicants.
- Investigate schools or ZIPs with persistent **disparities** in DL acceptance.
- Ensure **bilingual/multicultural access equity** across communities.

---

## 📂 Dataset Used

**Name:** Applications and Seat Offers by Applicant Dual Language Status (2018–2019)  
**Source:** LAUSD Open Data Portal  
**Format:** CSV

This dataset includes:
- Applicant program and school information
- ZIP code and community of school
- Whether the student was a Dual Language applicant
- Total applications and seat offers

---

## 🧰 Tools Used

- **Excel** – Data cleaning and selection  
- **PostgreSQL** – Analysis-ready querying  
- **pgAdmin** – Query interface

---

## 🔍 Step-by-Step Data Preparation

### Step 1: Understanding the Columns

We selected the following relevant columns:
- `program_name` – Name of the applied program  
- `school` – Name of the school applied to  
- `school_type` – Type of school (e.g., DUAL LANGUAGE, MAGNET, ELEMENTARY)  
- `community_of_schools` – Community or region the school belongs to  
- `zip_code` – Location-based analysis  
- `dual_language` – Indicates whether applicant is in the Dual Language track (`Yes` or `No`)  
- `applications` – Number of applications from this group  
- `seat_offers` – Number of offers extended to this group

### Step 2: Cleaning in Excel

- Removed unnecessary columns (cost center codes, IDs)
- Renamed all headers to lowercase `snake_case` format
- Replaced missing zip codes with `NULL` where needed  
- Dropped rows with missing or irrelevant `program_name`
- Ensured data types were correct (zip as string, offers/applications as integer)

---

✅ Ready for analysis. Next: Step-by-step queries to explore admission disparities for Dual Language applicants.
