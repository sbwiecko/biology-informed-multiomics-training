[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
[![Forked from sib-swiss](https://img.shields.io/badge/Forked%20from-sib--swiss-blue)](https://github.com/sib-swiss/biology-informed-multiomics-training)

# Biology-Informed Multi-Omics: A Wet-Lab Scientist's Study Fork

Welcome! This repository is an annotated, restructured study fork of the [SIB Swiss Institute of Bioinformatics Multi-Omics Training Course](https://github.com/sib-swiss/biology-informed-multiomics-training).

I come from a **wet-lab background** and am investing significant effort into transitioning toward computational biology. To make the learning curve manageable and fully focus on the code and biology, **I simplified the project architecture**: I removed the Docker containers and Quarto website infrastructure in favor of standalone **Jupyter Notebooks (`.ipynb`) and clean Markdown files**.

---

## What You Will Find in This Fork

* **Streamlined Interactive Format:** Converted from the original `.qmd` files into pure Jupyter Notebooks (`.ipynb`) (via `quarto convert`, configured to use the R kernel via `jupyter: ir` in the YAML front matter) for direct, interactive execution.
* **Wet-Lab Context & Concept Deconstruction:** Line-by-line notes translating abstract computational steps into biological meaning.
* **Troubleshooting & Technical Deep Dives:** Detailed reflections and extra research on tricky parameters, Bioconductor quirks, and statistical assumptions.
* **Refactored & Annotated Code:** Code cells with additional comments explaining the *why* behind data transformations.
* **Beginner-Friendly Focus:** Written specifically for researchers without formal bioinformatics degrees who want to understand multi-omics integration step by step.

---

## Analytical Workflow Covered

1. **Multi-Layer Integration:** Importing and processing ATAC-seq, RNA-seq, ChIP-seq, and Bisulfite-seq datasets in R/Bioconductor.
2. **Overlap Matrices:** Quantifying co-occurrence across layers to detect epigenetic and transcriptional co-regulation.
3. **Downstream Analysis:** Functional annotation and pathway enrichment.
4. **Data Visualization:** Creating interpretable plots for multi-layer data.

---

## Setup & Running the Notebooks

**Prerequisite:** You must have **R** installed on your system.

No Docker or Quarto setup is required. The project relies on `renv` to manage dependencies. Since these are standard Jupyter Notebooks (`.ipynb`) with an R kernel, you can run them locally using **VS Code**.

### 1. Clone the repository

```bash
git clone https://github.com/sbwiecko/biology-informed-multiomics-training.git
cd biology-informed-multiomics-training
```

### 2. Restore the R environment

Open R in your terminal, console, or IDE to restore dependencies via `renv`:

```R
install.packages("renv")
renv::restore()
```

### 3. Running in VS Code

1. **Configure VS Code Working Directory (Crucial):** To guarantee that Jupyter always activates `.Rprofile` and locates your `renv` library, force VS Code to run kernels from the project root.
   - Open Settings (`Ctrl + ,` or `Cmd + ,`).
   - Search for: `Jupyter Notebook File Root`.
   - Set the value to: `${workspaceFolder}`.
2. **Register the Project Kernel:**
   ```R
   renv::install("IRkernel")
   IRkernel::installspec(name = "ir_multiomics", displayname = "R (multiomics-renv)")
   ```
3. Open any `.ipynb` notebook.
4. Click **Select Kernel** in the top-right -> **Jupyter Kernel...** -> **R (multiomics-renv)**.

> **Optional check:** You can always run `.libPaths()` in a notebook's first cell to verify that packages are loading from the project's local `./renv/library`.

---

## Connect & Discuss

If you are also bridging the gap between wet-lab biology and bioinformatics, feel free to explore the notebooks, open an issue, or ask a question. Feedback, corrections, and discussions are always welcome!

---

## Credits & Upstream Authors

This repository is built upon the open course materials designed by the **SIB Swiss Institute of Bioinformatics**:

* **Original Course Site:** [https://sib-swiss.github.io/biology-informed-multiomics-training/](https://sib-swiss.github.io/biology-informed-multiomics-training/)
* **Original Repository:** [sib-swiss/biology-informed-multiomics-training](https://www.google.com/url?sa=E&source=gmail&q=https://github.com/sib-swiss/biology-informed-multiomics-training)
* **Authors:** Deepak Tanwar, Geert van Geest, Patricia Palagi
* **Helper:** Joana Carlevaro-Fita
* **Original DOI:** [10.5281/zenodo.5703106](https://doi.org/10.5281/zenodo.5703106)