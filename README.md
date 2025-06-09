# Stemness Analysis Scripts for Prostate Cancer Transcriptomic Data

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15620990.svg)](https://doi.org/10.5281/zenodo.15620990)

**Author:** Xiaozhuo Liu, Ph.D.  
**Institution:** Roswell Park Comprehensive Cancer Center  
**Contact:** Xiaozhuo.Liu@roswellpark.org  
**Date:** June 6, 2025


**Contributors:** 
	- Eduardo Cortes (Bioinformatics consultation) 
	- Han Yu  (Survival model validation and feedback) 
	- Qiang Hu (Conceptual framework and project supervision)
	- Zou Cheng  (Survival model validation and feedback) 
	- Dingxiao Zhang  (Survival model validation and feedback) 
	- Song Liu (Conceptual framework and project supervision)
	- Jianmin Wang  (Conceptual framework and project supervision)
	- Dean G. Tang (Conceptual framework and project supervision)
 
![image](https://github.com/user-attachments/assets/ddf5350c-19de-49a2-ab4a-d4d73e2d46d7)

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
├── Script_2_PCa-Stem_Signature_GSVA.R
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

---

## How to Cite

If you use these scripts or reproduce the analyses in your work, please cite both the Zenodo-archived scripts and our associated research manuscript:

### 1. Scripts Archive (Zenodo)
Liu, X. (2025). *Prostate Cancer Stemness Analysis Scripts* (Version v1.0.1). Zenodo. https://doi.org/10.5281/zenodo.15620990

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15620990.svg)](https://doi.org/10.5281/zenodo.15620990)

**BibTeX:**
```bibtex
@software{liu2025stemness,
  author       = {Xiaozhuo Liu},
  title        = {Prostate Cancer Stemness Analysis Scripts},
  year         = {2025},
  publisher    = {Zenodo},
  version      = {v1.0.1},
  doi          = {10.5281/zenodo.15620990},
  url          = {https://doi.org/10.5281/zenodo.15620990}
}
```
---

### 2. Research Article (bioRxiv)
Liu, X., Cortes, E., Ji, Y., Zhao, K., Ho, J., Liu, Y., ... & Tang, D. G. (2025). Increasing Stemness Drives Prostate Cancer Progression, Plasticity, Therapy Resistance and Poor Patient Survival. bioRxiv. https://doi.org/10.1101/2025.04.27.650697

**BibTeX:**
```bibtex
@article{liu2025increasing,
  author       = {Liu, Xiaozhuo and Cortes, Eduardo and Ji, Yibing and Liu, Song and Wang, Jianmin and Tang, Dean G.},
  title        = {Increasing Stemness Drives Prostate Cancer Progression, Plasticity, Therapy Resistance and Poor Patient Survival},
  journal      = {bioRxiv},
  year         = {2025},
  doi          = {10.1101/2025.04.27.650697},
  url          = {https://doi.org/10.1101/2025.04.27.650697}
}
```
---

## Acknowledgments
The mRNAsi stemness index implementation in this repository is adapted from the original methodology published by Malta et al., *Cell* 2018. We thank Drs. Tathiane Malta and Houtan Noushmehr for generously sharing their source code and responding to technical questions.  
- Malta et al., *Cell* (2018): https://doi.org/10.1016/j.cell.2018.03.034.
![image](https://github.com/user-attachments/assets/d8eb64b5-4536-4768-878a-314fe15a7802)
