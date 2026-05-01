#Users may use this code to test the sample provided by Dr. Wheeler, but may also be updated in order to run other samples

import gwaslab as gl

mysumstats = gl.Sumstats(
    "/home/data/Project3/hg38_AoU_AFR_phenotype_836850_ACAF_sumstats.tsv.gz",
    snpid="variant_id",
    chrom="chromosome",
    pos="position",
    ea="effect_allele",
    nea="non_effect_allele",
    eaf="frequency",
    beta="effect_size",
    se="standard_error",
    p="pvalue",
    n="sample_size",
    sep="\t"
)

mysumstats.basic_check()

mysumstats.harmonize(
    ref_seq="/home/nalde/GRCh38.fa",
    verbose=True
)

mysumstats.to_csv("harmonized_project3_sumstats.tsv", sep="\t", index=False)
