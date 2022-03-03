
# Source Code and Supplementary Material for _Novel pathogen introduction rapidly alters the evolution of movement, restructuring animal societies_

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)


This is the source code for the analyses and figures for a manuscript that reports on a model of the evolution of social movement strategies, following the introduction of a novel pathogen to an animal population.
This work was developed in the [Modelling Adaptive Response Mechanisms Group (Weissing Lab)](https://www.marmgroup.eu/) at the Groningen Institute for Evolutionary Life Science, at the University of Groningen.

## Contact and Attribution

Please contact [Pratik Gupte](p.r.gupte@rug.nl) or [Franjo Weissing (PI)](f.j.weissing@rug.nl) for questions about the associated manuscript.

## Simulation Source Code

The simulation source code is provided at a different repository, [_Pathomove_](https://github.com/pratikunterwegs/pathomove).

## Simulation Data

The simulation data are originally generated on the University of Groningen's _Peregrine_ high-performance computing cluster (using the R code in the _scripts/_ folder: _scripts/00_use_cluster.R_).
Data used to produce the specific figures shown in the manuscript are available on the DataverseNL repository as a draft: **Dataverse draft**, and will be available at this persistent link after publication: **Dataverse permalink**.

## Analysis Functions

The simulation data are summarised by a series of _R_ functions, and these functions can be accessed under the namespace _mspathomove_ using the command _devtools::load\_all()_ (essentially, creating a temporary package).
These functions are in the directory _R/_, and are documented in the directory _man/_.

Simple explainers of the functions are given below.

- _R/fun\_get\_move\_types.R_

    - _get\_functional\_variation_: A function to normalise the evolved cue preferences.

    - _assign\_movement\_types_: A function to assign qualitative movement types. NB: No longer used, retained for future reference.

- _R/fun\_get\_social\_strat.R_

    - _get\_social\_strategy_: A function to assign a social movement strategy to individuals based on the signs of the preferences for successful and unsuccessful foragers.

    - _get\_si\_importance_: A function to calculate the importance of social information to individuals' movement strategies. Relies on the function _get\_functional\_variation_.

    - _get\_agent\_avoidance_: A function to calculate the extent to which avoidance of other individuals contributes to the focal individual's movement strategy. Requires a data.frame with previously normalised individual preferences.

- _R/fun\_process\_networks.R_

    - _get\_networks_: A function to handle pairwise individual association data returned from the _Pathomove_ simulation. These data, in the form of a _list_ object of edge lists (i.e., id1, id2, id1-id2 associations), are converted into a _tidygraph_ object, which is essentially a form of _igraph_ object. The output is a list of graphs, or social networks, one per generation _G_, where _G_ is in increments of 10% of the total number of generations. E.g.: For 5,000 generations, there are 11 social networks, for _G_ = 0, 500, 1000 ... 4500, 5000.

    - _handle\_sir\_data_: A function to handle the output of SIR models run on any of the social networks accessed by _get\_networks_. Returns a data.frame with SIR model replicate id, timesteps, and the number of individuals susceptible, infected, and recovered. 

## Analysis Source Code

The source code for the analyses reported here can be found in the directory `scripts/`, and are explained briefly here:

- _scripts/00_use_cluster.R_: Passes the simulation run commands to the University of Groningen's _Peregrine_ high-performance computing cluster. May also work with HPC cluster running Ubuntu, with required libraries installed, and with a SLURM-scheduler. Use with caution.

- _scripts/00_make_batch_script.R_: An alternative to using an HPC cluster, written for Windows systems. Makes a batch script and parameter set to run simulations in sequence. Use with caution.

- _scripts/01_process_eco_evo_data.Rmd_: Process the output, in the form of _Rds_ objects, that result from running _Pathomove_ replicates or parameter combinations.

- _scripts/02_process_networks.Rmd_: Process the pairwise individual associations logged during the simulation into social networks.

- _scripts/03_sir_models.Rmd_: Run SIR models on the emergent social networks acquired from simulation runs.

## Figure Source Code

The source code for the figures in this manuscript is in the directory _figure_scripts/_; one script per figure, numbered in the figure order. These scripts are not explained further.

## Main Text

The main text of the manuscript is written in LaTeX and is stored in the (private) submodule, `ms-kleptomove`. A dated version rendered as PDF can be found in the directory `docs/` -- `docs/ms_pathomove_DATE.pdf`, where `DATE` is the date the manuscript was rendered.

## Supplementary Material

The supplementary material provided with this manuscript is generated from the `supplement/` directory. A dated version rendered as PDF can be found in the directory `docs/` -- `docs/ms_kleptomove_supplementary_material_DATE.pdf`, where `DATE` is the date the manuscript was rendered.

- `supplement/spm_01_landscapes.Rmd` Code for figures 1.1 -- 1.3.

- `supplement/spm_02_weight_evolution.Rmd` Code for figures 2.1 -- 2.3.

- `supplement/figures` Figure output for the supplementary material file.

- `supplement/latex` LaTeX options for the supplementary material file.

Other files relate to formatting.

## Other Directories

- `bash/` Some useful shell scripts for output rendering.
