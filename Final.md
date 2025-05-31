# Problem Statement 2: Do Dual Language Program Applicants Face Disparities in Admissions Compared to General Applicants?

## Key Insights for LAUSD Decision-Makers
- Dual Language applicants have a lower overall acceptance rate (~14.58%) than general applicants (~20.06%)
- Some schools and ZIP codes show **zero seat offers** to Dual applicants despite having 10+ applications
- Specific school types and communities show systemic gaps in acceptance rates
- Several schools have 25%+ acceptance rate difference favoring general applicants

## Recommendations:
- Expand Dual Language seats in high-demand schools and ZIP codes
- Investigate exclusion patterns in schools with 0% Dual offers
- Standardize equitable selection across all school types
- Support community-level outreach in low-acceptance-rate regions

## Dataset Used
**Name:** Applications and Seat Offers by Applicant Dual Language Status 2018–2019  
**Source:** LAUSD Open Data Portal  
**Format:** CSV

## Tools Used
- Microsoft Excel
- PostgreSQL
- pgAdmin

## Step-by-Step Data Preparation:

### Step 1: Understanding the Columns
Columns retained:
- program_name
- school
- school_type
- community_of_schools
- zip_code
- dual_language
- applications
- seat_offers

### Step 2: Cleaning in Excel
- Renamed to snake_case
- Removed unnecessary columns
- Replaced missing ZIPs with NULL
- Dropped rows with missing program names
- Validated data types

### Step 3: Importing to PostgreSQL
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
Imported using pgAdmin import tool.

---

## SQL Queries & Insights:

### Query 1:
**Purpose:** Understand the scale of Dual Language program interest compared to General applicants.  
**Insight:**  
Dual Language: 13,654 applications  
General: 186,034 applications  
→ Dual applicants make up ~6.8% of total.

---

### Query 2:
**Purpose:** See if Dual applicants receive proportionate offers.  
**Insight:**  
Dual Language: 1,993 seat offers  
General: 37,311 seat offers  
→ Dual applicants received ~5% of total offers — less than their 6.8% application share.

---

### Query 3:
**Purpose:** Identify whether Dual Language applicants are less likely to receive offers.  
**Insight:**  
Acceptance Rate:  
Dual: 14.58%  
General: 20.06%  
→ General applicants are ~37% more likely to receive an offer.

---

### Query 4:
**Purpose:** Spot regional ZIP-level disparities in outcomes for both groups.  
**Insight:**  
ZIP 91331: Dual Rate = 8.33%, General Rate = 14.8%  
ZIP 90022: Dual = 0%, General = 18%  
→ Multiple ZIPs show significant bias.

---

### Query 5:
**Purpose:** Identify schools with large success rate gaps between the two applicant types.  
**Insight:**  
Several schools have 0% acceptance for Dual while showing 40%+ for General.

---

### Query 6:
**Purpose:** Discover which schools/programs are most in demand among Dual applicants.  
**Insight:**  
Top schools by Dual application volume:  
- SCHOOL A: 214 apps  
- SCHOOL B: 173 apps  
- SCHOOL C: 145 apps  
→ High-demand schools may need capacity expansion.

---

### Query 7:
**Purpose:** Understand if school types show bias in Dual vs General acceptance.  
**Insight:**  
Acceptance Rate by Type:  
- Magnet: Dual 10%, General 18%  
- Elementary: Dual 17%, General 21%  
→ Gaps exist in all school types.

---

### Query 8:
**Purpose:** Explore whether disparities are tied to specific regional communities.  
**Insight:**  
Communities like DOWNTOWN COS and NORTH COS show 0% offers for Dual applicants in some schools.

---

### Query 9:
**Purpose:** Detect potential exclusion patterns where one group receives no offers.  
**Insight:**  
19 schools had offers only for General applicants despite Dual applications ≥10.

---

### Query 10:
**Purpose:** Quantify the magnitude of disparity to highlight where interventions are needed most.  
**Insight:**  
School A: General Rate = 32.14%, Dual Rate = 0% → -32.14% gap  
School B: General = 22.73%, Dual = 0% → -22.73%  
→ Major red flags for equity review.

---

## ✅ Final Summary

This analysis confirms that Dual Language applicants face systemic barriers in LAUSD admissions.  
While demand exists, success rates are consistently lower — especially in high-demand schools, ZIPs, and communities. Immediate attention is needed to address structural biases and ensure equity in access to educational programs.
