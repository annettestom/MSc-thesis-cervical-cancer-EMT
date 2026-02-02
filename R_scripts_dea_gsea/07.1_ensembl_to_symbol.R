library(AnnotationDbi)
library(org.Hs.eg.db)

tcga <- readRDS("results/dea/tcga_cesc_primary_01.rds")
dim(tcga$counts_01)

#Step 1 - strip Ensembl IDs from counts_01
ens <- unique(sub("\\..*$", "", rownames(tcga$counts_01)))
length(ens)
head(ens)

#Step 2 - map the IDs to gene names
map <- AnnotationDbi::select(
  org.Hs.eg.db,
  keys = ens,
  keytype = "ENSEMBL",
  columns = c("SYMBOL")
)

head(map)

#Step 3 - keep only non NA and non empty values, remove duplicates
map <- map[!is.na(map$SYMBOL) & map$SYMBOL != "", ]
map <- unique(map)

write.table(map, "results/annotation/ensembl_to_symbol.tsv", sep="\t", quote=FALSE, row.names=FALSE)

#Step 4 - map EMT genes to Ensembl IDs
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

emt_map <- map[map$SYMBOL %in% emt_genes, ]
dim(emt_map)
head(emt_map)
tail(emt_map)

#Step 5 - how many EMT genes failed to map?
emt_mapped_syms <- unique(emt_map$SYMBOL)
unmapped <- setdiff(emt_genes, emt_mapped_syms)

cat("EMT symbols:", length(emt_genes), "\n")
cat("Mapped EMT symbols:", length(emt_mapped_syms), "\n")
cat("Unmapped EMT symbols:", length(unmapped), "\n")

#Step 6 - any duplicates?
dup_sym <- names(which(table(emt_map$SYMBOL) > 1))
length(dup_sym)
head(dup_sym)

#Step 7 - remove duplicates - keep highest-expression Ensembl per symbol
counts <- tcga$counts_01
rownames(counts) <- sub("\\..*$", "", rownames(counts))

gene_means <- rowMeans(counts)
emt_map$mean_expr <- gene_means[emt_map$ENSEMBL]

emt_map <- emt_map[order(emt_map$SYMBOL, -emt_map$mean_expr), ]
emt_map_1to1 <- emt_map[!duplicated(emt_map$SYMBOL), c("SYMBOL", "ENSEMBL")]
dim(emt_map_1to1)

write.table(emt_map_1to1, "results/annotation/emt_symbol_to_ensembl.tsv", sep="\t", quote=FALSE, row.names=FALSE)
