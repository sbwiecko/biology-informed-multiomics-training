# Normalization models

## Averaging Models for Normalization

The slide deck outlines four distinct mathematical models for summarizing signals.

* **Absolute (`absolute`)**: Calculates the mean value from all signal regions regardless of their width. The formula is $v_{a}=\frac{\sum_{i=1}^{n}x_{i}}{n}$.
* **Weighted (`weighted`)**: Calculates the mean value from all signal regions, specifically weighted by the width of their intersections. The formula is $v_{w}=\frac{\sum_{i=1}^{n}x_{i}w_{i}}{\sum_{i=1}^{n}w_{i}}$.
* **W0 (`w0`)**: Calculates the weighted mean between both the intersected and un-intersected parts of the window. The formula is $v_{w0}=\frac{\sum_{i=1}^{n}x_{i}w_{i}}{W+W^{\prime}}$.
* **Coverage (`coverage`)**: Calculates the mean signal averaged by the width of the window itself, represented by $L$. The formula is $v_{c}=\frac{\sum_{i=1}^{n}x_{i}w_{i}}{L}$.

## Understanding Windows and Genomic Signals

To understand how these methods are applied, it helps to define the core structural components shown in the visual diagrams:

* **Window**: This represents a designated segment in the target regions or in the flanking regions when we are normalizing genomic signals.
* **Genomic signal regions**: These are the actual data segments (like mapped reads or peaks) that overlap with the given window.

## Application to Specific Assays

The choice of averaging method depends heavily on the biological assay and how the signal is represented.

* **RNA-seq:** We are physically sequencing the transcribed RNA. Therefore, the coordinates in the `rowRanges` represent the actual, literal boundaries of the gene or mRNA transcript on the genome. The "feature" we are counting *is* the gene itself.
* **ATAC-seq, ChIP-seq, and WGBS:** We are measuring the physical **state** of the DNA (is it open? is a protein bound to it? is it methylated?). These events often happen outside of genes—in distant enhancers, promoters, or vast intergenic deserts. The `rowRanges` define the exact coordinates of that regulatory event (the peak or CpG site). To make biological sense of that peak, the software calculates its distance to the nearest Transcription Start Site and annotates it with that closest gene's name (which is why we see the `Symbol` and `distanceTSS` columns in the ATAC/ChIP tables).

| Assay | Signal Representation | Recommended Method | Key Considerations |
| --- | --- | --- | --- |
| **RNA-seq** | Coverage (numeric) | `w0` | Averages signal intensity (read depth), weighted by overlap. Used when plotting continuous RNA-seq BigWig tracks around specific genomic features (like the TSS or splice sites) in EnrichedHeatmap. |
| **RNA-seq** | Gene/Transcript Counts | `Median of Ratios` or `TPM` | Used for standard expression analysis rather than window averaging. TPM normalizes within-sample abundance; Median of Ratios (DESeq2) normalizes across samples for differential expression. |
| **ATAC-seq & ChIP-seq** | Peaks (binary) | `coverage` | Shows the fraction of the window covered by peaks. |
| **ATAC-seq & ChIP-seq** | Coverage (numeric) | `w0` | Averages signal intensity, weighted by overlap. This is recommended for BigWig data. |
| **WGBS** | CpG methylation (numeric) | `absolute` | Averages methylation values of individual CpG sites within the window. |

In short: RNA-seq counts the genes themselves, while epigenetic assays count regulatory regions and then tag them with the closest gene to hypothesize what they might be regulating.

## RNA-seq Data Analysis

RNA-seq normalization is a massive topic. The core problem we have to solve is that raw read counts are biased by two main factors: **sequencing depth** (some samples just get sequenced more deeply than others) and **gene length** (longer genes naturally accumulate more reads, even if they aren't more highly expressed).

Here is a breakdown of the standard normalization practices used in the field today.

### 1. Within-Sample Normalization (Relative Abundance)

These methods are used when we want to compare the expression of *Gene A* to *Gene B* within the exact same sample.

* **TPM (Transcripts Per Million):** This is the current gold standard for within-sample comparisons. It normalizes for gene length first, and then for sequencing depth. Because every sample sums to exactly one million TPM, it is much easier to compare relative proportions across samples.
The mathematical model for calculating TPM for a transcript $i$ is:

$$TPM_{i} = \left( \frac{q_{i}/l_{i}}{\sum_{j} q_{j}/l_{j}} \right) \times 10^{6}$$

*(Where $q_{i}$ is the read count and $l_{i}$ is the length of the transcript).*
* **FPKM / RPKM (Fragments / Reads Per Kilobase per Million):** We will see these in older papers. They normalize for depth first, then length. The major flaw is that the total sum of normalized reads differs between samples, making direct cross-sample comparisons mathematically inconsistent.

### 2. Between-Sample Normalization (Differential Expression)

When our goal is to compare *Gene A* in a control group versus *Gene A* in a treatment group, within-sample methods like TPM fail to account for **RNA composition bias** (where a few highly expressed genes "hog" all the reads).

* **Median of Ratios (used by DESeq2):** This method calculates a scaling factor for each sample. It takes the ratio of each gene's read count to its geometric mean across all samples, and then uses the median of these ratios to scale the library. It brilliantly ignores extreme outliers, ensuring that housekeeping genes stabilize the normalization.
* **TMM (Trimmed Mean of M-values, used by edgeR):** Very similar in philosophy to DESeq2. It trims away genes that have extreme fold-changes or extremely high/low absolute expression before calculating a scaling factor.

### Method Comparison

| Normalization Method | Primary Use Case | Accounts for Gene Length? | Accounts for Composition Bias? |
| --- | --- | --- | --- |
| **TPM** | Comparing genes within a sample (Abundance) | Yes | No |
| **Median of Ratios (DESeq2)** | Differential Gene Expression (DGE) | No | Yes |
| **TMM (edgeR)** | Differential Gene Expression (DGE) | No | Yes |

When performing Differential Gene Expression (DGE) analysis, tools like DESeq2 and edgeR expect *raw, unnormalized counts* as input because their statistical models (negative binomial distributions) need to estimate variance accurately, which is destroyed if we feed them pre-normalized metrics like TPM.

## EnrichedHeatmap

An EnrichedHeatmap is a specialized visualization used in bioinformatics to show how genomic signals (like read coverage or accessibility) are distributed *around* specific target regions (like transcription start sites or peaks).

Here is a breakdown of what we are looking at, component by component:

### Core Structure

* **The Grid (Matrix & Rows):** The main part of the image consists of four rectangular blocks of color. Every single horizontal line (row) within those blocks represents a specific genomic region.
* **The X-Axis (Axis):** The bottom labels show `-1kb`, `mid`, and `1kb`. This indicates that for every row, we are looking at a 2-kilobase window centered on a specific target (`mid`). If the mid point represents a Transcription Start Site (TSS), regulatory elements like promoters often span a few hundred to a couple of thousand base pairs around that site. A 2 kb window (1000 bp on either side) is usually wide enough to capture the entire regulatory landscape for that feature.
* **The Columns (Columns title):** The data is split into two experimental conditions or timepoints, labeled `E11.5` and `E15.5`. The note mentions that biological replicates are generally merged to show average differences in these columns.

### Preparing the Data

The EnrichedHeatmap itself doesn't calculate the "increase" or "decrease"—it just visualizes regions we have already grouped.

Before plotting, we run a **differential accessibility analysis** (using tools similar to DESeq2 or edgeR). We calculate the $\text{Log}_{2} \text{ fold-change}$ between the E15.5 and E11.5 read counts for every target region.

* Regions with a significantly positive fold-change are grouped as "Increased."
* Regions with a significantly negative fold-change are grouped as "Decreased."

These predefined groupings are then fed into the `EnrichedHeatmap` package, which organizes the rows and adds the corresponding row annotations (the red and blue bars).

### Reading the Data

* **The Heatmap (Color & Color scale):** The intensity of the red color represents the strength of the signal (e.g., chromatin accessibility). White means no signal; deep red means a strong signal.
* **The Groupings (Rows annotation & Rows order):** Notice the thick vertical bar on the far left. It is split into a red block and a blue block. According to the legend, the top group of rows (red bar) represents regions that have "Increased accessibility" over time, while the bottom group (blue bar) represents regions with "Decreased accessibility".

* If we look at the top group, the center (`mid`) is much darker red in `E15.5` than in `E11.5`.
* If we look at the bottom group, the center is bright red in `E11.5` but fades significantly in `E15.5`.

* **The Summary Lines (Profile plot):** The line graphs at the very top summarize the heatmap data. The red line shows the average signal for all the "Increased accessibility" regions, and the blue line shows the average for the "Decreased accessibility" regions. They peak at the `mid` point, matching the visual concentration of red in the heatmaps below.
