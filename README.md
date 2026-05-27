# EMT score and survival in cervical cancer

This repository contains thesis source files, analysis code, and selected outputs for a Master's thesis investigating epithelial-mesenchymal transition (EMT) transcriptional programs and survival in cervical cancer.

## Thesis

- Typst source: `thesis_paper/main.typ`
- Compiled PDF: `thesis_paper/main.pdf`
- Figures used by the thesis: `thesis_paper/images/`
- Compile command: `cd thesis_paper && ./compile.sh`

## Analysis workflow

1. Differential expression analysis and GSEA are in `R_scripts_dea_gsea/`.
2. EMT scoring, survival table construction, Cox models, and visualisation are in `EMT_scoring_and_cox_model/notebooks/`.
3. Final supplementary tables are collected in `Supplementary_tables/`.

## Data sources

- TCGA-CESC via recount3
- GTEx cervix tissues via recount3
- MSigDB Hallmark EMT gene set v2025.1

## Reproducibility notes

Raw sequencing data and some large intermediate files are not included. The repository includes the analysis scripts/notebooks, result tables, figures used in the thesis, and `sessionInfo.txt` for the R package environment. 

The analysis was run in numbered stages, but it is not a single-command pipeline; notebooks should be run in numerical order after the R data-preparation and export scripts have produced the required input files.

## Software

- R 4.5.2
- DESeq2 1.50.2
- fgsea 1.36.2
- Python 3.12.3
- pandas 2.3.1
- numpy 2.3.2
- lifelines 0.30.1
- matplotlib 3.10.5
- seaborn 0.13.2
- scipy 1.17.0
- Typst 0.14.2 for compiling the thesis PDF
