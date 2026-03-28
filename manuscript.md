# MA4 vs HKSJ: Complementary or Redundant Robustness Metrics?

**Date:** February 2026
**Project:** chatpaper (Automated Meta-Epidemiological Analysis)
**Status:** Validated across 77 Standardized R Package Datasets

---

## Abstract

### Background
The **MA4 R-index** (a measure of analytic stability) and the **Hartung-Knapp-Sidik-Jonkman (HKSJ)** correction (a small-sample adjustment) both aim to address the robustness of meta-analytic conclusions. We examined whether these metrics provide redundant or complementary information across a diverse set of empirical datasets.

### Methods
We applied the MA4 R-index algorithm and the HKSJ correction to 434 Cochrane meta-analyses (k≥5) and validated the findings across 77 standardized datasets from multiple R packages (`metadat`, `psymetadata`, `robumeta`, etc.). We assessed the correlation between the R-index and HKSJ-induced conclusion change and identified predictors of conclusion change.

### Results
The MA4 R-index was not significantly correlated with HKSJ conclusion change (r = 0.05, p = 0.26) in the primary Cochrane sample. Validation across standardized R datasets confirmed that the two metrics capture distinct dimensions of quality: R-index assesses stability under analytic perturbations (leave-one-out, weight changes), while HKSJ addresses uncertainty from small-sample sizes and between-study heterogeneity. The strongest predictor of conclusion change remains baseline significance (OR = 5.41, p < 0.001).

### Conclusions
MA4 R-index and HKSJ correction are **complementary, not redundant** metrics. Meta-analyses should report both the R-index to indicate analytic stability and the HKSJ-adjusted results to account for small-sample uncertainty.

---

## Key Findings (k≥5, n=434)

### Primary Result
**MA4 R-index is NOT significantly associated with HKSJ conclusion stability**
- Correlation: r = 0.05, p = 0.26
- Logistic OR: 1.79 [0.14, 27.5], p = 0.66

### Strongest Predictor
**Initially significant results are 5.4x more likely to change conclusion**
- OR = 5.41 [2.45, 13.4], p < 0.001
- 9.2% overall change rate

---

## Analysis of R-index Categories

| R Category | % Changed (Cochrane) | % Initially Sig | Change Rate (if sig) |
|------------|----------------------|-----------------|---------------------|
| Very Low | 0.0% | 25.0% | 0.0% |
| Low | 1.3% | 33.3% | 4.0% |
| **Moderate** | **17.1%** | **58.9%** | **25.0%** |
| High | 8.0% | 51.7% | 11.5% |
| Excellent | 5.9% | 35.3% | 0.0% |

**Explanation:** "Moderate" R-index has the highest proportion of initially significant results (58.9%) AND the highest change rate among initially significant MAs (25%). These are borderline cases where HKSJ adjustment tips conclusions from significant to non-significant.

---

## Supplementary Analysis: 77 Standardized R Datasets

To ensure the generalizability of our findings beyond Cochrane meta-analyses, we replicated the analysis across 77 standardized datasets extracted from leading R packages.

### Findings from Standardized Revalidation:
- **Consistent Disconnect:** The R-index and HKSJ SE-ratio show weak correlation across diverse effect types (MD, SMD, OR, RR).
- **Stability Profile:** Datasets from `psymetadata` (social sciences) showed lower average R-indices compared to medical datasets from `metadat`, but the lack of correlation between R-index and HKSJ adjustment remained consistent.
- **Robustness:** The non-monotonic relationship observed in the Cochrane sample was broadly supported, with "Moderate" stability meta-analyses consistently showing the highest vulnerability to small-sample corrections.

---

## Conclusions and Recommendations

1. **Dual Reporting:** Journals should encourage reporting of both analytic stability (e.g., MA4 R-index) and small-sample adjustments (e.g., HKSJ).
2. **Threshold Awareness:** Meta-analyses with "Moderate" R-index (0.4-0.6) are at high risk of conclusion instability and should be interpreted with particular caution when HKSJ adjustments are not applied.
3. **Complementary Usage:** R-index should be used to gauge the impact of analytic choices (sensitivity analysis), while HKSJ should be used to provide more realistic confidence intervals in random-effects models with few studies.
