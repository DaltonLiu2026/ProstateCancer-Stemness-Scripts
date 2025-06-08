# Script 1: Stemness Quantification (mRNAsi method adapted from Malta et al., Cell 2018)
# Purpose: Compute stemness scores for each sample using the mRNAsi method (Malta et al., Cell 2018)
# Input: Expression matrix (rows = genes in Ensembl IDs with version, columns = samples)
# Output: Raw and normalized stemness scores per sample + optional boxplot visualization
# Output: CSV file of stemness scores + optional boxplot visualization
# Optional: Provide a metadata file to generate grouped boxplots
# Author: Xiaozhuo Liu
# Version: 2025-06-07
# Required R version: ≥ 4.3.3
# Required packages: tidyverse, readxl, ggplot2

### 2025-06-07 | Xiaozhuo Liu | Publication Version ###

# -------------------- Setup --------------------
rm(list = ls())

library(tidyverse)  # for data manipulation
library(readxl)     # for reading the stemness weight file and metadata
library(ggplot2)    # for boxplot


# -------------------- User Options --------------------
# 1. Gene ID format used in expression matrix
gene_id_format <- "ensg_with_version"  # Only this mode is supported in current version
if (gene_id_format != "ensg_with_version") {
  stop("Only 'ensg_with_version' is supported in this version of the script.")
}

# 2. Input files
expr_file <- "Script_1_Example_data_Stemness.csv"
weight_file <- "Script_1_Stemness_Weight_Vector_ENSGver.xlsx"
meta_file  <- "Script_1_Example_Meta-Group-Information_Stemness.xlsx"

# 3. Output file
output_file     <- "Script_1_Output_Stemness_Index_Scores_ensg_with_version.csv"
output_plot     <- "Script_1_Output_Stemness_Boxplot.pdf"

enable_group_plot <- TRUE  # Toggle for boxplot


# -------------------- Load Stemness Weight File --------------------
# The stemness weight file contains: ENSG with version, ENSG (no version), weight, and gene symbol
# Use Ensembl ID with version (col 1) and weight (col 3)

weights_df <- read_excel(weight_file, col_names = FALSE)
colnames(weights_df) <- c("ENSGver", "ENSG", "Weight", "Symbol")

# Convert to named vector: names = ENSG_ID, values = weights
stem_weights <- setNames(weights_df$Weight, weights_df$ENSGver)


# -------------------- Load Expression Matrix --------------------
# Expect gene IDs (with version) in column 1, sample IDs as column names
expr <- read_csv(expr_file)
expr_df <- as.data.frame(expr)
colnames(expr_df)[1] <- "GeneID"

# Remove duplicated gene rows
expr_df <- expr_df[!duplicated(expr_df$GeneID), ]
rownames(expr_df) <- expr_df$GeneID
expr_df$GeneID <- NULL


# ---------------- Convert to Matrix and Log2 Transform (optional) --------------------
# Convert cleaned dataframe to matrix
expr_mat <- as.matrix(expr_df)

# If your input is *not* already log2-transformed, uncomment the line below:
expr_mat <- log2(expr_mat + 1)


# -------------------- Match to Stemness Signature --------------------
common_genes <- intersect(rownames(expr_mat), names(stem_weights))
if (length(common_genes) < 10000) {
  message("⚠️ Warning: Fewer than 10,000 overlapping genes detected. Stemness quantification may be affected.")
}

expr_mat <- expr_mat[common_genes, ]
stem_weights_filtered <- stem_weights[common_genes]

cat("Total genes in signature:", length(stem_weights_filtered), "\n")
cat("Total samples:", ncol(expr_mat), "\n")


# -------------------- Compute Spearman Correlation --------------------
stemness_scores_raw <- apply(expr_mat, 2, function(x) cor(x, stem_weights_filtered, method = "spearman", use = "complete.obs"))


# -------------------- Normalize (Malta et al., Cell 2018) --------------------
stemness_scores_normalized <- (stemness_scores_raw + 0.2619) / 0.4151

# -------------------- Save Output --------------------
out_df <- data.frame(Sample = names(stemness_scores_normalized),
                     Raw_Stemness = stemness_scores_raw,
                     Normalized_Stemness = stemness_scores_normalized)

write.csv(out_df, output_file, row.names = FALSE)
cat("Stemness index computation complete.\n")
cat("Output saved to:", output_file, "\n")


# -------------------- Optional: Boxplot by Group --------------------
if (enable_group_plot) {
  cat("Generating boxplot using group info from:", meta_file, "\n")
  
  meta <- read_excel(meta_file)
  colnames(meta)[1:2] <- c("Sample", "Status")
  
  merged <- merge(out_df, meta, by = "Sample")
  merged$Status <- factor(merged$Status, levels = c("NORMAL", "Pri-PCa", "CRPC"))
  
  p <- ggplot(merged, aes(x = Status, y = Normalized_Stemness, fill = Status)) +
    geom_boxplot(alpha = 0.7, outlier.shape = NA) +
    geom_jitter(width = 0.2, size = 1.5, alpha = 0.5) +
    labs(title = "Stemness Index (mRNAsi) by Group",
         y = "Normalized Stemness Score", x = "") +
    theme_minimal(base_size = 12) +
    theme(legend.position = "none")
  
  ggsave(output_plot, plot = p, width = 6, height = 5)
  cat("Boxplot saved to:", output_plot, "\n")
}