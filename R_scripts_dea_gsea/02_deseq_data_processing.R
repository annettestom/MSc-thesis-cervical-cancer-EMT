library(DESeq2)
tcga <- readRDS("results/dea/tcga_cesc_primary_01.rds")
gtex <- readRDS("results/dea/gtex_cervix_rse.rds")

dim(tcga$counts_01)
head(colnames(tcga$counts_01))
head(rownames(tcga$counts_01))

dim(assay(gtex))
head(colnames(assay(gtex)))
head(rownames(assay(gtex)))


#Step 1 - stripping Ensembl ID verion numbers to make genes comparable
#TCGA counts matrix stripping - sub() replaces the pattern "\\..*S" with an empty string
rownames(tcga$counts_01) <- sub("\\..*$", "", rownames(tcga$counts_01))
head(rownames(tcga$counts_01))

#Step 2 - GTEx assay matrix Ensembl ID version stripping
#First I save the assay into a dataframe
gtex_counts <- assay(gtex)
rownames(gtex_counts) <- sub("\\..*$", "", rownames(gtex_counts))
head(rownames(gtex_counts))

#Step 3 - checking for duplicate gene IDs before merging
any(duplicated(rownames(tcga$counts_01)))
any(duplicated(rownames(gtex_counts)))
#both were TRUE - now summing counts across duplicated rows with rowsum()
tcga$counts_01 <- rowsum(tcga$counts_01, group = rownames(tcga$counts_01))
gtex_counts <- rowsum(gtex_counts, group = rownames(gtex_counts))
#checking if it worked
any(duplicated(rownames(tcga$counts_01)))
any(duplicated(rownames(gtex_counts)))
dim(tcga$counts_01)
dim(gtex_counts)

#Step 4 - merging TCGA and GTEx data - aligning Ensembl IDs and concatting columns
#first using intersect() to find the common genes and create new matrixes with only those common genes
common_genes <- intersect(rownames(tcga$counts_01), rownames(gtex_counts))
tcga2 <- tcga$counts_01[common_genes, , drop = FALSE]
gtex2 <- gtex_counts[common_genes, , drop = FALSE]
stopifnot(identical(rownames(tcga2), rownames(gtex2)))
#use cbind() to merge counts
counts_merged <- cbind(tcga2, gtex2)

#Step 5 - making a sample table colData with conditions "tumor" and "normal"
#conditions are categorical values - "normal" is the reference and "tumor" is the comparison
condition <- c(rep("tumor", ncol(tcga2)), rep("normal", ncol(gtex2)))
coldata <- data.frame(condition = factor(condition, levels = c("normal", "tumor")))
rownames(coldata) <- colnames(counts_merged)
dim(coldata)
dim(counts_merged)
any(duplicated(rownames(counts_merged)))
any(is.na(rownames(counts_merged)))
head(coldata)
tail(coldata)

#Step 6 - checking the integrity of my data and creating the DESeq2 object
stopifnot(
  all(colnames(counts_merged) == rownames(coldata)),
  is.factor(coldata$condition)
)

dds <- DESeqDataSetFromMatrix(countData = counts_merged, colData = coldata, design = ~ condition)
dds

#Step 7 - prefiltering before running DEA - keep genes that have atleast 10 reads total across samples
keep <- rowSums(counts(dds)) >= 10
count_filt <- counts(dds)[keep, , drop = FALSE]
dds <- DESeqDataSetFromMatrix(countData = count_filt, colData = colData(dds), design = ~ condition)
dim(dds)
#check if the condition levels are right
levels(colData(dds)$condition)
#check for sample uniqueness
any(duplicated(colnames(dds)))
#saving dds to an RDS file
saveRDS(dds, "dds_filtered.rds")
