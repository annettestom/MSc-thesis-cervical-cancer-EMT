library(SummarizedExperiment)

obj <- readRDS("results/dea/tcga_cesc_primary_01.rds")

names(obj)
dim(obj$counts_01)
dim(obj$meta_01)

write.table(obj$counts_01, file = "results/files_for_python/tcga_counts_01.tsv", sep = "\t", quote = FALSE, col.names = NA)

write.table(obj$meta_01, file = "results/files_for_python/tcga_meta_01.tsv", sep = "\t", quote = FALSE, col.names = NA)
