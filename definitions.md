- ATAC-seq (Assay for Transposase-Accessible Chromatin using sequencing) is a rapid molecular biology method used to map open, accessible regions of DNA across the genome. [How ATAC-seq works:](https://i0.wp.com/bioinfo-fr.net/wp-content/uploads/2018/09/ATAC-seq.png?resize=724%2C1024&ssl=1)
  1. Tagmentation: A hyperactive mutant enzyme called Tn5 transposase is loaded with sequencing adapters. It cuts DNA and inserts these adapters simultaneously only into open, uncompacted chromatin regions.
  2. Amplification & Sequencing: The tagged DNA fragments are purified, amplified using PCR, and read using next-generation sequencing.
  3. Peak Analysis: Bioinformatics tools map the resulting sequences back to the genome. Clusters of reads form "peaks" that show where the chromatin was open, revealing active gene promoters, enhancers, and transcription factor binding sites.
- ChIP-seq (Chromatin Immunoprecipitation Sequencing) is a powerful laboratory technique used to find where specific proteins bind to DNA across the entire genome. [How ChIP-seq works:](https://microbenotes.com/wp-content/uploads/2024/09/ChIP-Sequencing-ChIP-seq.jpeg)
  1. Cross-linking: Treat cells with a chemical like formaldehyde to freeze and bind proteins to their current spots on the DNA.
  2. Fragmentation: Break the chromatin into smaller, manageable pieces using sound waves or enzymes (sonication).
  3. Immunoprecipitation: Add a specific antibody that attaches only to your protein of interest, allowing you to pull down that protein and its stuck DNA fragment.
  4. Reversal and Purification: Remove the chemical cross-links, get rid of the protein, and isolate the remaining bound DNA pieces.
  5. Sequencing and Alignment: Send the purified DNA fragments for high-throughput sequencing, then use computers to map the reads back to a reference genome.
- Whole-genome bisulfite sequencing (WGBS) is the gold-standard next-generation sequencing method used to map DNA methylation at single-base resolution across an entire genome. By treating genomic DNA with sodium bisulfite, researchers can differentiate between methylated and unmethylated cytosines.[How WGBS works:]()
  1. Denaturation: Double-stranded genomic DNA is separated into single strands using heat.
  2. Bisulfite Treatment: The DNA is treated with sodium bisulfite.
     1. Unmethylated cytosines undergo hydrolytic deamination and convert into uracil (U).
     2. Methylated cytosines (5mC) are chemically protected and remain unchanged (C).
  3. PCR Amplification: During PCR, the converted uracils are amplified as thymines (T), while the protected methylated cytosines are amplified as cytosines (C).
  4. Sequencing & Alignment: The final library is sequenced using a high-throughput platform. Computational pipelines (like Bismark) align the C-to-T altered reads back to a reference genome to determine the exact methylation ratio at every single site.