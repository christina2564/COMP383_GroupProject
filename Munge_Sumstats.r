# Install BioConductor
if (!require("BiocManager")) install.packages("BiocManager")

#This MungeSumstats package thorugh BioConductor
BiocManager::install("MungeSumstats")

# ^^ if downloaded then you do not need to run the above, only run the below
library(MungeSumstats)

# our summary stats file relates to GRch38, so we need to install SNPlocs.Hsapiens.dbSNP144.GRCh38 and BSgenome.Hsapiens.NCBI.GRCh38 from Bioconductor as follows: 
# Warning: installation and loading on these libraries will take more than 1 hour
options(timeout=2000)
BiocManager::install("SNPlocs.Hsapiens.dbSNP155.GRCh38")
BiocManager::install("BSgenome.Hsapiens.NCBI.GRCh38")

library(SNPlocs.Hsapiens.dbSNP155.GRCh38)
library(BSgenome.Hsapiens.NCBI.GRCh38)
# download the one below if the reference genoomes of the GWAS is ch37
#BiocManager::install("SNPlocs.Hsapiens.dbSNP155.GRCh37")
#BiocManager::install("BSgenome.Hsapiens.1000genomes.hs37d5")
# these are big downloads of 800kb


# required inputs to run Munge sumstats are path to raw data, ref_genome used, and save_path which is path to harmonized data
format_sumstats(path="/home/data/Project3/AoU_AFR_phenotype_836850_ACAF_sumstats_for_S-PrediXcan.txt.gz", 
ref_genome="GRCh38", save_path = "~/COMP383_GroupProject/AoU_formatted1.txt.gz")

# 
