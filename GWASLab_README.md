# GWASLab Pipeline

## Overview
This pipeline demonstrates how to harmonize a GWAS summary statistic using GWASLab and run S-PrediXcan using the GWAS Catalog test file (GCST90568441).

## Dependencies

### Software
- Linux or macOS  
- Python  

### Python Packages
- gwaslab  

## Setup
```bash
# Download GRCh38 reference genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fna.gz

# Unzip reference genome
gunzip GCF_000001405.40_GRCh38.p14_genomic.fna.gz

# Create virtual environment
python3 -m venv .venv

# Activate environment
source .venv/bin/activate

# Install GWASLab
pip install gwaslab

# Download GWAS Catalog test file
wget http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90568001-GCST90569000/GCST90568441/GCST90568441.tsv.gz

# Unzip GWAS file
gunzip GCST90568441.tsv.gz
```

## GWASLab Harmonization

```python
import gwaslab as gl

mysumstats = gl.Sumstats(
    "GCST90568441.tsv",
    snpid="rsid",
    chrom="chromosome",
    pos="base_pair_location",
    ea="effect_allele",
    nea="other_allele",
    beta="beta",
    se="standard_error",
    p="p_value",
    sep=r"\s+"
)

mysumstats.basic_check()

mysumstats.harmonize(
    ref_seq="GCF_000001405.40_GRCh38.p14_genomic.fna",
    verbose=True
)

mysumstats.to_csv("harmonized_sumstats.tsv", sep="\t", index=False)
```

---

## Run S-PrediXcan

```bash
python ~/MetaXcan/software/SPrediXcan.py \
--gwas_file harmonized_sumstats.tsv \
--model_db_path /home/data/Project3/elastic-net-with-phi/en_Whole_Blood.db \
--covariance /home/data/Project3/elastic-net-with-phi/en_Whole_Blood.txt.gz \
--snp_column SNPID \
--effect_allele_column EA \
--non_effect_allele_column NEA \
--beta_column BETA \
--pvalue_column P \
--output_file spredixcan_results.csv
```

---

## Output

```bash
spredixcan_results.csv
```
