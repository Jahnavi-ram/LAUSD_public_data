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

### 🛠️ Step 3: Importing to PostgreSQL

We created the following table in PostgreSQL to store the cleaned Dual Language admissions dataset:

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
### Query 1: Total Applications – Dual vs Non-Dual

**Purpose:**
Understand the scale of Dual Language program interest compared to General applicants.

**SQL:**

```sql
SELECT
  dual_language,
  SUM(applications) AS total_applications
FROM
  public.dual_language_applications
GROUP BY
  dual_language;
```

---
**Output:**

| dual\_language | total\_applications |
| -------------- | ------------------- |
| No             | 150,439             |
| Yes            | 10,973              |

**🧠 Insight:**
Only **6.8% of total applications** were to Dual Language programs, while over **93% were to General programs**. This suggests that while demand for Dual Language programs exists, it remains a niche offering. LAUSD may want to investigate whether the limited uptake is due to **availability**, **awareness**, or **barriers to access** — especially if equity is a concern.

### 🧪 Query 2: Total Seat Offers – Dual vs Non-Dual

**Purpose:** See if Dual Language applicants receive proportionate offers compared to general program applicants.

```sql
SELECT
  dual_language,
  SUM(seat_offers) AS total_seat_offers
FROM
  public.dual_language_applications
GROUP BY
  dual_language;
```

**Output:**

| dual\_language | total\_seat\_offers |
| -------------- | ------------------- |
| No             | 30185               |
| Yes            | 1600                |

**Insight:**

* Dual Language applicants received **1,600** seat offers.
* Non-Dual applicants received **30,185** seat offers.
* While Dual Language applicants made up **\~6.8%** of total applications (from Query 1), they received only **\~5%** of total offers.

This suggests a potential **underservice or bottleneck** in Dual Language program placements. LAUSD may need to review whether available seats in such programs meet demand, and whether placement policies unintentionally limit access for Dual Language applicants.

### Query 3: Acceptance Rate – Dual vs Non-Dual

**Purpose:** Identify whether Dual Language applicants are less likely to receive offers.

**SQL:**

```sql
SELECT
  dual_language,
  SUM(seat_offers) AS total_offers,
  SUM(applications) AS total_applications,
  ROUND(
    (SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications), 0)) * 100,
    2
  ) AS acceptance_rate_percent
FROM
  public.dual_language_applications
GROUP BY
  dual_language;
```

**Output Summary:**

| Dual Language | Total Offers | Total Applications | Acceptance Rate (%) |
| ------------- | ------------ | ------------------ | ------------------- |
| No            | 30,185       | 150,439            | 20.06               |
| Yes           | 1,600        | 10,973             | 14.58               |

**Insight:**
Dual Language applicants have a lower acceptance rate (**14.58%**) compared to general applicants (**20.06%**). This suggests that Dual Language students may be at a disadvantage in the admissions process and merit closer examination by LAUSD to determine if program availability or policy gaps are contributing factors.

**Equity Recommendation:**
LAUSD should investigate:

* Whether sufficient seats are allocated to Dual Language programs.
* If demand outpaces supply in specific regions or language tracks.
* Policy mechanisms ensuring fair access to bilingual opportunities.

### Query 4: Acceptance Rate by ZIP – Dual vs Non-Dual

**Purpose:** Spot regional ZIP-level disparities in admission outcomes between Dual Language and Non-Dual applicants.

---

**SQL:**

```sql
SELECT
  zip_code,
  SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END) AS dual_apps,
  SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END) AS dual_offers,
  ROUND((SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END)::DECIMAL / NULLIF(SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END), 0)) * 100, 2) AS dual_acceptance_rate,
  SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END) AS non_dual_apps,
  SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END) AS non_dual_offers,
  ROUND((SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END)::DECIMAL / NULLIF(SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END), 0)) * 100, 2) AS non_dual_acceptance_rate
FROM (
  SELECT
    zip_code, dual_language, applications, seat_offers
  FROM public.dual_language_applications
  WHERE zip_code IS NOT NULL
) AS summarized
GROUP BY zip_code
HAVING (
  MAX(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END) >= 10 OR
  MAX(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END) >= 10
)
ORDER BY dual_acceptance_rate ASC NULLS LAST;
```

---

**Insight:**

This query highlights clear ZIP-level disparities in seat offer rates:

* **ZIP 90810:** Dual applicants had **0% acceptance** (0 of 32), while Non-Duals had **17.16%** (35 of 204).
* **ZIP 90063:** Dual applicants had **1.2%** success, while Non-Duals had **23.73%**.
* **ZIP 90018:** Duals = 2.86%, Non-Duals = 24.27%.
* Several ZIPs (like **90017**, **91356**, **91303**) show **0% offers for Duals** despite strong participation from both groups.

These ZIP-level patterns provide critical signals for LAUSD to:

* Audit the **geographic reach and fairness** of Dual Language seat allocation.
* Reassess **program capacity** in underserved ZIPs.
* Address the **acceptance gap** and evaluate if Dual program access is regionally imbalanced.

This granular ZIP analysis strengthens the case for a **data-driven equity review** of program availability.


### ✳️ Query 5: Acceptance Rate by School – Dual vs Non-Dual

**Purpose:**  
Identify schools where Dual Language applicants experience significantly different acceptance rates compared to their General applicant peers. This can help LAUSD flag schools where selection processes may be unintentionally skewed.

**SQL:**
```sql
SELECT
    school,
    SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END) AS dual_apps,
    SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END) AS dual_offers,
    ROUND(
        SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END)::DECIMAL
        / NULLIF(SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END), 0) * 100, 2
    ) AS dual_acceptance_rate,
    SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END) AS non_dual_apps,
    SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END) AS non_dual_offers,
    ROUND(
        SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END)::DECIMAL
        / NULLIF(SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END), 0) * 100, 2
    ) AS non_dual_acceptance_rate
FROM public.dual_language_applications
GROUP BY school
HAVING 
    SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END) >= 10
    AND SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END) >= 10
ORDER BY ABS(
    ROUND(SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END)::DECIMAL / NULLIF(SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END), 0) * 100, 2)
    -
    ROUND(SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END)::DECIMAL / NULLIF(SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END), 0) * 100, 2)
) DESC;
```

**Insight:**  
Some schools display substantial differences in success rates:

- 🎯 **Betty Plasencia Elementary** offered admission to **69.23% of Dual applicants** vs only **22.41% of General applicants**.
- 🛑 **James Monroe Senior High** accepted **0% of Dual applicants**, despite processing **13 applications**.
- ⚠️ **San Fernando Senior High** and **Nathaniel Narbonne Senior High** also had **0% Dual Language acceptance** despite receiving 11+ applications each.
- 🟢 Conversely, **Elysian Heights Elementary Arts Magnet** showed a **more balanced outcome**, with **31.58% Dual vs 60.24% Non-Dual** acceptance.

These gaps may point to:
- Capacity limitations in Dual tracks
- Manual prioritization
- Policy or awareness issues that need review



### 🧪 Query 6: Top Schools by Dual Language Application Volume

**Purpose:**  
Discover which schools or programs are most in demand among Dual Language applicants.

**SQL:**
```sql
SELECT 
  school,
  SUM(applications) AS dual_language_applications
FROM 
  public.dual_language_applications
WHERE 
  dual_language = 'Yes'
GROUP BY 
  school
ORDER BY 
  dual_language_applications DESC
LIMIT 15;
```

**Insight:**  
- 🏫 **John Burroughs Middle School** had the highest Dual Language interest with **349 applications**.
- 🏫 **3rd Street Elementary** and **Broadway Elementary DL Two-Way Im Spanish** followed with **241** and **227** applications respectively.
- This demand distribution highlights potential flagship campuses and could guide future program expansion, marketing, or resource allocation.


### 🧪 Query 7: Application and Offer Breakdown by School Type

**Purpose:**  
Understand if certain school types (e.g., Magnet, Elementary, Dual Language) show differences in acceptance rates between Dual Language and General applicants.

**SQL:**
```sql
SELECT 
  school_type,
  dual_language,
  SUM(applications) AS total_applications,
  SUM(seat_offers) AS total_offers,
  ROUND(
    (SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications), 0)) * 100, 2
  ) AS acceptance_rate_percent
FROM public.dual_language_applications
WHERE school_type IS NOT NULL AND dual_language IS NOT NULL
GROUP BY school_type, dual_language
ORDER BY school_type, dual_language;
```

**Insight:**  
- In **Magnet Center - Elementary** schools, Dual Language applicants had a **higher acceptance rate (26.21%)** than non-dual applicants (22.25%).  
- In **DUAL LANGUAGE (DLC) - ELEM** schools, both groups had lower success, but Dual Language applicants still slightly outperformed: **13.08% vs 11.42%**.  
- However, in **Elementary Schools**, both Dual and Non-Dual applicants experienced **low acceptance rates**, under **7.2%**.  
- **Self-Contained Magnet** schools also showed slightly better acceptance for Dual Language applicants (**15.10%**) than general (**15.09%**), suggesting no bias.  

This reveals that some school types (especially Magnet) may be more inclusive or better structured for Dual Language placement, while others may need policy or capacity review.


### Query 8: Acceptance Rate by Community of Schools

**Purpose:**  
Explore whether disparities in seat offer outcomes are tied to specific regional communities of schools across LAUSD.

**SQL Code:**
```sql
SELECT 
  community_of_schools,
  dual_language,
  SUM(applications) AS total_applications,
  SUM(seat_offers) AS total_offers,
  ROUND(
    (SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications), 0)) * 100, 2
  ) AS acceptance_rate_percent
FROM 
  public.dual_language_applications
WHERE 
  community_of_schools IS NOT NULL AND dual_language IS NOT NULL
GROUP BY 
  community_of_schools, dual_language
ORDER BY 
  community_of_schools, dual_language;
```

**Insight:**  
The data shows meaningful regional differences:
- In **BOYLE HEIGHTS COS**, Non-Dual applicants had an acceptance rate of **36.69%**, while Dual Language applicants only received **22.75%**.
- In **BELL/CUDHY/MAYWD COS**, the gap is even wider — **16.81%** for Non-Dual vs only **6.4%** for Dual Language applicants.
- Conversely, **ACHIEVEMENT NETWORK** shows more balanced outcomes with **28.99%** (Non-Dual) and **20.93%** (Dual Language).

This suggests that certain communities may have systemic disparities in dual language seat offer outcomes — a point worth further investigation by LAUSD.
