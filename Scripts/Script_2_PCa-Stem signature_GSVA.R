# Script 2: PCa-Stem Signature Enrichment using ssGSEA
# Purpose: Compute ssGSEA scores for the PCa-Stem 12-gene signature
# Input: Expression matrix (rows = genes, columns = samples); metadata file including grouping information (Optional for visulization)
# Output: CSV file of ssGSEA scores + optional boxplot visualization
# Optional: Provide a metadata file to generate grouped boxplots
# Author: Xiaozhuo Liu
# Version: 2025-06-08
# Required R version: ≥ 4.3.3
# Required packages: GSVA (≥ 1.50.5), ggplot2, readr, readxl

### 2025-06-07 | Xiaozhuo Liu | Publication Version ###

# -------------------- Setup --------------------
# Clear environment
rm(list = ls())

# Load required package
library(GSVA)  # for ssGSEA computation
library(ggplot2)
library(readr)
library(readxl)

# Optional: set working directory for reproducibility
# setwd("./Scripts")  # Uncomment and set path if running in specific folder

# -------------------- User Options --------------------
# 1. Choose gene ID type used in your expression matrix:
gene_id_format <- "ensg_with_version"  # Options: "gene_symbol", "ensg", "ensg_with_version"

# 2. Enable or disable group-based visualization
enable_group_plot <- TRUE

# 3. File paths
expr_file <- "Script_2_Example_data_PCa-Stem-Signature.csv"
meta_file <- "Script_2_Example_Meta-Group-Information_PCa-Stem-Signature.xlsx"
output_score_file <- "Script_2_Output_PCa-Stem_ssGSEA_scores.csv"
output_plot_file <- "Script_2_Output_PCa_Stem_Score_Grouped_Boxplot.pdf"

# -------------------- Gene Set Definitions --------------------

# -----------------------------
# Define gene sets by ID format
# -----------------------------

gene_sets_list <- list(
  gene_symbol = c("HMMR", "AURKB", "CENPA", "DEPDC1B", "HJURP", "PBK",
                  "MELK", "UBE2C", "DLGAP5", "NEK2", "BIRC5", "KLK12"),
  ensg = c("ENSG00000072571", "ENSG00000178999", "ENSG00000115163", "ENSG00000035499",
           "ENSG00000123485", "ENSG00000168078", "ENSG00000165304", "ENSG00000175063",
           "ENSG00000126787", "ENSG00000117650", "ENSG00000089685", "ENSG00000186474"),
  ensg_with_version = c("ENSG00000072571.20", "ENSG00000178999.13", "ENSG00000115163.15",
                        "ENSG00000035499.13", "ENSG00000123485.12", "ENSG00000168078.10",
                        "ENSG00000165304.8", "ENSG00000175063.17", "ENSG00000126787.13",
                        "ENSG00000117650.13", "ENSG00000089685.15", "ENSG00000186474.16")
)

# Fetch selected gene set
gene_set <- gene_sets_list[[gene_id_format]]
gene_sets <- list("PCa_Stem_Signature" = gene_set)

if (is.null(gene_set)) {
  stop("Invalid 'gene_id_format' value. Please choose from: 'gene_symbol', 'ensg', 'ensg_with_version'")
}

# -------------------- Load Expression Matrix --------------------
# The CSV should contain a column named "Gene" (or first column) with gene IDs (e.g., Ensembl IDs with or without version, or gene symbols),
# and sample columns (id.1, id.2, ..., id.n) as additional columns
# and normalized expression values (e.g., log2 TPMs or FPKMs) in subsequent sample columns

# Read expression matrix using read_csv (expecting first column as gene names)
expr_df <- read_csv(expr_file)

# Move the first column (gene names) to row names
expr_mat <- as.data.frame(expr_df)
rownames(expr_mat) <- expr_mat[[1]]  # Assign gene names as row names
expr_mat[[1]] <- NULL                # Remove gene name column

# Convert to matrix for downstream GSVA input use
expr_mat <- as.matrix(expr_mat)


# -------------------- Check for Missing Genes --------------------

found_genes <- intersect(gene_set, rownames(expr_mat))
missing_genes <- setdiff(gene_set, rownames(expr_mat))
cat("PCa-Stem genes found in dataset:", length(found_genes), "of 12\n")
if (length(missing_genes) > 0) {
  cat("Warning: The following genes are missing and will be ignored:\n")
  print(missing_genes)
  cat("⚠️Warning: Enrichment may be less accurate.\n")
}

# -------------------- Run ssGSEA --------------------

gsva_scores <- gsva(expr_mat, gene_sets, method = "ssgsea", verbose = FALSE)

# Export results
write.csv(gsva_scores, output_score_file)
cat("ssGSEA analysis complete. ssGSEA scores saved to", output_score_file, "\n")


# -------------------- Optional: Boxplot by Group --------------------

if (enable_group_plot) {
  cat("Generating group-based boxplot using:", meta_file, "\n")
  
  meta <- read_excel(meta_file)
  meta <- as.data.frame(meta)
  colnames(meta)[1:2] <- c("SampleID", "Status")
  
  # Prepare score and metadata for merging
  score_df <- as.data.frame(t(gsva_scores))
  score_df$SampleID <- rownames(score_df)
  
  merged <- merge(score_df, meta, by = "SampleID")
  merged$Status <- factor(merged$Status, levels = c("NORMAL", "Pri-PCa", "CRPC"))
  
  p <- ggplot(merged, aes(x = Status, y = PCa_Stem_Signature, fill = Status)) +
    geom_boxplot(alpha = 0.7, outlier.shape = NA) +
    geom_jitter(width = 0.2, size = 1.5, alpha = 0.5) +
    labs(title = "PCa-Stem Signature Enrichment",
         y = "ssGSEA Enrichment Score", x = "") +
    theme_minimal(base_size = 12) +
    theme(legend.position = "none")
  
  ggsave(output_plot_file, plot = p, width = 6, height = 5)
  cat("Boxplot saved to", output_plot_file, "\n")
}