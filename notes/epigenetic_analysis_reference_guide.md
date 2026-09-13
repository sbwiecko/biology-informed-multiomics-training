# Epigenetic Analysis Reference Guide

This document provides comprehensive reference tables for interpreting chromatin accessibility (ATAC-seq), histone modifications, RNA expression, and DNA methylation patterns in epigenetic analysis. Each table represents different combinations of assays and their biological interpretations.

## Definitions

### ATAC-seq

Assay for Transposase-Accessible Chromatin using sequencing (ATAC-seq) is a rapid molecular biology method used to map open, accessible regions of DNA across the genome. How ATAC-seq works:

1. Tagmentation: A hyperactive mutant enzyme called Tn5 transposase is loaded with sequencing adapters. It cuts DNA and inserts these adapters simultaneously only into open, uncompacted chromatin regions.
2. Amplification & Sequencing: The tagged DNA fragments are purified, amplified using PCR, and read using next-generation sequencing.
3. Peak Analysis: Bioinformatics tools map the resulting sequences back to the genome. Clusters of reads form "peaks" that show where the chromatin was open, revealing active gene promoters, enhancers, and transcription factor binding sites.

<img src="https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fs41596-022-00692-9/MediaObjects/41596_2022_692_Fig1_HTML.png" width="600">

### ChIP-seq

Chromatin Immunoprecipitation Sequencing (ChIP-seq) is a powerful laboratory technique used to find where specific proteins bind to DNA across the entire genome. How ChIP-seq works:

1. Cross-linking: Treat cells with a chemical like formaldehyde to freeze and bind proteins to their current spots on the DNA.
2. Fragmentation: Break the chromatin into smaller, manageable pieces using sound waves or enzymes (sonication).
3. Immunoprecipitation: Add a specific antibody that attaches only to your protein of interest, allowing you to pull down that protein and its stuck DNA fragment.
4. Reversal and Purification: Remove the chemical cross-links, get rid of the protein, and isolate the remaining bound DNA pieces.
5. Sequencing and Alignment: Send the purified DNA fragments for high-throughput sequencing, then use computers to map the reads back to a reference genome.

<img src="https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fnrg3306/MediaObjects/41576_2012_Article_BFnrg3306_Fig1_HTML.jpg" width="600">

### WGBS

Whole-genome bisulfite sequencing (WGBS) is the gold-standard next-generation sequencing method used to map DNA methylation at single-base resolution across an entire genome. By treating genomic DNA with sodium bisulfite, researchers can differentiate between methylated and unmethylated cytosines. How WGBS works:

1. Denaturation: Double-stranded genomic DNA is separated into single strands using heat.
2. Bisulfite Treatment: The DNA is treated with sodium bisulfite.
  1. Unmethylated cytosines undergo hydrolytic deamination and convert into uracil (U).
  2. Methylated cytosines (5mC) are chemically protected and remain unchanged \(C).
3. PCR Amplification: During PCR, the converted uracils are amplified as thymines (T), while the protected methylated cytosines are amplified as cytosines \(C).
4. Sequencing & Alignment: The final library is sequenced using a high-throughput platform. Computational pipelines (like Bismark) align the C-to-T altered reads back to a reference genome to determine the exact methylation ratio at every single site.

<img src="https://cdn.ncbi.nlm.nih.gov/pmc/blobs/754c/12602173/35dd864e8f98/BioProtoc-15-21-5506-g001.jpg" width="600">

## Data Interpretation

### Key Abbreviations

- **ATAC-seq**: Assay for Transposase-Accessible Chromatin using sequencing
- **H3K4me1**: Histone H3 lysine 4 monomethylation (enhancer mark)
- **H3K4me3**: Histone H3 lysine 4 trimethylation (active promoter mark)
- **H3K27ac**: Histone H3 lysine 27 acetylation (active enhancer/promoter mark)
- **H3K27me3**: Histone H3 lysine 27 trimethylation (Polycomb repressive mark)
- **RNA-seq**: RNA sequencing (gene expression)
- **DNAme**: DNA methylation (CpG methylation)
- **TSS**: Transcription Start Site

### Legend

- **↑**: Increased signal/activity
- **↓**: Decreased signal/activity
- **~**: Low level or no significant change
- **N/A**: Not applicable
- **-**: No change or not detected

### Table 1: Basic Enhancer Analysis

Analysis of enhancer states using **ATAC-seq**, **H3K4me1**, **RNA-seq**, and **DNAme**.

| Category                     | ATAC-seq | H3K4me1 | RNA-seq         | DNAme (CpG) | Dist. to TSS   | Interpretation                                                                                                                                              |
| ---------------------------- | -------- | ------- | --------------- | ----------- | -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Active Enhancer**          | ↑        | ↑       | Target Gene ↑   | ↓           | >2500 bp       | Open chromatin, marked by both H3K4me1 and H3K27ac (see next table), driving expression of target gene. Typically distal. Hypomethylated.                   |
| **Poised/Inactive Enhancer** | ↑        | ↑       | Target Gene ~   | ↓           | >2500 bp       | Open chromatin, marked by H3K4me1 but lacking H3K27ac, indicating an accessible but not fully active enhancer. Target gene not expressed. Typically distal. |
| **Silent Region**            | ↓        | ↓       | ~ No expression | ↑           | >2500 bp / Any | Closed chromatin, H3K4me1 absent, indicating no enhancer activity. Often hypermethylated. Can be distal or other.                                           |
| **Promoter (Contrast)**      | ↑        | ↓       | ↑               | ↓           | <2500 bp       | While H3K4me1 can be found at some promoters, it's generally low compared to H3K4me3, which is the primary promoter mark.                                   |

### Table 2: Enhancer States with H3K27ac

Comprehensive analysis of enhancer states including **H3K27ac** for activity determination.

| Category                           | ATAC-seq | H3K4me1 | H3K27ac  | RNA-seq (Target Gene) | DNAme (Enhancer Region) | Dist. to TSS | Interpretation                                                                                                                                                                                                                                                     |
| ---------------------------------- | -------- | ------- | -------- | --------------------- | ----------------------- | ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Active Enhancer**                | ↑        | ↑       | ↑        | ↑                     | ↓                       | >2500 bp     | Open chromatin, both H3K4me1 and H3K27ac present. This is the classic signature of an active enhancer, strongly correlated with increased expression of its target gene(s). Typically distal to the TSS. Hypomethylated.                                           |
| **Poised/Primed Enhancer**         | ↑        | ↑       | ~ Low/No | ~ Low/No              | ↓                       | >2500 bp     | Open chromatin, H3K4me1 present but H3K27ac absent or very low. This indicates an accessible enhancer element that has potential but is not currently active. It's "primed" for activation under specific conditions. Typically distal to the TSS. Hypomethylated. |
| **Inactive Enhancer (Accessible)** | ↑        | ↓       | ↓        | ~ Low/No              | ↓ / Variable            | >2500 bp     | Open chromatin, but lacks both H3K4me1 and H3K27ac. This state is less common for enhancer definitions, but could represent a broadly accessible region without specific enhancer marks, or a very transient state. Typically distal to the TSS.                   |
| **Inactive Enhancer (Closed)**     | ↓        | ↓       | ↓        | ~ Low/No              | ↑                       | >2500 bp     | Closed chromatin, both H3K4me1 and H3K27ac absent. This represents a silent or repressed enhancer element that is not accessible and not active. Often hypermethylated in the enhancer region. Typically distal to the TSS.                                        |
| **Weak/Dormant Enhancer**          | ↑        | ↑       | ~ Low    | ~ Low/No              | ↓                       | >2500 bp     | A variant of the poised enhancer, where H3K27ac might be present but at very low levels, suggesting minimal or transient activity, or a region with enhancer potential that is not fully "on." Typically distal to the TSS.                                        |

### Table 3: Enhancer vs Promoter Comparison

Direct comparison of enhancer and promoter states using **H3K27ac** as the key discriminator.

| Category                       | ATAC-seq | H3K4me1 (Context) | H3K27ac  | RNA-seq       | DNAme (CpG) | Dist. to TSS        | Interpretation                                                                                                                                                                |
| ------------------------------ | -------- | ----------------- | -------- | ------------- | ----------- | ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Active Enhancer**            | ↑        | ↑                 | ↑        | Target Gene ↑ | ↓           | >2500 bp            | Open chromatin at a distal element, co-occurrence of H3K4me1 and H3K27ac, strong H3K27ac signal, often correlates with increased expression of a target gene. Hypomethylated. |
| **Active Promoter**            | ↑        | ~ Low/N/A         | ↑        | ↑             | ↓           | <2500 bp            | Open chromatin directly at the promoter, strong H3K27ac signal, high gene expression. Hypomethylated. (Often co-occurs with H3K4me3 here). Proximal to TSS.                   |
| **Primed/Dormant Enhancer**    | ↑        | ↑                 | ~ Low/No | Target Gene ~ | ↓           | >2500 bp            | Open chromatin, H3K4me1 present but H3K27ac is low or absent, suggesting the enhancer is accessible but not fully active. Target gene not expressed. Typically distal.        |
| **Inactive Enhancer/Promoter** | ↓        | ↓                 | ↓        | ↓             | ↑           | <2500 bp / >2500 bp | Closed chromatin, H3K27ac absent, element is not active and associated gene is repressed. Often hypermethylated. Can be proximal or distal.                                   |

### Table 4: Promoter-Focused Analysis

Analysis specifically focused on promoter regions using **H3K4me3** as the primary marker.

| Category              | ATAC-seq | H3K4me3  | RNA-seq  | DNAme (CpG Promoter) | Dist. to TSS | Interpretation                                                                                                           |
| --------------------- | -------- | -------- | -------- | -------------------- | ------------ | ------------------------------------------------------------------------------------------------------------------------ |
| **Active Promoter**   | ↑        | ↑        | ↑        | ↓                    | <2500 bp     | Open chromatin, active promoter, high gene expression, typically unmethylated. Proximal to the gene's TSS.               |
| **Poised Promoter**   | ↑        | ↑        | ~ Low/No | ↓                    | <2500 bp     | Open chromatin, H3K4me3 present, but gene is not actively expressed (e.g., awaiting developmental cue). Proximal to TSS. |
| **Inactive Promoter** | ↓        | ↓        | ↓        | ↑                    | <2500 bp     | Closed chromatin, H3K4me3 absent, gene repressed, often hypermethylated. Proximal to TSS.                                |
| **Promoter Flanks**   | ↑        | ~ Low/No | N/A      | ↓                    | <2500 bp     | Open chromatin around active promoter, but H3K4me3 typically peaks precisely at the TSS.                                 |

### Table 5: Simplified Three-Factor Analysis

Basic analysis using just **ATAC-seq**, **RNA-seq**, and **DNAme**.

| Category                                | ATAC-seq | RNA-seq         | DNAme (CpG Promoter) | Dist. to TSS        | Interpretation                                                                                                                                                                                                                                                                                       |
| --------------------------------------- | -------- | --------------- | -------------------- | ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Active Gene/Element**                 | ↑        | ↑               | ↓                    | <2500 bp / >2500 bp | Open chromatin, high gene expression, and low DNA methylation. This is the classic signature of an actively transcribed gene (often proximal) or a highly active regulatory element (can be distal).                                                                                                 |
| **Repressed Gene/Element**              | ↓        | ↓               | ↑                    | <2500 bp / >2500 bp | Closed chromatin, low/no gene expression, and high DNA methylation. This indicates a stably silenced gene or an inactive regulatory element. Can be proximal or distal.                                                                                                                              |
| **Poised/Primed Region**                | ↑        | ~ Low/No        | ↓                    | <2500 bp / >2500 bp | Open chromatin, but low/no gene expression, and low DNA methylation. The region is accessible, and DNA is unmethylated, suggesting it's "ready" for activation but not currently expressing. Can be proximal (poised promoter) or distal (poised enhancer).                                          |
| **Incongruent/Complex**                 | ↓        | ↑               | Variable             | <2500 bp / >2500 bp | Closed chromatin, but high gene expression. This is an unusual state. It might suggest very efficient transcription from a less accessible promoter, or a regulatory mechanism (e.g., enhancer) acting from a distance which is not reflected by local accessibility. Requires deeper investigation. |
| **Silent/Inactive Region**              | ↓        | ~ No Expression | ↑                    | <2500 bp / >2500 bp | Closed chromatin, no gene expression, and high DNA methylation. Represents a fully repressed and inaccessible genomic region, such as silent heterochromatin. Can be proximal or distal.                                                                                                             |
| **Lost Accessibility, Unchanged RNA**   | ↓        | ~ No Change     | Variable             | <2500 bp / >2500 bp | Chromatin becomes less accessible, but gene expression remains unchanged. This could indicate a shift in regulatory mechanisms (e.g., reliance on distal elements), or that the lost accessibility at a specific site does not immediately impact overall transcript levels.                         |
| **Gained Accessibility, Unchanged RNA** | ↑        | ~ No Change     | ↓                    | <2500 bp / >2500 bp | Chromatin becomes more accessible, but gene expression remains unchanged. This might indicate a "priming" event where the region is opened up in preparation for future activation, or that the accessibility change alone isn't sufficient to drive expression.                                     |

### Table 6: Comprehensive Multi-Mark Analysis

Complete analysis including all major histone modifications (**H3K4me3**, **H3K4me1**, **H3K27ac**).

| Category                       | ATAC-seq | H3K4me3 (Promoter) | H3K4me1 (Enhancer) | H3K27ac (Active) | RNA-seq (Target Gene) | DNAme (CpG) | Dist. to TSS        | Interpretation                                                                                                                                                                                                                                                              |
| ------------------------------ | -------- | ------------------ | ------------------ | ---------------- | --------------------- | ----------- | ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Active Promoter**            | ↑        | ↑                  | ~ Low/No           | ↑                | ↑                     | ↓           | <2500 bp            | Open chromatin, strong H3K4me3 and H3K27ac. This is the hallmark of a highly active transcription start site (TSS), leading to high gene expression. H3K4me1 is typically low at active promoters. Proximal to TSS. Usually unmethylated.                                   |
| **Active Enhancer**            | ↑        | ~ Low/No           | ↑                  | ↑                | ↑                     | ↓           | >2500 bp            | Open chromatin, strong H3K4me1 and H3K27ac. This combination defines an active enhancer, contributing to increased expression of its target gene(s), which may be proximal or distal. H3K4me3 is typically low at enhancers. Typically distal to TSS. Usually unmethylated. |
| **Poised/Primed Enhancer**     | ↑        | ~ Low/No           | ↑                  | ~ Low/No         | ~ Low/No              | ↓           | >2500 bp            | Open chromatin, H3K4me1 present but H3K27ac low or absent. This signifies an enhancer that is accessible and has potential, but is not currently actively driving gene expression. It's "poised" for activation. Typically distal to TSS. Usually unmethylated.             |
| **Poised Promoter (Bivalent)** | ↑        | ↑                  | ~ Low/No           | ~ Low/No         | ~ Low/No              | ↓           | <2500 bp            | Open chromatin, H3K4me3 present, but H3K27ac low/absent. (Note: If H3K27me3 is also present, it's a "bivalent" promoter, signaling developmental plasticity). The gene is prepared for activation but not highly expressed yet. Proximal to TSS. Usually unmethylated.      |
| **Inactive/Silent Region**     | ↓        | ↓                  | ↓                  | ↓                | ↓ / ~ No              | ↑           | <2500 bp / >2500 bp | Closed chromatin, all three marks are low or absent. This indicates a transcriptionally inactive or repressed genomic region, including inactive promoters and enhancers. Often associated with DNA hypermethylation and/or repressive histone marks (like H3K27me3).       |
| **Weakly Active Enhancer**     | ↑        | ~ Low/No           | ↑                  | ~ Low            | ~ Low/No              | ↓           | >2500 bp            | Open chromatin, H3K4me1 present, but H3K27ac at low levels. This could represent an enhancer with minimal activity or an enhancer that is just beginning to become active. Typically distal to TSS.                                                                         |

### Table 7: Polycomb Repression Analysis

Analysis focusing on **H3K27me3**-mediated Polycomb repression.

| Category                              | ATAC-seq | H3K27me3        | RNA-seq         | DNAme (CpG)  | Dist. to TSS   | Interpretation                                                                                                                                                           |
| ------------------------------------- | -------- | --------------- | --------------- | ------------ | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Polycomb-Repressed Gene**           | ↓        | ↑               | ↓               | ↓ / Variable | <2500 bp       | Closed chromatin due to Polycomb, gene is repressed, but often retains an unmethylated CpG island at the promoter, allowing for potential reactivation. Proximal to TSS. |
| **Bivalent Promoter**                 | ↑        | ↑ (+ H3K4me3 ↑) | ~ Low/No        | ↓            | <2500 bp       | Open chromatin, but marked by both H3K4me3 (active) and H3K27me3 (repressive), indicating a poised state, common in stem cells for developmental genes. Proximal to TSS. |
| **Inactive Region (Polycomb-driven)** | ↓        | ↑               | ~ No expression | ↓ / Variable | >2500 bp / Any | Large genomic regions silenced by Polycomb, often in a lineage-specific manner. Chromatin is closed, but not necessarily hypermethylated. Can be distal or other.        |
| **Active Gene (H3K27me3 removed)**    | ↑        | ↓               | ↑               | ↓            | <2500 bp       | H3K27me3 has been removed, allowing chromatin to open and gene expression to activate (e.g., during differentiation). Proximal to TSS.                                   |

### Table 8: Complete Seven-Factor Analysis

Most comprehensive analysis including all major epigenetic marks and Polycomb repression.

| Category                               | ATAC-seq | H3K4me3 (Promoter) | H3K4me1 (Enhancer) | H3K27ac (Active) | H3K27me3 (Polycomb) | RNA-seq (Target Gene) | DNAme (CpG)  | Dist. to TSS | Interpretation                                                                                                                                                                                                                                                                                  |
| -------------------------------------- | -------- | ------------------ | ------------------ | ---------------- | ------------------- | --------------------- | ------------ | ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Active Promoter**                    | ↑        | ↑                  | ~ Low/No           | ↑                | ↓                   | ↑                     | ↓            | <2500 bp     | Open chromatin at TSS, strong active promoter marks (H3K4me3, H3K27ac), leading to high gene expression. Typically unmethylated.                                                                                                                                                                |
| **Active Enhancer**                    | ↑        | ~ Low/No           | ↑                  | ↑                | ↓                   | ↑                     | ↓            | >2500 bp     | Open chromatin at a distal element, strong active enhancer marks (H3K4me1, H3K27ac), correlated with increased expression of a target gene. Typically unmethylated.                                                                                                                             |
| **Poised Promoter (Bivalent)**         | ↑        | ↑                  | ~ Low/No           | ~ Low/No         | ↑                   | ~ Low/No              | ↓            | <2500 bp     | Open chromatin at TSS, marked by both active (H3K4me3) and repressive (H3K27me3) marks, indicating a repressed but ready-to-activate state (common in stem cells). Gene expression is low/off. Unmethylated promoter.                                                                           |
| **Poised/Primed Enhancer**             | ↑        | ~ Low/No           | ↑                  | ~ Low/No         | ~ Low/No            | ~ Low/No              | ↓            | >2500 bp     | Open chromatin at a distal element, H3K4me1 present but H3K27ac absent, indicating an accessible enhancer element that is not currently active but "primed" for future activation. Target gene not expressed. Unmethylated.                                                                     |
| **Polycomb-Repressed Region**          | ↓        | ↓                  | ↓                  | ↓                | ↑                   | ↓ / ~ No              | ↓ / Variable | Any          | Closed chromatin, marked by Polycomb-mediated repression (H3K27me3), leading to reversible gene silencing. Often affects developmental genes. DNA methylation can be low or variable.                                                                                                           |
| **Repressed Gene (by Methylation)**    | ↓        | ↓                  | ↓                  | ↓                | ↓                   | ↓                     | ↑            | <2500 bp     | Closed chromatin at promoter, lack of active marks, reduced gene expression, primarily driven by high DNA methylation at the promoter.                                                                                                                                                          |
| **Incongruent (Closed but Expressed)** | ↓        | Variable           | Variable           | Variable         | Variable            | ↑                     | Variable     | Any          | An unusual state where chromatin appears closed (low ATAC-seq), but the gene is expressed. This might suggest very efficient transcription, or regulation from a highly distant and active element not locally detectable, or limitations of the assay resolution. Requires careful validation. |
| **Silent/Inactive Region**             | ↓        | ↓                  | ↓                  | ↓                | ↓                   | ~ No Expression       | Variable     | Any          | Chromatin is closed, no active histone marks, no expression. A general category for regions that are simply not active, regardless of specific repressive mechanism (e.g., DNAme, polycomb).                                                                                                    |

## Summary

These tables provide a comprehensive framework for interpreting multi-dimensional epigenetic data. The key principles to remember are:

1. **Active regions** typically show: ↑ ATAC-seq, ↑ Active histone marks, ↑ RNA-seq, ↓ DNA methylation
2. **Poised regions** show: ↑ ATAC-seq, ↑ Some histone marks, ~ Low RNA-seq, ↓ DNA methylation
3. **Repressed regions** show: ↓ ATAC-seq, ↓ Active marks, ↓ RNA-seq, ↑ DNA methylation
4. **Enhancers** are characterized by H3K4me1 and are typically >2500 bp from TSS
5. **Promoters** are characterized by H3K4me3 and are typically <2500 bp from TSS
6. **H3K27ac** distinguishes active from poised elements
7. **H3K27me3** indicates Polycomb-mediated repression
8. **Bivalent** promoters have both H3K4me3 and H3K27me3, common in stem cells

This reference guide should help in the systematic interpretation of complex epigenetic datasets across different experimental conditions and cell types.
