# Script 5: Linear Regression with Interaction Model
# Purpose: Test whether Stemness and Gleason interact to affect AR-A expression
# Input file: Script_5_Example_data_Regression_Interaction.csv
# Output: Regression model summary + interaction plot (PNG)
# Required R version: ≥ 4.3.3
# Required packages: readr (≥ 2.1.4), base R graphics

### 2025-06-07 | Xiaozhuo Liu | Publication version ###

# Clear environment
rm(list = ls())

# Load required package
library(readr)  # for read_csv


# Set working directory (optional; use relative path to ensure portability)
# setwd("./Scripts")  # Uncomment and modify as needed


# Load input data
# The CSV should contain columns: AR_A, Stemness, Gleason
data <- read_csv("Script_5_Example_data_Regression_Interaction.csv")

# Fit linear regression model with interaction term
# Formula: AR_A ~ Stemness + Gleason + Stemness:Gleason
model <- lm(AR_A ~ Stemness * Gleason, data = data)

# Print model summary to console
summary(model)

# Save interaction plot
png("Script_5_Output_Example_data_interaction_plot.png", width = 3000, height = 2500, res = 300)

# Plot interaction (base R)
interaction.plot(data$Stemness, data$Gleason, data$AR_A,
                 type = "b",
                 col = 1:4, pch = 18:21,
                 xlab = "Stemness",
                 ylab = "AR-A",
                 main = "Interaction Plot")

dev.off()