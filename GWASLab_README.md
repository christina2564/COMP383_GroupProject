# GWASLab Pipeline

## Project Overview
This section describes how to download the required data, set up the virtual environment, and run GWASLab in order to harmonizae GWAS summary statistics for downstream analysis with S-PrediXcan.

Due to the research of this project, GWASLab was used with hardcoding, leading to the result of preprocessing work and manual labor from the user. Further down the project, the sumstats from GWASLab must be changed to match the column names within the summary statistics.

## Dependencies

### Software
- conda -> virtual environment to run GWASLab  
- Linux or macOS  
- Python  

### Python Packages
- gwaslab  

## Setup
```bash
#Download the GRCh38 reference genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fna.gz

#Unzip the reference genome
gunzip GCF_000001405.40_GRCh38.p14_genomic.fna.gz

#Create virtual environment
python3 -m venv .venv

#Activate environment
source .venv/bin/activate

#Install GWASLab
pip install gwaslab

#Download GWAS summary statistics
wget http://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90568001-GCST90569000/GCST90568441/GCST90568441.tsv.gz

#Unzip file
gunzip GCST90568441.tsv.gz
```

## GWASLab Script
```python
import gwaslab as gl

mysumstats = gl.Sumstats(
    "/home/nalde/GCST90568441.tsv.gz",
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
    ref_seq="/home/nalde/GRCh38.fa",
    verbose=True
)

mysumstats.to_csv("harmonized_sumstats.tsv", sep="\t", index=False)
```
