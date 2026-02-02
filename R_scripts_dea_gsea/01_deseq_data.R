#install.packages("BiocManager")
#BiocManager::install(c("recount3", "DESeq2"), ask = FALSE, update = TRUE)

library(recount3)
library(DESeq2)

human_projects <- available_projects()

table(human_projects$file_source)

proj_info_gtex <-subset(human_projects, file_source == "gtex" & project_type == "data_sources")

proj_info_tcga <-subset(human_projects, file_source == "tcga" & project_type == "data_sources")

proj_info_tcga_cesc <- subset(proj_info_tcga, project == "CESC")
proj_info_tcga_cesc

rse_tcga_cesc <- create_rse(proj_info_tcga_cesc)

rse_tcga_cesc
rowData(rse_tcga_cesc)
colnames(rowData(rse_tcga_cesc))
head(as.data.frame(rowData(rse_tcga_cesc)))

#exporting a genes table for modeling later on
genes <- as.data.frame(rowData(rse_tcga_cesc))

write.table(genes, file = "results/files_for_python/tcga_genes_rowData.tsv", sep = "\t", quote = FALSE, col.names = NA)

#I want only primary tumor samples in the tcga project
head(colData(rse_tcga_cesc)$tcga.tcga_barcode, 10)
bc <- as.character(colData(rse_tcga_cesc)$tcga.tcga_barcode)

stype <- substr(vapply(strsplit(bc, "-"), `[`, "", 4), 1, 2)
stype
table(stype, useNA = "ifany")

keep01 <- (stype == "01")
counts_01 <- assay(rse_tcga_cesc)[, keep01, drop = FALSE]
dim(counts_01)

meta_01 <- as.data.frame(colData(rse_tcga_cesc))[keep01, , drop = FALSE]
table(substr(vapply(strsplit(meta_01$tcga.tcga_barcode, "-"), `[`, "", 4), 1, 2))

saveRDS(list(counts_01 = counts_01, meta_01 = meta_01), "tcga_cesc_primary_01.rds")

#Now GTEx
proj_info_gtex_cervix <- subset(proj_info_gtex, project == "CERVIX_UTERI")
proj_info_gtex_cervix
rse_gtex <- create_rse(proj_info_gtex_cervix)
rse_gtex
#what assays exist
assayNames(rse_gtex)
#sample IDs
colnames(rse_gtex)[1:5]
#gene IDs
rownames(rse_gtex)[1:5]
#counts matrix shape
dim(assay(rse_gtex))
#taking a look at the cervix tissue 
table(colData(rse_gtex)$gtex.smts)
table(colData(rse_gtex)$gtex.smtsd)
#saving the RSE as an rds file
saveRDS(rse_gtex, "gtex_cervix_rse.rds")
