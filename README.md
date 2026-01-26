# EMT-associated transcriptional changes in cervical cancer

This repository contains analysis code used in a Master's thesis
investigating epithelial–mesenchymal transition (EMT)–associated
transcriptional programs and survival in cervical cancer.

## Analysis overview
- Differential expression analysis: TCGA-CESC vs GTEx cervix (DESeq2)
- Gene set enrichment analysis: Hallmark EMT (fgsea)
- EMT scoring and survival modeling: Cox proportional hazards model

## Data sources
- TCGA-CESC (via recount3)
- GTEx cervix tissues (via recount3)
- MSigDB Hallmark EMT gene set (v2025.1)

Raw sequencing data and large intermediate objects are not included.
All results can be reproduced by running the scripts in numerical order.

## Software
- R 4.5.2
- DESeq2
- fgsea
