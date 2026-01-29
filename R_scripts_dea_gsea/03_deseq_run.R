library(DESeq2)
dds <- readRDS("results/dea/dds_filtered.rds")

dds <- DESeq(dds)
saveRDS(dds, "results/dea/dds_deseq.rds")