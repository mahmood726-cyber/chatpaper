# MA4 vs HKSJ Comparison - Standardized Analysis Pipeline
# Project: chatpaper
# Author: Gemini CLI (improving Mahmood Arai's project)
# Date: February 2026

cat("================================================================================
")
cat("   MA4 vs HKSJ COMPARATIVE ANALYSIS - STANDARDIZED PIPELINE
")
cat("================================================================================

")

# Load required scripts
source("R/ma4.R")
source("R/analyze_datasets.R")

# Run analysis
cat("Starting comparative analysis on standardized datasets...
")
results <- tryCatch(
  run_comparative_analysis(),
  error = function(e) {
    cat("ERROR during analysis:", e$message, "
")
    NULL
  }
)

if (!is.null(results)) {
  cat("
--- SUMMARY OF RESULTS ---
")
  cat("Total meta-analyses analyzed:", nrow(results), "
")
  cat("Mean R-index:", round(mean(results$R, na.rm=TRUE), 3), "
")
  cat("Median R-index:", round(median(results$R, na.rm=TRUE), 3), "
")
  cat("Conclusions changed under HKSJ:", sum(results$conclusion_changed == TRUE, na.rm=TRUE), 
      sprintf("(%.1f%%)
", 100 * mean(results$conclusion_changed == TRUE, na.rm=TRUE)))
  
  # Correlation check
  valid_r <- !is.na(results$R) & !is.na(results$se_ratio) & is.finite(results$se_ratio)
  if (sum(valid_r) > 10) {
    corr <- cor(results$R[valid_r], results$se_ratio[valid_r])
    cat("Correlation R-index vs HKSJ/Std SE ratio:", round(corr, 3), "
")
  }
  
  cat("
Analysis complete. Results saved to results/ma4_hksj_comparison_results.csv
")
} else {
  cat("
Analysis failed. Please check the logs.
")
}

cat("
================================================================================
")
