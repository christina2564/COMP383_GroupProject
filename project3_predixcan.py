#This script runs S-PrediXXcan from the terminal
#Users can execute the pipline through the line:
#pythong project3_predixcan.py
import os

os.system(
    "python ~/MetaXcan/software/SPrediXcan.py "
    "--gwas_file harmonized_project3_sumstats.tsv "
    "--model_db_path /home/data/Project3/elastic-net-with-phi/en_Whole_Blood.db "
    "--covariance /home/data/Project3/elastic-net-with-phi/en_Whole_Blood.txt.gz "
    "--snp_column variant_id "
    "--effect_allele_column effect_allele "
    "--non_effect_allele_column non_effect_allele "
    "--beta_column effect_size "
    "--se_column standard_error "
    "--pvalue_column pvalue "
    "--output_file spredixcan_project3_results.csv"
)
