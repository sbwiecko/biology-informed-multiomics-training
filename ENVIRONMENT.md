# Environment Setup: renv & Jupyter Notebook in VS Code

*renv* (R Environments) isolates project-specific dependencies, similar to Python virtual environments.

## Project Components

* `renv.lock`: Records exact package versions and hashes for reproducibility (like `poetry.lock` or `requirements.txt`).
* `renv/`: Project library referencing cached packages via symlinks.
* `.Rprofile`: Automatically activates the project library whenever R initializes in this directory.

## Standard renv Workflow

1. **Restore dependencies:** In the R console, run:
   ```R
   renv::restore()
   ```
2. **Install new packages:** Run `install.packages("pkg_name")` in R; packages save to the local library.
3. **Save changes:** Run `renv::snapshot()` to update `renv.lock`.

## Working with Jupyter Notebooks in VS Code

Jupyter does not automatically detect an `renv` environment unless the R kernel (`IRkernel`) is registered from inside that specific environment.

### 1. Register the Project Kernel

Inside your active `renv` R console, ensure `IRkernel` is installed and register a kernel specifically for this project:

```R
# Install IRkernel inside the renv environment if not present
renv::install("IRkernel")

# Register the kernel with a distinct display name
IRkernel::installspec(name = "ir_project_env", displayname = "R (Project renv)")
```

### 2. Configure VS Code

1. Open your `.ipynb` notebook in VS Code.
2. Click **Select Kernel** in the top-right corner.
3. Choose **Jupyter Kernel...** -> **R (Project renv)**.

### 3. Verify renv is Active in the Notebook

Run this in the first cell of your notebook to confirm it is pointing to the project library rather than your global system library:

```R
.libPaths()
```

The output should list paths pointing to the project's local `renv/library` directory.
