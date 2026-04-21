import os
SAMPLES, = glob_wildcards("data/{sample}.tsv.gz")


rule all: # our final target it the harmoinzed files 
    input:
        expand("sample_outputs/{sample}_harmonized.txt.gz", sample=SAMPLES)

rule download_repos:
    # Rule to ensure the necessary lab tools are downloaded
    output:
        parsing_script = "summary-gwas-imputation/src/gwas_parsing.py"
    shell:
        """
        git clone https://github.com/hakyimlab/summary-gwas-imputation.git || true
        """

rule patch_gwas_parsing:
    # Rule to fix the bug in the lab's code
    input:
        rules.download_repos.output.parsing_script
    output:
        touch(".gwas_parsing_patched")
    shell:
        """
        sed -i 's/\[int(x) if not math.isnan(x) else "NA" for x in d.sample_size\]/[int(x) if (not isinstance(x, str) and not math.isnan(x)) else "NA" for x in d.sample_size]/' {input}
        """

# Rule to standardize the GWAS summary statistics
rule harmonize_gwas:
    input:
        gwas = "data/{sample}.tsv.gz",
        patch = ".gwas_parsing_patched",
        script = "run_gwas_harmonization.py"
    output:
        "sample_outputs/{sample}_harmonized.txt.gz"
    conda:
        "environment.yaml" # Ensures the correct NumPy/Pandas versions are used
    shell:
        """
        # Set path so Python can find the lab's genomic tools library
        export PYTHONPATH=$PYTHONPATH:$(pwd)/summary-gwas-imputation/src
        
        python3 {input.script} \
            -i {input.gwas} \
            -o {output}
        """
