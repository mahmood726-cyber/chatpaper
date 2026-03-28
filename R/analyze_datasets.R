#' Run Comparative Analysis (MA4 vs HKSJ) on Standardized Datasets
#'
#' This script processes all CSV files in supplementary/standardized and
#' computes the MA4 R-index and HKSJ adjustment for each meta-analysis.
#'
#' @export
run_comparative_analysis <- function() {
  library(metafor)
  library(dplyr)
  
  # Directory setup
  data_dir <- "supplementary/standardized"
  output_dir <- "results"
  if (!dir.exists(output_dir)) dir.create(output_dir)
  
  # Get all CSV files
  files <- list.files(data_dir, pattern = "\\.csv$", full.names = TRUE)
  cat("Found", length(files), "standardized datasets\n")
  
  all_results <- list()
  
  for (f in files) {
    cat("  Processing:", basename(f), "
")
    
    # Read dataset
    df <- read.csv(f)
    if (!all(c("yi", "vi") %in% names(df))) {
      cat("    WARNING: Missing yi/vi in", basename(f), ". Skipping.
")
      next
    }
    
    # Identify grouping variable (study, ma_id, article, id, etc.)
    group_var <- NULL
    if ("study_id" %in% names(df)) group_var <- "study_id"
    else if ("study" %in% names(df)) group_var <- "study"
    else if ("ma_id" %in% names(df)) group_var <- "ma_id"
    else if ("article" %in% names(df)) group_var <- "article"
    else if ("experiment" %in% names(df)) group_var <- "experiment"
    else if ("id" %in% names(df)) group_var <- "id"
    
    if (!is.null(group_var)) {
      # Grouped meta-analyses
      ma_list <- split(df, df[[group_var]])
      cat("    Detected", length(ma_list), "meta-analyses (grouped by", group_var, ")
")
    } else {
      # Single meta-analysis
      ma_list <- list(df)
      cat("    Detected single meta-analysis
")
    }
    
    # Analyze each MA
    for (i in seq_along(ma_list)) {
      ma <- ma_list[[i]]
      if (nrow(ma) < 2) next # Need at least 2 studies
      
      # Base REML analysis
      fit_std <- tryCatch(
        rma(yi = yi, vi = vi, data = ma, method = "REML"),
        error = function(e) NULL
      )
      if (is.null(fit_std)) next
      
      # HKSJ analysis
      fit_hksj <- tryCatch(
        rma(yi = yi, vi = vi, data = ma, method = "REML", test = "knha"),
        error = function(e) NULL
      )
      
      # Compute MA4 R-index
      R <- compute_R_index(ma$yi, ma$vi)
      
      # Compile result
      res <- data.frame(
        dataset = basename(f),
        ma_idx = i,
        group_id = ifelse(!is.null(group_var), names(ma_list)[i], NA),
        k = nrow(ma),
        theta_std = as.numeric(fit_std$beta),
        se_std = fit_std$se,
        p_std = fit_std$pval,
        sig_std = fit_std$pval < 0.05,
        theta_hksj = ifelse(!is.null(fit_hksj), as.numeric(fit_hksj$beta), NA),
        se_hksj = ifelse(!is.null(fit_hksj), fit_hksj$se, NA),
        p_hksj = ifelse(!is.null(fit_hksj), fit_hksj$pval, NA),
        sig_hksj = ifelse(!is.null(fit_hksj), fit_hksj$pval < 0.05, NA),
        R = R,
        I2 = fit_std$I2,
        tau2 = fit_std$tau2
      )
      
      # Derived metrics
      res$se_ratio <- res$se_hksj / res$se_std
      res$conclusion_changed <- (res$sig_std != res$sig_hksj)
      res$R_cat <- classify_R(res$R)
      
      all_results[[length(all_results) + 1]] <- res
    }
  }
  
  # Combine results
  final_df <- do.call(rbind, all_results)
  write.csv(final_df, file.path(output_dir, "ma4_hksj_comparison_results.csv"), row.names = FALSE)
  cat("
SUCCESS! Saved results for", nrow(final_df), "meta-analyses.
")
  return(final_df)
}
