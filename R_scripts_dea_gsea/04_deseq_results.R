library(DESeq2)

dds <- readRDS("results/dea/dds_deseq.rds")
dds

assayNames(dds)
resultsNames(dds)
res <- results(dds)

head(res)
summary(res)
head(res[order(res$padj), ])
table(is.na(res$padj))

#how many genes were tested - number of rows in res
n_tested <- nrow(res)
n_tested

#how many genes have a non NA adjusted p-value?
n_with_padj <- sum(!is.na(res$padj))
n_with_padj
#how many genes padj < 0.05
alpha <- 0.05
n_sig <- sum(res$padj < alpha, na.rm = TRUE)
n_sig
#how many were upregulated
n_up <- sum(res$padj < alpha & res$log2FoldChange > 0, na.rm = TRUE)
n_up
#how many were downregulated
n_down <- sum(res$padj < alpha & res$log2FoldChange < 0, na.rm = TRUE)
n_down
n_up + n_down == n_sig

#how many genes are |log2FC| >= 1

lfc_cutoff <- 1

n_sig_lfc <- sum(res$padj < alpha & abs(res$log2FoldChange) >= lfc_cutoff, na.rm = TRUE)
n_up_lfc <- sum(res$padj < alpha & res$log2FoldChange >= lfc_cutoff, na.rm = TRUE)
n_down_lfc <- sum(res$padj < alpha & res$log2FoldChange <= -lfc_cutoff, na.rm = TRUE)
n_sig_lfc
n_up_lfc
n_down_lfc
#Step 1 - dispersion plot

plotDispEsts(dds)

#Step 2 - PCA
vsd <- vst(dds, blind = FALSE)
plotPCA(vsd, intgroup = "condition")

#Step 3 - MA plot

plotMA(res, ylim = c(-5,5))

#Step 4 - Volcano plot
res_df <- as.data.frame(res)
res_df$gene <- rownames(res_df)
#remove genes without adjusted p-values
res_df <- res_df[!is.na(res_df$padj), ]
#significance threshholds
padj_cutoff <- 0.05
lfc_cutoff <- 1
#creating a column for significance
res_df$significant <- "Not significant"

res_df$significant[
  res_df$padj < padj_cutoff &
    abs(res_df$log2FoldChange) >= lfc_cutoff
] <- "Significant"

plot(
  res_df$log2FoldChange,
  -log10(res_df$padj),
  pch = 16,
  col = ifelse(res_df$significant == "Significant", "red", "grey"),
  xlab = "log2 fold change (tumor vs normal)",
  ylab = "-log10 adjusted p-value",
  main = "Volcano plot: tumor vs normal"
)
abline(v = c(-lfc_cutoff, lfc_cutoff), lty = 2)
abline(h = -log10(padj_cutoff), lty = 2)
