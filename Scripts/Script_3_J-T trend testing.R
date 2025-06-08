### Script 3: Jonckheere–Terpstra Trend Testing (Updated: 2025-06-06)
# Author: Xiaozhuo Liu
# Dataset: Script_3_Example_data_JT_test.csv
# Description: This script performs Jonckheere–Terpstra trend testing to detect monotonic trends across ordered groups.
# It also generates a boxplot for visualization.
# R version: 4.3.3 (2024-02-29)
# DescTools version: ≥ 0.99.60


# Clear environment
rm(list = ls())

# Optional: set working directory for reproducibility
# setwd("./Scripts")  # Uncomment and set path if running in specific folder

# Load required package
library(DescTools)

## ---- Trend Test: Simplified Version ----

# Load trend test data
df <- read.csv("Script_3_Example_data_JT_test.csv")

# Flatten into long format
x <- unlist(df)
group <- rep(colnames(df), each=nrow(df))
group <- ordered(group, levels=colnames(df))

# Run Jonckheere–Terpstra test
res <- JonckheereTerpstraTest(x, group)
print(res)


## ---- Trend Test with Visualization ----

# Reload data for boxplot section (ensures clean structure)
df_0 <- read.csv(file = "Script_3_Example_data_JT_test.csv", stringsAsFactors = FALSE)

# Prepare long-form data
x <- c() 
group <- c()
vars <- colnames(df_0)

for (i in 1:ncol(df_0)) {
  x_tmp <- df_0[,i]
  x_tmp <- x_tmp[!is.na(x_tmp)]
  x <- c(x, x_tmp)
  group <- c(group, rep(vars[i], length(x_tmp)))
}

group <- ordered(group, levels = vars)
df_1 <- data.frame(x, group)

# Run test again (optional, same result)
JonckheereTerpstraTest(df_1$x, df_1$group) 

# Visualize: boxplot
boxplot(x ~ group, df_1,
        main = "Jonckheere–Terpstra Trend Visualization",
        xlab = "Ordered Groups",
        ylab = "Expression / Score",
        col = "lightblue",
        border = "gray40")