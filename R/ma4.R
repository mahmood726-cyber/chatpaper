#' Compute MA4 R-index for Meta-Analysis Stability
#'
#' This function calculates the R-index (0-1), which represents the proportion of
#' perturbed meta-analyses that yield the same statistical conclusion as the
#' original analysis.
#'
#' @param yi Numeric vector of observed effect sizes.
#' @param vi Numeric vector of observed variances.
#' @param n_perturb Integer. Number of perturbations to perform (default 100).
#' @return Numeric value (0-1) representing the stability R-index.
#' @export
compute_R_index <- function(yi, vi, n_perturb = 100) {
  library(metafor)
  
  # Base analysis
  fit_base <- tryCatch(
    rma(yi = yi, vi = vi, method = "REML"),
    error = function(e) NULL
  )
  if (is.null(fit_base)) return(NA)

  theta_base <- as.numeric(fit_base$beta)
  sig_base <- fit_base$pval < 0.05

  # Perturbation analyses
  stable_count <- 0
  k <- length(yi)

  for (p in 1:n_perturb) {
    # Random perturbations: LOO, weight changes, outlier exclusion
    perturb_type <- sample(1:3, 1)

    if (perturb_type == 1 && k > 2) {
      # Leave-one-out
      idx <- sample(1:k, 1)
      yi_p <- yi[-idx]
      vi_p <- vi[-idx]
    } else if (perturb_type == 2) {
      # Weight perturbation (multiply vi by random factor)
      vi_p <- vi * runif(k, 0.8, 1.2)
      yi_p <- yi
    } else {
      # Small effect size perturbation
      yi_p <- yi + rnorm(k, 0, sqrt(vi) * 0.1)
      vi_p <- vi
    }

    fit_p <- tryCatch(
      rma(yi = yi_p, vi = vi_p, method = "REML"),
      error = function(e) NULL
    )

    if (!is.null(fit_p)) {
      sig_p <- fit_p$pval < 0.05
      if (sig_p == sig_base) stable_count <- stable_count + 1
    }
  }

  R <- stable_count / n_perturb
  return(R)
}

#' Classify R-index into Stability Categories
#'
#' @param R Numeric value (0-1).
#' @return Character string representing the category.
#' @export
classify_R <- function(R) {
  if (is.na(R)) return(NA)
  if (R < 0.2) return("Very Low")
  if (R < 0.4) return("Low")
  if (R < 0.6) return("Moderate")
  if (R < 0.8) return("High")
  return("Excellent")
}
