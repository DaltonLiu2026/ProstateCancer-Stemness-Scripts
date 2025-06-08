# Script 4: Multivariable Cox Regression Modeling
# Purpose: Perform multivariable Cox proportional hazards regression on progression-free survival (PFS)
# Input file: Script_4_Example_data_Cox_model.csv
# Output: Cox model summary (printed to console)
# Required R version: ≥ 4.3.3
# Required packages: survival (≥ 3.5-8), survminer (≥ 0.4.9)

### 2025-06-07 | Xiaozhuo Liu | Publication version ###

# Clear environment
rm(list = ls())

# Load required packages
library(survival)   # for coxph()
library(survminer)  # for Surv() support and visualization


# Load survival data
# The CSV should contain the following columns:
# PFS_time, PFS_event (0/1), Age (numeric), Gleason_score (numeric), Pathologic_stage (T stage), SignatureScore_status (binary or categorical)
data <- read.csv("Script_4_Example_data_Cox_model.csv", stringsAsFactors = FALSE)


# Convert relevant columns to numeric if needed
data$Age <- as.numeric(data$Age)
data$Gleason_score <- as.numeric(data$Gleason_score)
data$PFS_time <- as.numeric(data$PFS_time)
data$PFS_event <- as.numeric(data$PFS_event)

# Format clinical variables for categorical Cox model
# These transformations simplify groups for interpretation
data$Pathologic_stage <- ifelse(grepl("^T2", data$Pathologic_stage), "T2", "T3/4")
data$Gleason_score <- ifelse(data$Gleason_score < 8, "< 8", ">= 8")
data$Age <- ifelse(data$Age > median(data$Age, na.rm = TRUE), "> 61 yrs (median)", "<= 61 yrs (median)")


# Exclude samples with non-informative values (example below showing Exclude samples with missing pathologic stage information)
data <- subset(data, Pathologic_stage != "no_data")


# Convert to factor (recommended for categorical Cox variables)
data$Pathologic_stage <- factor(data$Pathologic_stage, levels = c("T2", "T3/4"))
data$Gleason_score <- factor(data$Gleason_score, levels = c("< 8", ">= 8"))
data$Age <- factor(data$Age, levels = c("<= 61 yrs (median)", "> 61 yrs (median)"))
data$SignatureScore_status <- factor(data$SignatureScore_status, levels = c("Low", "High"))

# Remove rows with NA in required variables
data <- data[complete.cases(data[, c("PFS_time", "PFS_event", "Age", "Gleason_score", "Pathologic_stage", "SignatureScore_status")]), ]

# Build multivariable Cox model
# Outcome: PFS_time and PFS_event
# Predictors: Age, Gleason_score, Pathologic_stage, SignatureScore_status
cox_model <- coxph(Surv(PFS_time, PFS_event) ~ Age + Gleason_score + Pathologic_stage + SignatureScore_status, data = data)

# Output summary
summary(cox_model)


# Generate and export forest plot
mulCox_plot <- ggforest(cox_model, data = data,
                        main = 'Hazard ratio',
                        cpositions = c(0, 0.2, 0.38),
                        fontsize = 0.8,
                        refLabel = '1',
                        noDigits = 3)

pdf(file = "Script_4_Test_Output_Multivariate_analysis_signature_score.pdf", width = 8, height = 6)
print(mulCox_plot, newpage = FALSE)
dev.off()