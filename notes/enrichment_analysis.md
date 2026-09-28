# Functional Enrichment Analysis: Multi-Omics Integration

This document summarizes the core concepts of functional enrichment analysis for multi-omics data, bridging the theoretical foundations from the lecture slides with the practical implementation in the accompanying R/Jupyter notebook.

## Overview of Enrichment Analysis

The primary goal of functional enrichment analysis is to extract biologically meaningful insights from long lists of genes. Instead of analyzing genes in isolation, these methods evaluate sets of genes to identify overactive or suppressed biological pathways.

The three primary methodologies include:

* **Over-Representation Analysis (ORA):** Evaluates the fraction of genes in a specific pathway found among a set of differentially expressed (DE) genes.
  * It relies on a strict significance threshold (e.g., FDR ≤ 0.05) to select the input list.
  * Significance is commonly calculated using Fisher's exact test, hypergeometric, chi-square, or binomial distributions.
  * **Limitations:** It requires arbitrary cutoffs, treats all genes in the list equally regardless of expression fold-change, and assumes that all genes and pathways act independently.
* **Functional Class Scoring (FCS / GSEA):** Evaluates whether weaker but coordinated changes in sets of related genes have significant effects.
  * Instead of a cutoff, it ranks all genes (often by $\log_2(\text{FC}) \times \text{t-value}$) and calculates a running enrichment score using statistics like the Kolmogorov-Smirnov test.
  * **Limitations:** Like ORA, it still assumes that genes and pathways are independent of one another.
* **Pathway Topology (PT):** Incorporates structural biological context to assess pathway impact.
  * It factors in the specific number of reactions, the biological position of the gene, and the type of reaction taking place.

## Database Challenges & Semantic Similarity

Enrichment relies heavily on curated databases like Gene Ontology (GO), KEGG, and Reactome.

* **The Resolution Problem:** The GO database (split into Biological Process, Molecular Function, and Cellular Component) contains highly similar or overlapping terms, such as "cell cycle" and "mitosis".
* **Semantic Similarity:** To reduce redundancy, analysis often measures the semantic similarity of GO terms based on "exclusively inherited" shared information. This filters out broad, unrelated common ancestors to group terms by their true unique functions.

Here is the expanded section, integrating the details of how GREAT calculates domains, maps peaks, and runs its statistical tests:

## Cis-Regulatory Regions & GREAT

Standard enrichment tools fail when analyzing non-coding regions or distal regulatory elements.

* **GREAT (Genomic Regions Enrichment of Annotations Tool):** Designed to accurately link cis-regulatory regions (like enhancers or ATAC-seq peaks) to the specific biological pathways they control. It solves the distal regulation problem in three distinct steps:
  * **Defining Domains (Coordinate Math):** GREAT calculates a "regulatory domain" for every known gene by starting at the Transcription Start Site (TSS). It first assigns a **Basal Domain** (typically 5kb upstream to 1kb downstream). It then calculates a **Distal Extension**, expanding outward along the chromosome in both directions until it hits the nearest neighboring gene's basal domain (capped at a strict maximum of 1,000 kb).
  * **Mapping Peaks (Interval Intersection):** It compares the genomic coordinates of the input regions against this newly built catalog of regulatory domains. Any physical overlap assigns that distal DNA to the corresponding gene.
  * **Linking to Pathways (Binomial Test):** To evaluate pathway significance, GREAT measures the total genomic footprint (in base pairs) of all regulatory domains belonging to a specific pathway. It then runs a binomial over-representation test to determine if the peaks landed inside that pathway's footprint significantly more often than would happen by random chance.
* It accounts for long-range interactions identified by chromatin conformation (Hi-C) or epigenetic markers (H3K27ac).
* **rGREAT Integration:** The `rGREAT` R/Bioconductor package allows this functional enrichment to be executed directly on genomic regions.

## Connection to the Practical Exercise

The accompanying Jupyter notebook perfectly mirrors this methodology by applying `rGREAT` to multi-omics overlap data.

* It isolates a specific genomic cluster ("Active Promoters") from an ATAC/RNA overlap matrix.
* It visualizes the region-gene associations and uses the `simplifyEnrichment` package to calculate semantic similarity, clustering redundant GO terms into functional groups like "ion transport" and "calcium signaling".
