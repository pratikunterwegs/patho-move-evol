
# Source Code and Supplementary Material for _Novel pathogen introduction triggers rapid evolution in animal social movement strategies_

This is the source code for the analyses and figures for a manuscript that reports on a model of the evolution of social movement strategies, following the introduction of a novel pathogen to an animal population.
This work was developed in the [Modelling Adaptive Response Mechanisms Group (Weissing Lab)](https://www.marmgroup.eu/) at the Groningen Institute for Evolutionary Life Science, at the University of Groningen.

## Contact and Attribution

Please contact [Pratik Gupte](p.r.gupte@rug.nl) for questions on the model or the associated project.

```md
Name: Pratik Rajan Gupte
Email: pratikgupte16@gmail.com OR p.r.gupte@rug.nl
ORCID: https://orcid.org/0000-0001-5294-7819
```

Cite this repository archived on Zenodo as

```bibtex
@software{pratik_rajan_gupte_2022_6341440,
  author       = {Pratik Rajan Gupte and
                  Gregory F. Albery and
                  Jakob Gismann and
                  Amy R. Sweeny and
                  Franz J. Weissing},
  title        = {{Source Code and Supplementary Material for "Novel 
                   pathogen introduction rapidly alters the evolution
                   of movement, restructuring animal societies"}},
  month        = mar,
  year         = 2022,
  publisher    = {Zenodo},
  version      = {v1.0.1},
  doi          = {10.5281/zenodo.6341440},
  url          = {https://doi.org/10.5281/zenodo.6341440}
}
```

## Simulation Source Code

The simulation source code is provided in a different repository, [_Pathomove_](https://github.com/pratikunterwegs/pathomove).
The _Pathomove_ simulation is archived on Zenodo as https://zenodo.org/record/6331816, and can be cited as

```bibtex
@software{pratik_gupte_2022_6331816,
  author       = {Pratik Gupte},
  title        = {{Source code for Pathomove, an individual-based 
                   model for the evolution of animal movement
                   strategies under the risk of pathogen transmission}},
  month        = mar,
  year         = 2022,
  publisher    = {Zenodo},
  version      = {v1.0.2},
  doi          = {10.5281/zenodo.6331816},
  url          = {https://doi.org/10.5281/zenodo.6331816}
}
```

## Simulation Data

The simulation data are originally generated on the University of Groningen's _Peregrine_ high-performance computing cluster (using the R code in the `scripts/` folder: `scripts/00_use_cluster.R`).

The data used for this the manuscript are available on Zenodo at https://zenodo.org/record/6331757.

Please cite the simulation data as:

```bibtex
@dataset{pratik_rajan_gupte_2022_6331757,
  author       = {Pratik Rajan Gupte},
  title        = {{Reference data from the Pathomove simulation, for 
                   the manuscript "Novel pathogen introduction
                   rapidly alters the evolution of movement,
                   restructuring animal societies"}},
  month        = mar,
  year         = 2022,
  publisher    = {Zenodo},
  version      = {v1.0},
  doi          = {10.5281/zenodo.6331757},
  url          = {https://doi.org/10.5281/zenodo.6331757}
}
```

### Sample dataset

A sample dataset --- one simulation replicate with a small number of individuals, over a small number of generations --- is provided in the Supplementary Material, under the directory `supplement` as `supplement/data/test_sim_output_data.Rds`.
This data can be analysed using the script `supplement/05_try_sim.Rmd` to get a feel for how the simulation works.

---

## Workflow: Running Simulation Replicates

**Warning**: This is a relatively advanced computational study. Replicating it requires many interacting components. Please do _not_ expect it to work out of the box.

A brief description of this workflow is:

1. Download and install the _Pathomove_ simulation Rcpp package from https://github.com/pratikunterwegs/pathomove locally (on your computer).

2. Download this repository locally.

3. If you intend to simply try out this simulation, run the script `supplement/05_try_sim.Rmd`. Look through the script for instructions on how to access the simulation output.

    A rough guide to running the simulation is also included in the Supplementary Material associated with the _biorXiv_ manuscript as a PDF.

    **Please note**: If you intend to fully replicate the analyses here, move to the sub-section below. This is a challenging task which cannot be simplified, and should be attempted with care.

4. Run the simulation with the required parameter combinations. Parameter combinations used in this study are found in `data/parameters/`.

5. Collect the simulation output in `data/output/`, and analyse it using the scripts in `scripts/`. Analysis scripts are written to find the output in `data/output/`.

6. Prepare figures using the scripts in `figure-scripts/`.

### Replicating analyses

1. Download and install the _Pathomove_ simulation Rcpp package from https://github.com/pratikunterwegs/pathomove using:

    For Linux systems (The equivalent Windows commands are similar except that `R` is launched differently)

    ```sh
    # shell command
    git clone git@github.com:pratikunterwegs/pathomove.git
    
    # in the pathomove directory
    cd pathomove
    
    # launch R
    R
    ```

    ```r
    # R commands
    devtools::build()
    devtools::install()
    ```

    **OR**

    Install directly from an R terminal without downloading the simulation package source code separately.

    ```r
    # R commands
    devtools::install_github("pratikunterwegs/pathomove")
    ```

    You should be prompted to also install the simulation dependencies, `Rcpp`, `RcppParallel`, and `BH` (Boost Headers).

2. Download this repository, using:

    ```sh
    git clone git@github.com:pratikunterwegs/patho-move-evol.git
    ```

3. In this repository, prepare an R script that runs a single replicate of the simulation.

    This script should essentially run the commands

    ```r
    # R command to run simulation and save output
    data = pathomove::run_pathomove(...)

    # save data as Rds object
    saveRDS(data, file = "data/output/output_N.Rds")
    ```

    This script should be able to take command line arguments, including at least: (1) the name of a file containing parameter combinations, and (2) the row number in the parameter file, indicating which combination should be run.

    An example of such a script (which is also used in our analyses) is `scripts/do_sim_pathomove.R`. This script should specify where to save the simulation output, and the file type. We recommend saving `.Rds` (R data) files to `data/output`.

At this stage, there are two options:

- Running simulation replicates locally (on your computer), or,
- Running simulation replicates on a high-performance computing (HPC) cluster.

### Replicating Analyses: Running Simulation Replicates Locally

Continuing from (3.):

4. Prepare a file with parameter combinations, and a shell script that instructs R to run the script from (3.), taking as arguments the parameter file, and a row number.

    - The same procedure applies for multiple replicates of the same parameter combination.

    - An example of a script which automates these processes, for Windows systems, is `scripts/00_make_batch_script.R`.

    - This script generates `.bat` batch files. Run the batch file.

    - Simulation output in the form of `Rds` files should be saved to `data/output`, or some other path that you have chosen.

### Replicating Analyses: Running Simulation Replicates on an HPC Cluster

Continuing from (3.):

4. Prepare a file with parameter combinations.

    - The same procedure applies for multiple replicates of the same parameter combination.

5. Prepare a directory structure to store the output. A template directory structure can be found at https://github.com/pratikunterwegs/patho-move-evol.

    There should be at least the following paths:

    ```md
    yourFolder
    ├───bash
    ├───data
    │   ├───output
    │   ├───parameters
    └───scripts
    ```

6. Prepare a template job. An example is found in `bash/main_job_maker.sh`. This script is written for an Ubuntu-based, SLURM-scheduler HPC cluster.

7. Run the following commands locally from `R`. The specific commands, and parameter combinations used in this study are found in `scripts/00_use_cluster.R`.

    ```r
    # this should be your R terminal
    # be careful about working directories etc.
    # load the package locally
    library(pathomove)

    # make a parameter file with all the combinations required
    # or with multiple replicates
    pathomove::make_parameter_file(
    ...,
    replicates = N,
    which_file = "some parameter file name.csv"
    )

    # above, ... indicates the simulation parameters

    # use the use_cluster function to send in jobs
    pathomove::use_cluster(
        ssh_con = "ssh connection to your HPC cluster",
        password = "your HPC password", 
        script = "your simulation run script", # e.g. scripts/do_sim_pathomove.R
        folder = "yourFolder", # folder for the output
        template_job = "template job shell script",  # the shell script from (5)
        parameter_file = "some parameter file name.csv" # the parameter data
    )
    ```

8. Simulation output should be returned as `Rds` files into the `data/output` folder specified above _on the cluster_, or your custom equivalent. Move these `Rds` files to your local system for further analysis.

---

## Workflow: Analysing Output

1. Gather simulation output data in the form of `Rds` files in the `data/output/` folder.

2. Process the output by running, in sequence the analysis source code described below.

### Analysis Source Code

The source code for the analyses reported here can be found in the directory `scripts/`, and are explained briefly here:

- `scripts/01_process_eco_evo_data.Rmd`: Process the output, in the form of _Rds_ objects, that result from running _Pathomove_ replicates or parameter combinations.

- `scripts/02_process_networks.Rmd`: Process the pairwise individual associations logged during the simulation into social networks.

    - These two steps create the directory structure:

    ```md
    .
    ├── data
    │   ├── 00_data.txt
    │   ├── output
    │   │   └── 00_output_exists.txt
    │   ├── parameters
    │   │   ├── 00_parameters.txt
    │   └── results
    │       ├── 00_data.txt
    │       ├── gen_data
    │       ├── morph_data
    │       ├── networks
    │       └── si_imp_data
    ```

    - `gen_data/` holds data on the individuals in each generation stored from the simulation.
    - `morph_data/` holds data on the proportions of the social movement strategies in each stored generation.
    - `si_imp_data/` holds data on the importance of social information to movement strategies in each stored generation.

        Across these data, there is one `.csv` file per simulation replicate.

    - `networks/` holds `.Rds` files which store the social networks emerging over the simulation; each file is for one simulation replicate, and holds a `list` object whose components are `tidygraph` network objects.

- `scripts/03_sir_models.Rmd`: Run SIR models on the emergent social networks acquired from simulation runs.

### Helper scripts

Used in previous steps.

- `scripts/00_use_cluster.R`: Passes the simulation run commands to the University of Groningen's _Peregrine_ high-performance computing cluster. May also work with HPC cluster running Ubuntu, with required libraries installed, and with a SLURM-scheduler. Use with caution.

- `scripts/00_make_batch_script.R`: An alternative to using an HPC cluster, written for Windows systems. Makes a batch script and parameter set to run simulations in sequence. Use with caution.

---

## Figure Source Code

The source code for the figures in this manuscript is in the directory `figure_scripts/`. These scripts are well commented, and are not explained further.

## Manuscript Text

The main text of the manuscript is written in LaTeX and is stored in the (private) submodule, `ms-pathomove`.
Using the shell scripts provided in `bash/`, the LaTeX files are converted into date-stamped PDFs.
These are not uploaded here, but the `docs/` folder indicates their storage location.

## Supplementary Material

The supplementary material provided with this manuscript is generated from the `supplement/` directory.

- `supplement/01_model_description.Rmd` Displays a schematic of the simulation model, and produces an example landscape.

- `supplement/02_comparing_ecological_outcomes.Rmd` Includes a figure comparing ecological outcomes across simulation replicates.

- `supplement/03_modelling_global_dispersal.Rmd` Shows simulation outcomes when modelling global dispersal.

- `supplement/04_modelling_percent_infection.Rmd` Shows simulation outcomes when modelling percentage infection costs.

- `supplement/05_modelling_sporadic_introductions.Rmd` Shows simulation outcomes when modelling the introduction of novel pathogens in only some generations (determined probabilistically) after the initial introduction.

- Other files in this directory are helper files required to format the supplementary material.

## Other Directories

- `bash/` Some useful shell scripts for output rendering.
