# HLA Typing Pipeline

## Overview
This pipeline performs **HLA class I genotyping** from high-throughput sequencing data using **[OptiType](https://github.com/FRED-2/OptiType)**. OptiType is a state-of-the-art algorithm for precise HLA typing from DNA or RNA sequencing reads.  

This pipeline streamlines preprocessing, execution, and output organization for consistent and reproducible HLA calls.

---

## Features
- Supports **single-end and paired-end FASTQ** input (DNA or RNA)
- Performs **HLA-A, HLA-B, and HLA-C** typing
- Uses **OptiType**’s internal alignment and optimization for allele prediction
- Generates a clean, interpretable **HLA typing summary**
- Containerized for reproducibility (no manual installation required)

---

## Usage

### Input
- Paired-end FASTQ files:
  - `sample_R1.fastq`
  - `sample_R2.fastq`
- OR single-end FASTQ file:
  - `sample.fastq`



## Output

Each run generates the following files in the output directory:

| File | Description |
|------|--------------|
| `sample1_result.tsv` | Table of predicted HLA alleles and scores |
| `sample1_coverage_plot.pdf` | Coverage visualization for each allele |


---

## Interpretation
OptiType reports **two alleles per locus** for **HLA-A**, **HLA-B**, and **HLA-C**, ranked by the internal scoring system.  
The alleles correspond to the best-matching entries in the **IMGT/HLA** reference database.

---


## Citation
If you use this pipeline, please cite:
> Szolek A. *et al.* OptiType: precision HLA typing from next-generation sequencing data. **Bioinformatics**, 30(23), 3310–3316 (2014).

---

## License
This pipeline is distributed under the **MIT License**.  
OptiType itself is distributed under its own license — see the [OptiType GitHub page](https://github.com/FRED-2/OptiType) for details.
