# Stemness Analysis Scripts for Prostate Cancer Transcriptomic Data

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15620990.svg)](https://doi.org/10.5281/zenodo.15620990)

**Author:** Xiaozhuo Liu, Ph.D.  
**Institution:** Roswell Park Comprehensive Cancer Center  
**Contact:** Xiaozhuo.Liu@roswellpark.org  
**Date:** June 6, 2025


This repository includes 5 modular R scripts used to analyze prostate cancer stemness from transcriptomic datasets. These scripts support mRNAsi index computation, ssGSEA-based PCa-Stem signature scoring, trend testing, Cox regression modeling, and interaction-based linear regression.

---

## Script Overview

| Script No. | Name                                               | Functionality                                                               |
|------------|----------------------------------------------------|-----------------------------------------------------------------------------|
| 1          | `Script_1_Stemness_Quantification.R`               | Computes mRNAsi stemness scores per Malta et al., with optional boxplot     |
| 2          | `Script_2_PCa-Stem signature_GSVA.R`               | Calculates PCa-Stem enrichment via ssGSEA using GSVA                        |
| 3          | `Script_3_J-T trend testing.R`                     | Performs Jonckheere–Terpstra trend test across ordered groups               |
| 4          | `Script_4_Multivariable Cox Regression Modeling.R` | Cox regression with clinical and molecular features                         |
| 5          | `Script_5_Regression Model.R`                      | Linear regression testing for interaction effect (e.g., Stemness × Gleason) |

---

## File Structure
```
ProstateCancer-Stemness-Scripts/
│
├── Script_1_Stemness_Index.R
├── Script_2_PCa-Stem_Signature_ssGSEA.R
├── Script_3_JT_Trend_Test.R
├── Script_4_Cox_Model.R
├── Script_5_Regression_Interaction.R
│
├── Inputs_Example_Data/
│ ├── Script_1_Example_data_Stemness.csv
│ ├── Script_1_Stemness_Weight_Vector_ENSGver.xlsx
│ ├── Script_1_Example_Meta-Group-Information_Stemness.xlsx
│ ├── Script_2_Example_data_PCa-Stem-Signature.csv
│ ├── Script_2_Example_Meta-Group-Information_PCa-Stem-Signature.xlsx
│ ├── Script_3_Example_data_JT_test.csv
│ ├── Script_4_Example_data_Cox_model.csv
│ └── Script_5_Example_data_Regression_Interaction.csv
│
├── Outputs/
│ ├── Script_1_Output_Stemness_Index_Scores_ensg_with_version.csv
│ ├── Script_1_Output_Stemness_Boxplot.pdf
│ ├── Script_2_Output_PCa_Stem_ssGSEA_scores.csv
│ ├── Script_2_Output_PCa_Stem_Score_Grouped_Boxplot.pdf
│ ├── Script_4_Test_Output_Multivariate_analysis_signature_score.pdf
│ └── Script_5_Output_Example_data_interaction_plot.png
│
├── README.md
├── dependencies.txt
└── Code_Functionality_Overview_GitHub.docx
```
---

## System Requirements

- **R version:** ≥ 4.3.3  
- **Operating System:** macOS 15.5, Linux, or compatible environment

---

## Dependencies

See `dependencies.txt` for full list of required packages and versions.
