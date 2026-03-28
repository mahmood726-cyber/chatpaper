# chatpaper: Comparative Analysis of MA4 Stability vs HKSJ Correction

## Overview
This research project examines the relationship between the **MA4 R-index** (a measure of meta-analysis stability under analytic perturbations) and the **Hartung-Knapp-Sidik-Jonkman (HKSJ)** correction (a small-sample adjustment for random-effects meta-analysis).

The study aims to determine if these two metrics provide redundant or complementary information about the quality and robustness of meta-analytic evidence.

## Project Structure
- `R/`: Source code for analysis.
  - `ma4.R`: Implementation of the MA4 R-index algorithm.
  - `analyze_datasets.R`: Pipeline to iterate through standardized datasets.
- `supplementary/standardized/`: 77 standardized datasets from multiple R packages (`metadat`, `psymetadata`, etc.).
- `results/`: Output of the comparative analysis.
- `main.R`: Master script to execute the entire pipeline.
- `manuscript.md`: Draft paper summarizing the findings (based on MA4 vs HKSJ comparison).

## Getting Started
To reproduce the analysis, run the `main.R` script in R:
```R
source("main.R")
```

## Authors
- **Mahmood Arai** (Original concept and analysis)
- **Gemini CLI** (Project structure enhancement and standardization)

## Date
January - February 2026
