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
