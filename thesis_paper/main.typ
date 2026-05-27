// Title page
#set page(
  paper: "a4",
  margin: (left: 3cm, right: 2cm, top: 2cm, bottom: 2cm),
  footer: context {
    let p = counter(page).get().first()
    if p > 1 {
      align(center)[#counter(page).display("1")]
    }
  },
)

#set text(
  font: "Times New Roman",
  size: 12pt
)

#set par(
  leading: 1.05em,
  justify: true
)

#set heading(numbering: "1.")
#set bibliography(style: "american-psychological-association")
#show figure.caption: set par(leading: 0.65em)
#show figure.where(
  kind: table
): set figure.caption(position: top)

#align(center)[
  #text(12pt)[UNIVERSITY OF TARTU] \
  #text(12pt)[FACULTY OF SCIENCE AND TECHNOLOGY] \
  #text(12pt)[INSTITUTE OF MOLECULAR AND CELL BIOLOGY] \
  #text(12pt)[INSTITUTE OF CLINICAL MEDICINE]\
  #text(12pt)[DEPARTMENT OF OBSTETRICS AND GYNECOLOGY]
]

#v(5.2cm)

#align(center)[
  #text(16pt, weight: "bold")[
    Association Between an EMT Gene Expression Score and Survival in Cervical Cancer
  ]
]

#v(2.2cm)

#align(center)[
  #text(12pt)[Master’s Thesis] \
  #text(12pt)[30 EAP]
]

#v(2.2cm)

#align(center)[
  #text(12pt)[Annette Stomakhin] \
  #v(0.8em)
  #text(12pt)[PhD Vijayachitra Modhukur]
]

#v(1fr)

#align(center)[
  #text(12pt)[TARTU 2026]
]

#pagebreak()



// Main content starts here

#heading(level: 1, numbering: none, outlined: false)[Information sheet]

Title: Association Between an EMT Gene Expression Score and Survival in Cervical Cancer

Summary: This thesis assesses the association between a transcriptome-derived epithelial-mesenchymal transition (EMT) score and survival in cervical cancer using publicly available gene expression data.

Keywords: Cervical cancer, EMT, survival analysis

\
Pealkiri: EMT geeniekspressiooni skoori seos elumusega emakakaelavähi korral

Lühikokkuvõte: Käesolevas magistritöös hinnatakse avalikult kättesaadavate geeniekspressiooni andmete põhjal koostatud epiteel-mesenhümaalse-ülemineku (EMT) skoori seost elumusega emakakaelavähi patsientidel.

Märksõnad: Emakakaelavähk, EMT, elumusanalüüs

\
CERCS: B110

#pagebreak()

#heading(level: 1, numbering: none)[Table of contents]
#outline(title: none)

#pagebreak()

#heading(level: 1, numbering: none)[List of abbreviations]

CAF - cancer-associated fibroblast

CC - cervical cancer

CIN - cervical intraepithelial neoplasia

CSC - cancer stem cells

DEA - differential expression analysis

EMT - epithelial-mesenchymal transition

GSEA - gene set enrichment analysis

GTEx - Genotype-Tissue Expression

HPV - human papillomavirus

LNM - lymph node metastasis

MET - mesenchymal-epithelial transition

TCGA-CESC - The Cancer Genome Atlas Cervical Squamous
Cell Carcinoma and Endocervical Adenocarcinoma

TME - tumour microenvironment

TZ - transformation zone




#pagebreak()

#heading(level: 1, numbering: none)[Introduction]

Cervical cancer typically arises from persistent infection with high-risk human papillomavirus, leading to cellular changes in the cervical epithelium. These cells can turn cancerous, disseminate from the primary site and spread across the body @NCCN2024CervicalPatient. Epithelial-mesenchymal transition (EMT) is a biological process through which epithelial cells acquire mesenchymal characteristics, including increased motility and invasive ability. The EMT pathway is regulated by transcription factors such as SNAIL, TWIST and ZEB, and has been implicated in tumour progression, metastasis and therapy resistance @tomecka_factors_2024. While many cervical cancer cases can be treated when detected early, lymph node metastasis remains as a major adverse prognostic factor among cervical cancer patients @Garcia-Becerra23. This highlights the need for improved diagnostic markers.

Several studies have evaluated EMT-associated gene expression and EMT-based scores as prognostic markers in gynaecological cancers, such as endometrial and ovarian cancer @yu_emt-related_2023@Pan2020SixGeneOC@Tan2014EMTSpectrum. These studies often report associations with overall survival; however, findings are frequently based on optimized gene signatures that may limit biological interpretability. In cervical cancer, such research is very limited, partly due to the lack of availability of well-annotated datasets with survival information. Therefore, it remains unclear whether the EMT program is associated with survival in cervical cancer, and to what extent such associations may be influenced by tumour microenvironmental factors. The aim of this thesis was to evaluate whether an EMT score, defined as the mean z-score of genes in the Hallmark EMT gene set @Liberzon2015MSigDBHallmark, is associated with overall survival in cervical cancer patients.

#pagebreak()

= Literature review
== The biology behind cervical cancer

In 2022, the age-standardized incidence of cervical cancer (CC) in Europe was 10.6 per 100 000 women @iarc_cancertoday_cervix_asr2024. Infection with high-risk human papillomavirus (HPV) genotypes, predominantly types 16 and 18, is the main causal factor in cervical cancer development. HPV infects the undifferentiated basal cells of the cervical squamous epithelium and lead to cellular alterations in cervical tissue referred to as precancerous lesions or cervical intraepithelial neoplasias (CIN) @Garcia-Becerra23.
The most common histological subtype is squamous cell carcinoma, arising from the stratified squamous epithelium of the ectocervix, followed by adenocarcinoma, which originates from the glandular epithelium of the endocervix. Mixed tumours containing both squamous and adenocarcinoma cells are referred to as adenosquamous carcinomas @NCCN2024CervicalPatient.
Precancerous lesions develop in the region between the ecto- and endocervix,  the transformation zone (TZ) (@TZ), and are the result of oncoproteins (E5, E6, E7) disrupting tumour suppressor pathways and promoting proliferative signalling @Wloszek2025HPVCervicalUpdates.

#figure(
  image("images/TZ.png", width: 80%), caption: [Schematic of the cervical transformation zone. @Deng2018HPV16TZ]
) <TZ>


Lymph node metastasis (LNM) is a major adverse prognostic factor in CC patients. For metastasis to occur, cancer cells need to have cellular plasticity to spread and adapt to the changing environment. One such mechanism is epithelial-mesenchymal transition (EMT), during which epithelial cells change into a mesenchymal cell type. EMT is reversible and the disseminated tumour cells may undergo mesenchymal-epithelial transition (MET) to enable spreading to secondary sites (@EMT) @Garcia-Becerra23. EMT can occur in three different contexts: type 1 during embryogenesis, type 2 during wound healing and inflammation, and type 3 in cancer, where it contributes to metastasis and cancer stem cell traits #cite(<qureshi_emt_2015>).

#figure(
  image("images/EMT.png", width: auto), caption: [Epithelial-mesenchymal transition and mesenchymal-epithelial transition. @Garcia-Becerra23]
) <EMT>

== Epithelial to mesenchymal transition (EMT) in cervical cancer

EMT is a dynamic and reversible process characterized by phenotypic changes in epithelial cells. Epithelial cells have apical-basal polarity and are connected via intercellular junctions. These characteristics prevent cell motility. In cancer, tumour epithelial cells can gain invasive ability by down-regulating cell-cell adhesion molecules and up-regulating markers that lead to spindle-shaped cells with increased motility @Lee2012EMTCervical.

One of the most important molecules down-regulated in this process is E-cadherin, which is responsible for cell polarity and regulates many pathways linked to the epithelial phenotype. E-cadherin is connected to the actin cytoskeleton with α-, β-, γ-catenin, and protein p120; together they form the adherens junction. On the contrary, markers like vimentin, fibronectin and N-cadherin are up-regulated. Vimentin is a component of the cytoskeleton, fibronectin is an extracellular matrix glycoprotein that regulates cell attachment and migration, while N-cadherin promotes angiogenesis @tomecka_factors_2024.

Down-regulation of these molecules is driven by Snail superfamily transcription factors such as Snail1 (Snail) and Snail2 (Slug), Twist family proteins, and zinc-finger E-box-binding homeobox factors ZEB1 and ZEB2 @Debnath2021EMTfactors. Expression of the viral oncoprotein E7 has been shown to induce a mesenchymal phenotype in keratinocytes, suggesting that persistent infection with high-risk HPV strains could induce EMT in cervical cells @Lee2012EMTCervical.

=== Transcriptional regulation of EMT

As mentioned above, EMT is primarily controlled by transcription factors that repress epithelial gene expression and activate mesenchymal gene expression. Regulators include Snail1/2, Twist1/2 and ZEB1/2, as well as FOX and SOX. The Snail family down-regulates E-cadherin by binding to the E-box motifs of target gene promoters @tomecka_factors_2024.

In cervical cancer, elevated expression of Snail1 has been observed in HPV-associated tumours compared with normal cervical tissues, suggesting its potential utility as a diagnostic marker @farzanehpour_comparison_2020. Like Snail, Slug functions as a transcriptional repressor of E-Cadherin and Epithelial Cell Adhesion Molecule (EpCAM), thereby enhancing cell migration and invasiveness of cervical cancer cells @liu_absence_2021.

Similarly, members of the Twist family regulate mesenchymal differentiation; studies have shown that positive Twist expression is associated with unfavourable prognosis in cervical cancer patients @shibata_twist_2008. Twist2, an isoform of Twist, was shown to have a significantly larger effect on EMT than Twist1 in human cervical cancer cells in a 2014 study @wang_twist2_2014.

ZEB1's over-expression in carcinomas induces EMT; like Snail, it suppresses E-Cadherin and other genes important in epithelial cell polarity. Nuclear expression of ZEB1 in squamous cervical carcinomas is positively associated with advanced FIGO stages and lymph node metastasis @chen_nuclear_2013. In addition to these regulators, other transcription factor families such as FOX and SOX can modulate EMT by regulating expression of mesenchymal markers or by influencing the activity of Snail @tomecka_factors_2024.


=== Signalling pathways regulating EMT

EMT is induced by several different signalling pathways which activate the abovementioned transcriptional factors.

Transforming growth factor-β (TGF-β) can have context-dependent effects in healthy and cancer cells. In healthy tissues TGF-β primarily acts as a tumour suppressor by inducing cell cycle arrest and apoptosis. However, during cancer progression the tumour suppressor function is eliminated by loss-of-function mutations in the receptor kinase or SMAD genes, allowing TGF-β signalling to instead promote tumour progression and EMT  @Gal2008TGFBEMT. TGF-β acts as an EMT inducer through SMAD-dependent transcriptional regulation of EMT-associated transcription factors. SMAD complexes induce the activity of regulators like Snail1/2, ZEB1/2 and Twist @Lamouille2014EMTMechanisms.
In addition to SMAD-dependent signalling, TGF-β can induce EMT-related gene expression through SMAD-independent pathways, such as PI3K/Akt, Ras/Raf and p38 MAPK signalling @tomecka_factors_2024.

The canonical Wnt/β-catenin signalling pathway regulates EMT by inhibiting the GSK3β kinase which increases Snail stability @Lamouille2014EMTMechanisms. The two pathways are both associated with lymph node metastases in early-stage CC patients, in one study, enrichment of the TGF-β pathway is  associated with node-negative disease, whereas activation of the β-catenin pathway was associated with node-positive disease @Maartje2011TGF.

Inflammatory cytokines and growth factors that induce EMT are essential for the ability of cancer cells to remain in a mesenchymal state @tomecka_factors_2024. One of the most important cytokines implicated in cervical carcinomas is IL-6. It activates STAT3 in cervical cell lines and leads to altered cell morphology, down-regulation of E-cadherin and up-regulation of vimentin, similar to mesenchymal cells. This suggests that STAT3 signalling may be a potential experimental target for modulating EMT-like behaviour in cervical carcinoma @miao_interleukin-6-induced_2014.

Similarly, a 2008 study showed that epidermal growth factor (EGF) signalling induces a mesenchymal cell phenotype, decreased the amount of E-cadherin and β-catenin and increased the abundance of vimentin and fibronectin. These changes may be caused by the increase in Snail abundance in the nuclei @lee_epithelial-mesenchymal_2008.

The Notch signalling pathway plays an important role in cell fate decisions, proliferation and apoptosis. Notch signalling promotes EMT and angiogenesis and plays a major role in cancer progression @Ranganathan2011. Levels of Jagged1, the ligand of the Notch receptor, are increased in invasive cervical squamous cell carcinomas @Veeraraghavalu2005HPVNotch.


=== Additional molecular regulators of EMT

AEG-1 is overexpressed in many human malignancies and is associated with poor clinical outcomes. In CC cells, AEG-1 knockdown reduces NF-κB p65 activity, thereby decreasing EMT and increasing sensitivity to anticancer drugs in vitro. These findings suggest that targeting AEG-1 may represent a potential therapeutic strategy in CC @liu_knockdown_2014.
Members of the STAR  (signal transducer and activator of RNA) family proteins, such as Sam68, are involved in RNA metabolism, alternative splicing and signal transduction. Similar to AEG-1, Sam68 contributes to tumour metastasis. Its overexpression and cytoplasmic localization are significantly associated with pelvic lymph node metastasis in CC. Conversely, Sam68 downregulation inhibits Akt/GSK-3b/Snail pathway and reverses EMT @li_sam68_2012.

In addition to inducing Snail expression, EGF signalling also promotes the expression of FTS (Fused Toes Homolog) via the EGFR/ERK/ATF-2 pathway. ATF-2 accumulates in the nucleus and increases FTS mRNA expression, while FTS silencing significantly inhibits CC cell motility and invasion @muthusami_egf-induced_2014. Another EGF-induced protein, TACC3, is involved in centrosome/microtubule dynamics and is overexpressed in CC cell lines. TACC3 promotes EMT-associated morphological changes and Snail overexpression, whereas its absence suppresses EMT marker expression @Ha2013.

Fibulin-4 (EFEMP2), an extracellular matrix (ECM) protein, regulates cell adhesion and invasion and has been implicated in tumour progression via the Raf/MEK/ERK pathway. EFEMP2 is highly expressed in CC tissues, particularly in the highly invasive CC cells. Its downregulation increases E-cadherin levels while reducing N-cadherin, vimentin and mesenchymal transcription factors (Snail, Slug, Twist, Zeb2). EFEMP2 upregulates multiple Matrix-metalloproteinases (MMP-1, MMP-13, MMP-3, and MMP-10) @li_efemp2_2022, which are associated with increased tumour cell invasion and motility @Lin2011.

Citrate Synthase (CS) regulates energy production in mitochondrial respiration by catalyzing the first reaction of the tricarboxylic acid (TCA) cycle. Reduced CS expression in CC cell lines induces EMT and correlates with increased malignancy. This reduction promotes glycolytic metabolism (Warburg effect) and activates AMPK/p38 MAPK and ERK1 signalling, leading to increased glucose uptake and lactate dehydrogenase activity. CS inhibition also downregulates p53, while reactivation of p53 or ATP supplementation reverses the EMT phenotype @lin_loss_2012.

P4HA2 is significantly overexpressed in CC tissues and cell lines compared to normal controls. Its over-expression is associated with shorter overall and relapse-free survival, increased lymph node metastasis, more advanced FIGO stage, and enhanced EMT-related gene signatures. Knockdown of P4HA2 reduces migration and invasion and  decreases mesenchymal markers such as vimentin and N-cadherin @cao_p4ha2_2020.

As described previously, TGF-β is a cytokine that can induce EMT in CC cells. During TGF-β–mediated EMT, FAD104 expression is upregulated in CC cell lines (HeLa and CaSki). However, its downregulation increases the migratory capacity of CC cells, suggesting that FAD104 acts as a suppressor of TGF-β-induced EMT and its loss may contribute to tumour progression @goto_fad104_2017.

==== MicroRNAs as regulators of EMT

Many microRNAs (miRNAs) and other non-coding RNAs have potential to be novel biomarkers for CC diagnosis. miRNAs regulate gene expression by binding to the 3'-UTRs of mRNAs, leading to mRNA degradation and translation suppression. Through this mechanism, they can promote or inhibit EMT in CC @wang_role_2019. Only a subset of non-coding RNAs implicated in CC progression is highlighted here.

Sema4C downregulation reverses EMT in CC cell lines (Caski), as evidenced by increased E-cadherin and decreased vimentin and Snail expression. miR-31-3p, directly targets Sema4C and is significantly down-regulated in CC tissues and cells. Its overexpression inhibits Sema4C and reverses EMT @jing_sema4c_2019.

Downregulation of miRNA-145 is associated with poor prognosis in CC patients. Functionally, miR-145 directly targets ZEB2, resulting in increased E-cadherin expression and reduced levels of vimentin and Snail @sathyanarayanan_microrna-145_2017.  Similarly, miRNA-218 is downregulated in CC tissues compared to normal cervical tissue. Its overexpression increases E-cadherin and decreases N-cadherin, thereby inhibiting migration and invasion @jiang_microrna-218_2016.

miRNA-200b is also downregulated in invasive CC tissues and suppresses EMT by targeting ZEB1 and ZEB2, leading to increased E-cadherin expression and reduced vimentin and MMP-9 levels @cheng_microrna-200b_2016

Finally, TGF-β signalling also regulates the circular RNA CDR1as. Its overexpression is associated with lymph node metastasis, poorer survival, and increased Slug expression @zhong_tgf-_2023.

== The tumour microenvironment: partial EMT, stemness and immune evasion
The tumour microenvironment (TME) is composed of stromal cells and immune cells within the ECM that dynamically interact with tumour cells. Progressive tumour development remodels the TME towards an immunosuppressive environment that facilitates immune evasion, invasion, and metastasis. Crosstalk between cancer cells and the TME induces EMT by epigenetic reprogramming of transcription factors, like Snail, Twist and ZEB family. This in turn promotes further TME reconstruction, reinforcing tumour progression and resistance to therapy @xie_epithelial-mesenchymal_2025.

In CC, the tumour microenvironment is shaped by persistent high-risk HPV infection, stromal estrogen receptor α (ERα) activation, hypoxia, and the presence of stromal and immune inflammatory cells such as cancer-associated fibroblasts (CAFs), tumour-associated macrophages (TAMs), myeloid-derived suppressor cells (MDSCs), T cells, and neutrophils. CAFs play a central role in shaping an immunosuppressive microenvironment, secreting mediators to promote immune evasion. In CC, CAFs have been shown to promote lymphatic metastasis by disrupting lymphatic endothelial barrier integrity through signalling pathways such as integrin–FAK/Src–VE-cadherin, thereby enabling tumour cell entry into lymphatic vessels and enhancing EMT-driven invasion @Wang2023TMECC.

These microenvironmental signals do not always induce a complete EMT process, cells can display features of both epithelial and mesenchymal states. This hybrid state is referred to as epithelial-mesenchymal plasticity (EMP). Hybrid cells often show high adaptive potential similar to stem cells (@stemness) @VERSTAPPE202315 and are frequently associated with cancer stem cells (CSC). CSCs are slow-cycling cells with stem-like properties and are associated with a poor response to chemo- and radiotherapy. In CC, CSCs contribute to an increased risk of lymph node metastasis and pelvic recurrence and markers of CSCs are co-expressed with EMT-associated markers @di_fiore_cancer_2022.

#figure(
  image("images/stemness.jpg", width: 80%), caption: [The EMT axis: hybrid cells have a higher probability to acquire stem-like properties @VERSTAPPE202315]
) <stemness>


== EMT-related gene signatures and prognostic associations in gynaecological cancers

Several studies have researched the potential of EMT-related gene signatures to be prognostic markers for gynaecological cancer. Pan et al. analyzed transcriptomic data from The Cancer Genome Atlas (TCGA) ovarian cancer cohort and constructed a six-gene EMT-based risk score that split patients into low- and high-risk groups. The groups had significantly different overall survival (OS) and the risk score remained an independent prognostic factor in multivariate Cox analysis (AUC ≈ 0.711 - 0.776) @Pan2020SixGeneOC.

A similar EMT-based multi-gene risk score model was reported in a 2023 study, where patients in the low-risk group exhibited significantly better OS than those in the high-risk group. Additional analyses suggested differences in immune cell composition between risk groups @Li2023EMTGeneSignature.

EMT-based prognostic modeling has also been explored in endometrial cancer. A four-gene EMT-related risk signature was identified as an independent prognostic factor in multivariate Cox regression analysis (HR = 2.002). Network and enrichment analyses showed that genes co-expressed with the four EMT genes were enriched in extracellular matrix organization and mesenchymal development, which are processes related to EMT driven cancer progression @yu_emt-related_2023.

Compared with ovarian and endometrial cancer, prognostic transcriptomic modelling in cervical cancer remains relatively limited. One practical limitation is the restricted availability of large, publicly accessible cohorts with matched transcriptomic profiles, overall survival information and clinical annotations other than TCGA-CESC. This limits the opportunities for robust external validation and increases the risk of overfitting in single-cohort studies.

Kumari et al. (2025) identified eight EMT-associated hub genes derived from differential expression analysis and evaluated their prognostic relevance in cervical cancer. Among these, CDH2 (N-cadherin) showed the highest hazard ratio (HR ≈ 2.1), suggesting an association between mesenchymal phenotype and poorer survival @Kumari2025EMTCervical.

Together, these studies suggest that EMT-related transcriptional signatures can carry prognostic information in some gynaecological cancer cohorts.


=== Quantitative EMT scoring and clinical outcome associations

As discussed above, EMT is a dynamic process, exhibiting hybrid epithelial-mesenchymal states. EMT gene signatures comprised a small number of genes may not capture the complex transcriptional program of the EMT pathway. Larger signatures allow for EMT scoring which models EMT like a continuum.

Quantitative EMT scoring approaches derived from transcriptomic signatures have been proposed and shown to associate with survival in several cancers, including ovarian cancer. Patients with ovarian cancer showing a more epithelial-like phenotype showed better OS in a 2014 study. In that work a directional EMT score was developed using a two-sample Kolmogorov–Smirnov (2KS) statistic to compare epithelial (n = 145) and mesenchymal (n = 170) gene sets within each tumour sample. Notably, however, the prognostic relevance of EMT status was not consistent across all cancer types analysed @Tan2014EMTSpectrum.

Gibbons et al. showed that a 16-gene directional EMT score, consisting of 13 mesenchymal and 3 epithelial marker genes, was significantly associated with worse outcome independent of cancer type ($p lt 1 times 10^(-15)$) in a pan-cancer analysis. It should be noted that they tested another EMT gene signature score, which was not associated with worse outcome. The authors speculate that this could be due to the gene signature being more specific to lung cancer @Gibbons2017PanCancerEMT. This shows that gene signatures behave differently and cannot be generalised across cancers.

Even with directional EMT scoring methods, hybrid epithelial-mesenchymal states remain complicated to model. George et al. developed an inferential model based on iterative multinomial logistic regression (MLR), trained on labelled epithelial, hybrid, and mesenchymal samples, to estimate the probability of each phenotype and derive an EMT score. Their analyses demonstrated that the association between a hybrid phenotype and patient survival was cancer subtype specific. In ovarian cancer, the prognostic impact of the hybrid E/M phenotype was inconsistent across cohorts, with hybrid tumours associated with either improved or poorer overall survival @George2017PartialEMT.

=== Stromal and environmental signals in bulk transcriptomics

EMT-gene signatures may not always reflect cancer cell gene expression properties. Patient samples can have differences in cell composition and cancer cell content, making gene expression signatures dependent on the TME composition. Many studies have found that sample fibroblast content contributes to the mesenchymal gene expression signature, meaning that EMT scores may reflect tumour purity and stromal composition. Kreis et al. looked into the relationship between EMT-gene signatures and cell type composition of tumour samples, using both bulk RNA-seq and single cell RNA-seq data. They found a strong negative correlation between EMT scores and cancer cell content. Additionally, EMT signals were weaker in cancer cell models lacking stromal cells. Single-cell analysis revealed that EMT signature expression was highest in stromal cell types rather than malignant epithelial cells @Kreis2024stromal.

In a study published in 2021, Tyler et al. analyzed EMT gene expression in single-cell and bulk RNA-seq data and found that many classical EMT-related genes were expressed more strongly in CAFs than cancer cells. The subset of  EMT genes expressed in cancer cells represented partial EMT programs that differed between cancer types and were not significantly associated with clinical features of the patients @Tyler2021DecouplingEMT.

These findings indicate that stromal content in patient samples can drive EMT signals in bulk transcriptomic data, making the importance of accounting for tumour purity clear when analyzing EMT-related gene expression.

#pagebreak()

= Experimental section
== Objectives of the study

The primary objective of this thesis is to model the association between EMT score and overall survival in cervical cancer patients with primary tumours using a Cox proportional hazards model and evaluate its predictive performance. A secondary objective is to determine whether gene expression profiles and EMT pathway activity differ between cervical cancer tissue and normal cervical tissue.

== Materials and methods
=== Data sources for differential expression analysis

RNA-sequencing gene-level raw integer counts were obtained from the recount3 resource @Wilks2021recount3 via Bioconductor @Huber2015Bioconductor. Differential expression analysis (DEA) was performed using data from The Cancer Genome Atlas Cervical Squamous Cell Carcinoma and Endocervical Adenocarcinoma (TCGA-CESC) cohort @TCGA2017CervicalCancer and normal cervical tissue samples (endocervix and ectocervix) from the Genotype-Tissue Expression (GTEx) project @GTEx. Only primary tumour samples were included from the TCGA-CESC cohort.

=== Preprocessing and gene filtering for differential expression analysis

The TCGA-CESC count matrix contained 63856 annotated genomic features and 304 primary tumour samples. The GTEx CERVIX-UTERI count matrix contained 63856 annotated genomic features across 19 normal endocervix and ectocervix samples. Differential expression analysis (DEA) and gene set enrichment analysis (GSEA) were performed in R 4.5.2. DEA was conducted using the Bioconductor package DESeq2 (version 1.50.2) @DESeq2.
To merge the datasets, Ensembl ID version numbers were stripped. After merging, the data comprised 63856 annotated genomic features across 323 samples. A #raw("DESeqDataSet") was made using #raw("DESeqDataSetFromMatrix"); the condition factor was defined with normal tissue as the reference level (tumour vs. normal).
Prior to differential expression model fitting, genomic features with fewer than 10 total reads across all samples were filtered out. After filtering, 56654 genomic features remained for analysis. DESeq2 normalization was performed using the median-of-ratios method, and gene counts were modeled using a negative binomial distribution. Differential expression was assessed using Wald tests, and p-values were adjusted for multiple testing using the Benjamini–Hochberg false discovery rate (FDR) procedure. The full differential expression results table is provided as supplementary material (Supplementary material: Table 1).


=== Data sources and methods for gene set enrichment analysis

Hypothesis-driven GSEA was performed using the MSigDB #raw("HALLMARK_EPITHELIAL_MESENCHYMAL_TRANSITION") human gene set (version 2025.1) @Liberzon2015MSigDBHallmark and fgsea (multilevel algorithm; #raw("minSize") = 15 and #raw("maxSize") = 500) @fgsea. Genes were ranked by DESeq2 Wald statistic for tumour vs. normal and Ensembl IDs were mapped to HGNC gene symbols using #raw("org.Hs.eg.db") @org.Hs.eg.db. Genes that failed mapping were removed and the largest absolute value per duplicated symbol was retained.

=== EMT scoring and survival analysis

Data processing and Cox proportional hazards model fitting was done with Python 3.12.3. A survival table with a time and event column was constructed using #raw("tcga.gdc_cases.diagnoses.vital_status"), #raw("tcga.gdc_cases.diagnoses.days_to_death") and #raw("tcga.gdc_cases.diagnoses.days_to_last_follow_up") columns from the TCGA-CESC data. Overall survival time was defined as the number of days from diagnosis to death or last clinical follow-up. Death was treated as the event of interest, while patients who were alive at the last follow-up were treated as right-censored. The event was coded as 0 for censored and 1 for death. Patients with zero recorded follow-up time were excluded from survival analyses. Only samples with available survival information and corresponding EMT scores were retained for downstream modeling.

For EMT scoring, Ensembl gene IDs were stripped of version numbers and gene expression values were normalized separately using log2 counts per million (logCPM). The Hallmark EMT human gene set was mapped to Ensembl IDs in R using #raw("org.Hs.eg.db"). All 200 genes were mapped successfully. The normalised gene expression matrix was subset to Hallmark EMT genes, after which 200 genes and 304 samples remained. For each EMT gene, expression values were standardised across samples by subtracting the gene-wise mean and dividing by the gene-wise standard deviation. For each sample, the EMT score was then calculated as the mean of gene-wise z-scores across EMT genes. The sample-level EMT scores were then standardised across samples before Cox model fitting, so hazard ratios correspond to a one-standard-deviation increase in EMT score.  Only samples present in both expression and survival datasets were retained. With 220 censored and 71 death events, a Cox proportional hazards regression model was fitted using the lifelines library @DavidsonPilon2024lifelines with EMT as a covariate.

For the second model with two covariates, tumour purity was estimated from the TCGA metadata variable #raw("tcga.cgc_slide_percent_stromal_cells"). Purity was defined as 100 - stromal percentage and divided by 10, so that the hazard ratio corresponds to a 10% change in tumour purity. The input for the model is included in the supplementary material (Supplementary material: Table 2).
Of the 291 patients with available survival and EMT data, 285 had documented FIGO stage. A third penalized Cox proportional hazards model was fitted (#raw("penalizer")=0.01), FIGO stage was included as a categorical variable and encoded using one-hot encoding. Stage I was used as the reference category and indicator variables were created for stages II, III and IV. The input for the EMT score + FIGO stage model is included in the supplementary material (Supplementary material: Table 3).
Baseline hazard estimation method was Breslow. Proportional hazards assumption assessment was done using scaled Schoenfeld residuals.

Kaplan-Meier survival curves were plotted and log-rank test conducted using the lifelines library @DavidsonPilon2024lifelines. Visualisation was done with Python using the matplotlib library @Hunter:2007. For @Kaplan-Meier patients were stratified into two groups using the median EMT score as the cut-off value. Samples with EMT scores above the median were assigned to the high EMT group, while EMT scores at or below the median were assigned to the low EMT group. Additional Kaplan-Meier survival curves were plotted (@Kaplan-Meier_2) using Cox model-derived risk groups. For each patient, the linear predictor (log partial hazard) from the fitted Cox proportional hazards model was calculated. Patients were then divided into tertiles according to their predicted log partial hazard, corresponding to low-, intermediate-, and high-risk categories.

Internal validation of the Cox proportional hazards model was performed using bootstrap resampling to estimate optimism-corrected discriminative performance. 1000 bootstrap samples were generated by resampling patients with replacement. For each bootstrap sample, the Cox model was refitted using the same covariate specification and model discrimination was assessed using the concordance index (C-index) on both the bootstrap sample and the original dataset. Optimism was estimated as the mean difference between bootstrap and test C-index values across resamples, and the apparent C-index was corrected by subtracting this estimated optimism.

== Results
=== Gene expression differences between tumour and normal tissue

Out of 56654 genes tested, 27669 were significantly differentially expressed at an FDR < 0.05. Of these 14702 genes were upregulated and 12967 were downregulated in tumour samples relative to normal tissue. The dispersion estimates for the fitted model are shown in supplementary material (Supplementary material: Figure 6). When applying an additional effect-size filter of absolute log2 fold change ≥ 1, 20,549 genes remained significantly differentially expressed, including 10,820 upregulated and 9,729 downregulated genes.
Principal Component Analysis (PCA) was performed on variance-stabilized gene expression values (@PCA). There is clear separation between tumour and normal samples along the first principal component, which explains 29% of the variance. Likely reflecting transcriptional differences between the two tissue types and datasets.

#figure(image("images/PCA (1).png", width: 80%), caption: [Principal Component Analysis of variance-stabilized gene expression values],) <PCA>


The MA plot (@MAplot) shows that the majority of genes are centered around log2 fold change of zero across the range of mean expression values, consistent with appropriate normalization and model fitting. The volcano plot (@Volcano) shows a large number of genes with large fold changes and strong statistical support.
Together, these results show gene expression differences between TCGA-CESC and GTEx cervix datasets. To contextualise these changes with respect to EMT, further pathway-level analyses were performed.

#figure(
  image("images/MA_plot.png", width: auto), caption: [MA plot of differential gene expression between tumour and normal tissue],
) <MAplot>

#figure(
  image("images/Volcano_plot (1).png", width: auto), caption: [Volcano plot of differential gene expression results],
) <Volcano>

=== EMT activation: gene set enrichment analysis
To interpret these gene-level changes in a biological context, gene set enrichment analysis was performed with the 200-gene EMT gene set. Genes with positive Wald statistics are upregulated in tumours, whereas negative values indicate higher expression in normal tissue. Gene set enrichment analysis using fgsea showed significant negative enrichment of the Hallmark EMT gene set in tumours relative to normal tissue (NES = -1.66 and FDR = 6.52e−06). As seen on @ESplot, the running enrichment score shows significant negative enrichment. @leadinggenes shows the top genes significantly enriched in normal cervical tissue. The full table for leading EMT genes driving the enrichment score is included in supplementary material (Supplementary material: Table 4). These results indicate that EMT-associated transcripts are enriched in normal cervical tissue relative to tumour tissue. However, because tissue condition is confounded with data source, this enrichment should be interpreted as an exploratory cross-dataset contrast rather than a tumour-specific effect.


#figure(
  image("images/gsea_ES_plot2.png", width: 75%), caption: [GSEA enrichment plot for the MSigDB Hallmark epithelial-mesenchymal transition gene set using genes ranked by DESeq2 Wald statistic (tumour vs normal).],
) <ESplot>


#figure(
  image("images/leading_15.png", width: 75%), caption: [Top 15 genes enriched in normal cervical tissue ranked by Wald statistic]
) <leadinggenes>


=== EMT score is associated with survival

The Cox proportional hazards regression showed that a higher EMT score was significantly associated with worse overall survival (HR = 1.32 per SD increase, 95% CI 1.06 - 1.66, p = 0.01), with the concordance index being 0.6, showing modest discrimination. Bootstrap validation (B = 1000) estimated minimal optimism (0.003), yielding an optimism-corrected C-index of 0.60. The proportional hazards assumption was assessed using scaled Schoenfeld residuals and was not violated (Supplementary material: Figure 1).

The Kaplan-Meier survival curves suggested that the higher EMT group is associated with worse overall survival compared to the low EMT group, which was supported by a log-rank test (p ≈ 0.016) (@Kaplan-Meier). The Kaplan-Meier survival curves with risk groups constructed with the linear predictors derived from the fitted Cox model also suggested worse overall survival for the high-risk group compared to the mid and low risk groups. Differences between the groups were supported by the multigroup log-rank test (p ≈ 0.003) (@Kaplan-Meier_2).

The plots for distribution of EMT scores across samples (Supplementary material: Figure 4) and survival status are shown in supplementary material (Supplementary material: Figure 5). Despite the EMT score being associated with survival, no significant differences were observed (p=0.98) in EMT score across FIGO stages (I-IV) (@EMTbyFigo). However, this does not exclude potential confounding.

#figure(
  image("images/Kaplan.png", width: 80%), caption: [Kaplan-Meier survival by EMT group. p≈0.016 with log-rank test],
) <Kaplan-Meier>

#figure(
  image("images/Kaplan_risk.png", width: 80%), caption: [Kaplan-Meier survival by Cox predicted risk tertiles. Patients were stratified into tertiles based on the linear predictor to visualise differences in survival. p≈0.003 with multigroup log-rank test]
) <Kaplan-Meier_2>

#figure(
  image("images/EMTbyFIGO.png", width: 80%), caption: [A boxplot showing how the EMT score associates with FIGO stage. No association is observed. Kruskal-Wallis p-value = 0.98]
) <EMTbyFigo>

=== Tumour purity does not change EMT score association with survival

Since EMT-related gene expression signatures in bulk RNA-seq data may be influenced by tumour purity and stromal cell content @Kreis2024stromal, tumour purity estimates were included as a covariate in the Cox proportional hazards model. Even with the tumour purity estimate as a covariate, the EMT score was still significantly associated with worse overall survival (HR = 1.32 per 1 SD increase, 95% CI 1.06 - 1.65, p = 0.01), with the concordance index remaining unchanged (0.6). Tumour purity was not associated with overall survival (HR = 0.95 per 10% increase, 95% CI 0.78 - 1.17, p = 0.65). The proportional hazards assumption was assessed using the Schoenfeld residual tests, which was not violated (Supplementary material: Figure 2). Bootstrap validation of the two covariate model yielded an optimism-corrected C-index of 0.58.



===  FIGO stage does not change EMT score associations with survival

As mentioned earlier, the fact that EMT score was not associated with FIGO stages does not exclude potential confounding in survival analysis. With that in mind, FIGO stage was included as a covariate in the Cox proportional hazards model. Although HR did drop slightly, higher EMT scores were still associated with worse overall survival (HR = 1.28 per 1 SD increase, 95% CI 1.02 - 1.59, p = 0.03) after adjustment for FIGO stage, suggesting that the association between EMT score and survival is not fully explained by FIGO stage in this dataset. Stage II and III were not significantly associated with worse overall survival compared to Stage I, but as expected, Stage IV disease was significantly associated with worse overall survival compared to Stage I (@COX3). The concordance index for the model was 0.68, suggesting modest discrimination. Bootstrap validation of the model yielded an optimism-corrected C-index of 0.66. The proportional hazards assumption was assessed using Schoenfeld residuals. A deviation from proportional hazards was observed for FIGO stage IV, suggesting a potential time-dependent effect (Supplementary material: Figure 3).

#figure(
  table(
    columns: 4,
    align: (left, center, center, center),

    table.header(
      [Variable], [HR], [95% CI], [p]
    ),

    [EMT], [1.28], [1.02–1.59], [0.03],
    [FIGO II], [0.78], [0.41–1.51], [0.47],
    [FIGO III], [1.35], [0.68–2.69], [0.4],
    [FIGO IV], [3.97], [2.13–7.37], [< 0.001],
  ), caption: [Cox proportional hazards model results including EMT score and FIGO stage.]
) <COX3>



#pagebreak()
== Discussion

The aim of this thesis was to evaluate whether an EMT score, defined as the mean z-score across 200 EMT-related genes, is associated with overall survival in patients with CC. The results indicate that EMT score is significantly associated with worse survival (HR = 1.32 per SD increase, 95% CI 1.06 - 1.66, p = 0.01), and this association remained after adjusting for tumour purity and FIGO stage, with only slight reduction in effect size when adjusting for FIGO stage (HR = 1.28 per 1 SD increase, 95% CI 1.02 - 1.59, p = 0.03). These findings are consistent with previous research reporting associations between EMT-related gene expression and survival in gynaecological cancers. Biologically, this may reflect the role of EMT in promoting cellular plasticity, invasion and metastatic dissemination.

However, some studies report inconsistent associations. As mentioned in the "Quantitative EMT scoring and clinical outcome associations" chapter, Gibbons et al. observed that a literature-derived EMT score was not consistently associated with worse survival across all cancer types @Gibbons2017PanCancerEMT. This suggests that the prognostic relevance of EMT may be context-dependent and influenced by tumour type or the method used to quantify EMT.

One apparent methodological difference in this thesis compared to much of the existing literature is the use of a predefined gene set rather than an optimized gene signature. Many studies construct EMT-based risk models by selecting genes through DEA and univariate Cox regression, often followed by penalized regression methods. In contrast, the EMT score used here was based on the full Hallmark EMT gene set, aiming to capture the pathway as a whole rather than a subset of genes.

An unexpected finding was the significant negative enrichment of the Hallmark EMT gene set in tumour samples compared to normal cervical tissue. This may be explained by differences in cellular composition between the datasets. Several genes contributing to the enrichment signal, such as CXCL12, ACTA2, DCN and TAGLN, are associated with stromal or microenvironmental components. CXCL12 is a stromal chemokine expressed by fibroblasts @guo2016cxcl12, while ACTA2, encoding smooth muscle α actin, expression is associated with smooth muscle cells and myofibroblasts @rockey2013acta2. DCN, encoding decorin, is an extracellular matrix protein involved in ECM assembly @zhang2018decorin and TAGLN is expressed in activated fibroblasts @wang2026transgelin. This suggests that the apparent enrichment of EMT-associated genes in normal cervical tissue may partly reflect greater stromal cell content.

It is therefore plausible that normal cervical tissue samples, particularly those from GTEx, contain a higher proportion of stromal cells, which could drive the apparent enrichment of EMT-related genes. This finding is not necessarily contradictory to the survival analysis results. The GSEA compared tumour and normal tissues across datasets and is therefore sensitive to differences in tissue composition and batch effects, whereas the survival analysis examined variation in EMT-related expression within the TCGA-CESC dataset. Consequently, the two analyses address different biological and methodological questions.

The decision not to restrict the EMT gene set to differentially expressed genes was also motivated by the observed GSEA results, where the Hallmark EMT gene set was enriched in normal cervical tissue. Filtering by differential expression in this context could bias the score and potentially exclude genes relevant to the EMT biology within tumour cells. Additionally, summarizing EMT as a single continuous covariate reduces model complexity and helps mitigate overfitting, which is important given the limited number of events in the cohort.

The EMT score for each sample was calculated as the mean of gene-wise z-scores, the resulting sample-level EMT scores were standardised so that Cox model hazard ratios could be interpreted per one standard deviation increase in EMT score. This approach was selected to allow each gene in the EMT gene set to contribute equally to the final score. Alternative EMT score constructions include the median of gene-wise z-scores or sample-level enrichment methods such as ssGSEA. A median-based score could reduce the influence of extreme values; however, it was not used in order to retain sensitivity to coordinated gene expression changes across the gene set. In contrast, ssGSEA-based approaches quantify pathway enrichment within each sample based on gene expression ranks rather than the average standardised expression of the EMT genes. ssGSEA was not used in order to preserve between-sample differences in expression magnitude.

Several limitations should be considered when interpreting the results of this study. First, the relatively small number of events (n = 71) limits statistical power and constrains the complexity of the survival models. In particular, this restricts the number of covariates that can be included without risking overfitting and may reduce the ability to detect more subtle associations. Second, the analysis was performed using a single cohort (TCGA-CESC), without external validation. As a result, the generalisability of the findings to independent datasets or clinical populations remains uncertain.

Third, the DEA and GSEA analyses were limited by both the small number of normal cervical tissue samples and the use of tumour and normal samples from different data sources. As a result, observed tumour–normal expression differences may reflect dataset-specific technical variation or differences in tissue composition, rather than true tumour-specific biological effects.

Fourth, although the EMT score remained associated with overall survival after adjustment for FIGO stage, the FIGO-adjusted model should be interpreted cautiously. Including FIGO stage as a categorical covariate increased the number of model parameters, while the number of observed events within individual FIGO stage groups was limited. In addition, the Schoenfeld residual analysis indicated a deviation from the proportional hazards assumption for Stage IV (Supplementary material: Figure 3), suggesting that the effect of advanced stage was not constant over time. Therefore, the model should not be interpreted as definitive evidence that EMT is prognostic independently of clinical stage.

An additional limitation relates to the estimation of tumour purity. In this study, tumour purity was approximated using the TCGA variable #raw("tcga.cgc_slide_percent_stromal_cells"), which is based on histopathological assessment. While this provides a useful proxy for stromal content, it is a potentially subjective measure compared to computational purity estimates derived from genomic data. Computational estimates could improve adjustment for tumour purity confounding. Consequently, residual confounding by tumour microenvironment composition cannot be excluded.

Finally, the use of bulk RNA-seq data limits the ability to distinguish between gene expression originating from tumour cells and that from stromal or immune components. Given that many EMT-related genes are also expressed in non-tumour cell populations, the EMT score used in this study may partially reflect microenvironmental signals rather than tumour-intrinsic EMT processes.

Overall, the EMT score showed a significant association with survival, although interpretation is influenced by limitations in accurately resolving tumour and microenvironmental signals.












#pagebreak()


#heading(level: 1, numbering: none)[Summary]

The aim of this study was to assess whether a transcriptomics-based EMT score is associated with survival in cervical cancer patients. Transcriptomic and clinical data from the TCGA-CESC dataset @TCGA2017CervicalCancer were used to construct an EMT score based on 200 Hallmark EMT genes @Liberzon2015MSigDBHallmark. Cox proportional hazards regression models were fitted with the EMT score as a covariate. Additional models including tumour purity and FIGO stage were used to assess whether the EMT score is an independent predictor of survival. Bootstrap internal validation was performed to estimate the optimism-corrected concordance index.

The results indicate that the EMT score is significantly associated with worse overall survival in cervical cancer. After adjustment for FIGO stage, a one standard deviation increase in EMT score was associated with a 28% higher hazard of death (HR = 1.28). The model demonstrated modest discrimination, with an optimism-corrected concordance index of approximately 0.66. This suggests that the EMT score retained prognostic information after adjustment for FIGO stage in this dataset.



#pagebreak()

#heading(level: 1, numbering: none)[Resümee]

Emakakaelavähk tekib tavaliselt kõrge riskiga inimese papilloomiviiruse (HPV) püsiva infektsiooni tagajärjel, mis põhjustab muutusi emakakaela epiteelirakkudes. Peamised histoloogilised alatüübid on lamerakuline kartsinoom ja adenokartsinoom, harvem esinevad ka adenoskvamoosne või neuroendokriinne vorm @NCCN2024CervicalPatient. Epiteel-mesenhümaalne üleminek (EMT) on protsess, mille käigus epiteelirakud omandavad mesenhümaalsed omadused, sealhulgas suurenenud liikuvuse ja invasiivsuse. Emakakaelavähi rakud võivad selle protsessi abil levida primaarsest kasvajakoldest ning anda siirdeid teistesse kehaosadesse, näiteks lümfisõlmedesse. Lümfisõlmede metastaasid on peamine surmapõhjus emakakaelavähi patsientide seas @Garcia-Becerra23.

Mitmed uuringud on hinnanud EMT protsessiga seotud geeniekspressiooni ja EMT geeniekspressiooni põhjal konstrueeritud skoore kui prognostilisi markereid günekoloogilistes vähkides, näiteks endomeetriumi- ja munasarjavähi korral. Sageli leitakse seos elumusega. Emakakaelavähi puhul on selliseid uuringuid väga vähe, peamiselt andmete kättesaadavuse piiratuse tõttu. Seetõttu ei ole selge, kas EMT protsess on seotud elumusega emakakaelavähi korral. Lisaks ei ole selge, kuivõrd mõjutavad neid seoseid kasvajamikrokeskkonna tegurid. Käesoleva töö eesmärk oli hinnata, kas EMT skoor, mis on defineeritud kui EMT geenikomplekti @Liberzon2015MSigDBHallmark kuuluvate geenide z-skooride keskmine väärtus, on seotud emakakaelavähi patsientide üldise elumusega.

Emakakaelavähi patsientide RNA-ekspressiooniandmed ja elumusandmed võeti TCGA-CESC andmestikust @TCGA2017CervicalCancer, et sobitada Coxi võrdeliste riskide mudel, kasutades EMT skoori ühe tunnusena. Tulemused näitavad, et EMT skoor on seotud halvema üldise elumusega (HR = 1.32 ühe standardhälbe suurenemise kohta, 95% CI 1.06 - 1.66, p = 0.01). Isegi pärast proovi puhtuse ja vähistaadiumi arvesse võtmist jäi EMT skoor sõltumatuks tunnuseks (HR = 1.28 ühe standardhälbe suurenemise kohta, 95% CI 1.02 - 1.59, p = 0.03).

Tulemuste tõlgendamisel tuleb arvestada mitmete piirangutega, sealhulgas väikese sündmuste (surmade) arvuga, ühe andmestiku kasutamisega ilma välise valideerimiseta, piiratud normaalse emakakaelakoe proovide hulgaga ning kasvajapuhtuse ja kasvajamikrokeskkonna mõju võimaliku alahindamisega. Nende piirangute valguses on võimalik, et EMT skoor ei peegelda ainult kasvajarakkude siseseid protsesse, vaid ka mikrokeskkonna signaale.

#pagebreak()

#bibliography("bibliography.bib")

#pagebreak()

#heading(level: 1, numbering: none)[Used artificial intelligence tools]

Artificial intelligence (AI) tools were used during this thesis to support selected stages of the research and data analysis workflow.

ChatGPT (GPT-5.5, OpenAI, 2026) was used during the programming and data analysis process for reviewing and improving R and Python code, identifying programming errors, explaining statistical methods and bioinformatics workflows, and assisting with optimization and restructuring of analysis scripts. The tool was also used for troubleshooting software-related issues and improving code readability and reproducibility. All analytical decisions, interpretation of results, and final implementation of the methods were independently verified by the author.

References:

OpenAI. (2026). ChatGPT (GPT-5.5) [Large language model]. #link("https://openai.com/index/introducing-gpt-5-5/")



#pagebreak()

#heading(level: 1, numbering: none)[Supplementary material]

#heading(level: 2, numbering: none)[Supplementary Figure 1]

#figure(image("images/Scaled_schoenfeld_1.png", width: 80%), numbering: none, caption: [Figure 1: Scaled Schoenfeld residuals of "EMT". No time-dependent effects of EMT on hazard were observed (Schoenfeld residual test p = 0.8477).]) <Schoenfeld_plot>

#heading(level: 2, numbering: none)[Supplementary Figure 2]

#figure(
  image("images/schoenfeld2_purity.png", width: 80%), numbering: none, caption: [Figure 2: Scaled Schoenfeld residuals of "tumour purity". No time-dependent effects of tumour purity on hazard were observed (Schoenfeld residual test p = 0.3787) ]
) <Schoenfeld2>

#heading(level: 2, numbering: none)[Supplementary Figure 3]

#figure(image("images/figo-schoenfeld.png", width: 80%), numbering: none, caption: [Figure 3: Scaled Schoenfeld residuals of "FIGO stage IV". Time-dependent effects of stage IV on hazard were observed (Schoenfeld residual test p = 0.0147)]
)

#heading(level: 2, numbering: none)[Supplementary Figure 4]

#figure(
  image("images/EMT_score_distribution.png", width: 80%), numbering: none, caption: [Figure 4: Distribution of z-scored EMT scores.]
) <Dist_EMT>

#heading(level: 2, numbering: none)[Supplementary Figure 5]

#figure(
  image("images/EMT_by_survival.png", width: 80%), numbering: none, caption: [Figure 5: EMT score by survival status.]
) <EMT_by_survival>

#heading(level: 2, numbering: none)[Supplementary Figure 6]

#figure(
  image("images/dispersion_estimates.png", width: 80%), numbering: none, caption: [Figure 6: Mean-dispersion relationship of gene expression]
) <Dispresion>

#heading(level: 2, numbering: none)[Supplementary Table 1]

The full DESeq2 differential expression results for TCGA-CESC vs. GTEx normal cervical tissue are provided in `Supplementary_Table_S1_DE_results.tsv`

#heading(level: 2, numbering: none)[Supplementary Table 2]

The full Cox proportional hazards regression model input table with EMT score and tumour purity as covariates is provided in `Supplementary_Table_S2_cox_input.tsv`

#heading(level: 2, numbering: none)[Supplementary Table 3]

The Cox proportional hazards regression model input table with EMT score and FIGO stage as covariates is provided in `Supplementary_Table_S3_cox_input.tsv`

#heading(level: 2, numbering: none)[Supplementary Table 4]

The full table showing the genes driving the GSEA enrichment score is provided in `Supplementary_Table_S4_leading_genes.csv`


