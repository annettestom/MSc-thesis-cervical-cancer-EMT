library(DESeq2)
dds <- readRDS("dds_deseq.rds")

res <- results(dds)

res_df <- as.data.frame(res)
res_df$gene <- rownames(res_df)

write.table(res_df,
            file = "Supplementary_Table_S1_DE_results.tsv",
            sep = "\t",
            quote = FALSE,
            row.names = FALSE)
