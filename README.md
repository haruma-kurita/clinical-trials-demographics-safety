# Clinical Trials Data Pipeline: Demographics & Safety Snapshot

## 📌 Overview
This repository demonstrates a foundational clinical trials programming workflow using SAS. The project ingests open-source, CDISC-compliant Analysis Data Model (ADaM) datasets to build a baseline demographic report and evaluate safety endpoints by calculating the relative risk of adverse events.

This portfolio highlights proficiency in clinical data manipulation, dataset merging (`BY` variables), categorical data analysis (`PROC FREQ`), and structural reporting (`PROC TABULATE`). These skills are critical for maintaining data traceability and building automated, reproducible analysis pipelines.

## 🗂️ Repository Structure
- 📁 **`data/`** : Contains instructions for sourcing the raw SAS Transport files (`.xpt`) from the PHUSE Test Data Factory (ADSL and ADAE datasets).
- 📁 **`programs/`** : Contains sequentially numbered SAS scripts for data unpacking, analytical cohort filtering, and statistical analysis.
- 📁 **`outputs/`** : Contains the final reviewer-ready demographic tables exported via the SAS Output Delivery System (ODS).

## 📊 Data Source & Architecture
The datasets are sourced from the open-source **CDISC Pilot Project** via the [PHUSE Test Data Factory](https://github.com/phuse-org/TestDataFactory).
- **ADSL (Analysis Data Subject Level):** A master patient roster containing one row per subject with baseline characteristics (Age, Sex, Race) and treatment group assignments.
- **ADAE (Analysis Data Adverse Events):** An incident log containing multiple rows per subject tracking post-treatment signs, symptoms, and diagnoses.

## 🛠️ Methodology & SAS Pipelines
1. **Transport Unpacking:** Utilized the `XPORT` engine and `PROC COPY` to unpack standard FDA-compliant `.xpt` files into functional SAS datasets (`.sas7bdat`).
2. **Clinical Reporting:** Developed a standardized baseline demographic summary ("Table 1") using `PROC TABULATE`. The script calculates cross-tabular descriptive statistics (N, Mean, StdDev, Min, Max) across randomized treatment arms.
3. **Safety Analysis (Relative Risk):** 
   - Cleaned the `ADAE` dataset using `PROC SORT` with the `NODUPKEY` option to isolate subjects experiencing Nausea.
   - Merged the master roster (`ADSL`) and event logs (`ADAE`) to derive a binary outcome flag (`Had_Nausea`).
   - Filtered the active cohort to isolate the active treatment arm versus control (`Xanomeline High Dose` vs. `Placebo`).
   - Executed `PROC FREQ` with the `/ relrisk` option to evaluate treatment-emergent event likelihood.

## 📈 Key Findings & Deliverables
### 1. Baseline Demographics (Table 1)
The clinical demographic table was successfully exported to a reviewer-ready format. It provides structural proof of randomization balance across treatment arms for baseline factors.
* **File Link:** `outputs/Table1_Demographics.pdf`

### 2. Relative Risk Statistics for Nausea
The automated categorical execution yielded the following exact measures comparing the active drug group to the placebo group:
* **Odds Ratio:** `2.12`
* **Relative Risk (Inverted):** `2.08`

**Conclusion:** Patients randomized to the *Xanomeline High Dose* arm were **2.08 times more likely** to experience nausea during the trial compared to those in the *Placebo* arm. The corresponding Odds Ratio of 2.12 mathematically reinforces this elevated safety risk, proving a statistically meaningful increase in treatment-emergent side effects.

## 👨‍💻 About the Author
I am a Master of Biostatistics student at Duke University (Expected 2027) with a deep interest in statistical programming, automated pipeline engineering, and clinical data standards. I bring a strong scientific foundation to data science, having previously spent two years working as a Biologist II at AbbVie. I hold the SAS Certified Specialist: Base Programming credential and am actively preparing for the Advanced Programming and Clinical Trials Programmer certifications.
