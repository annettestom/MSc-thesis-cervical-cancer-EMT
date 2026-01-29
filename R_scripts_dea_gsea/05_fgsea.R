library(DESeq2)

dds <- readRDS("results/dea/dds_deseq.rds")
levels(colData(dds)$condition)
res <- results(dds)
mcols(res)$description

#if (!requireNamespace("BiocManager", quietly=TRUE)) install.packages("BiocManager")
#BiocManager::install(c("fgsea", "org.Hs.eg.db", "AnnotationDbi"))

#Step 1 - create inputs for gsea - a ranked gene list with Wald test statistic as ranking
gene_ranks <- res$stat
names(gene_ranks) <- rownames(res)
gene_ranks <- gene_ranks[!is.na(gene_ranks)]
#now gene_ranks is a named numeric vector - names are ensembl IDs and values are stat
#now sort decreasing
gene_ranks <- sort(gene_ranks, decreasing = TRUE)
length(gene_ranks)
head(gene_ranks)
tail(gene_ranks)
# Step 2 - mapping to gene symbols, because Hallmark EMT gene set is symbols
library(org.Hs.eg.db)
library(AnnotationDbi)

symbols <- mapIds(
  org.Hs.eg.db,
  keys = names(gene_ranks),
  column = "SYMBOL",
  keytype = "ENSEMBL",
  multiVals = "first"
)
#remove genes that failed mapping
keep <- !is.na(symbols)
gene_ranks_sym <- gene_ranks[keep]
names(gene_ranks_sym) <- symbols[keep]
#check for duplicated ensembl IDs
sum(duplicated(names(gene_ranks_sym)))
#there are 86 duplicates - keeping the strongest signal per gene symbol
gene_ranks_sym <- tapply(gene_ranks_sym, names(gene_ranks_sym), function(x) x[which.max(abs(x))])
gene_ranks_sym <- sort(gene_ranks_sym, decreasing = TRUE)
head(gene_ranks_sym)
tail(gene_ranks_sym)
dim(gene_ranks_sym)



#Step 3 - make the pathways list for the second input from hallmark gene set
gmt_path <- "/home/annettestomakhin/Magistritöö/gene_sets/HALLMARK_EPITHELIAL_MESENCHYMAL_TRANSITION.v2025.1.Hs.gmt"
ln <- readLines(gmt_path)
fields <- strsplit(ln, "\t", fixed = TRUE)[[1]]
gs_name <- fields[1]
gs_desc <- fields[2]
emt_genes <- fields[-c(1,2)]
head(emt_genes)
tail(emt_genes)
emt_genes <- unique(emt_genes)
emt_genes <- emt_genes[nzchar(emt_genes)]
gs_name
length(emt_genes)

#Step 4 - check if the genes match 
sum(names(gene_ranks_sym) %in% emt_genes)

#Step 5 - build the pathways object - it is a list with pathway names and the corresponding char vector of gene symbols
pathways <- list()
pathways[[gs_name]] <- emt_genes
names(pathways)
length(pathways)
length(pathways[[1]])

#Step 6 - run fgsea
library(fgsea)
set.seed(1)
fg <- fgsea(pathways = pathways, stats = gene_ranks_sym, minSize = 15, maxSize = 500)
fg
colnames(fg)
fg_out <- fg[, .(pathway, pval, padj, log2err, ES, NES, size)]
out_path <- "results/gsea/gsea_EMT_fgsea_results.csv"
write.csv(fg_out, out_path, row.names = TRUE)
saveRDS(fg, file = "results/gsea/gsea_EMT_fgsea_full.rds")

#Step 7 - visualize how the running-sum changes through the ranks (running enrichment-score)
library(fgsea)
library(ggplot2)
plotEnrichment(
  pathways[[1]],          # EMT genes (character vector)
  gene_ranks_sym          # your ranked stats (named numeric vector)
) + ggplot2::labs(
  title = "GSEA: Hallmark EMT (tumor vs normal)",
  subtitle = sprintf("NES = %.2f, FDR = %.2e", fg$NES[1], fg$padj[1]),
  x = "Genes ranked by DESeq2 Wald statistic (tumor vs normal)",
  y = "Running enrichment score"
)

#Step 8 - which EMT genes drive the enrichment?
leading <- fg$leadingEdge[[1]]
head(leading, 20)
length(leading)
leading_df <- data.frame(gene = leading, stat = unname(gene_ranks_sym[leading]))
leading_df <- leading_df[order(leading_df$stat), ]
tail(leading_df)
out_path_leading <- "results/gsea/gsea_EMT_fgsea_leading_genes.csv"
write.csv(leading_df, out_path_leading, row.names = TRUE)
