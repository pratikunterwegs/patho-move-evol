#### script to make batch scripts for pathomove ####
library(data.table)
library(glue)
library(stringr)
library(ggplot2)

# param file name
date <- Sys.time() |> str_replace_all(" |:", "_")

scenario_tag <- "default"
# prepare parameters for default case
param_file_default <- glue(
  "data/parameters/parameters_{date}_{scenario_tag}.csv"
)

pathomove::make_parameter_file(
  scenario = 1,
  popsize = 500,
  nItems = 1800,
  landsize = 60,
  nClusters = 60,
  clusterSpread = 1,
  tmax = 100,
  genmax = 5000,
  g_patho_init = 3000,
  range_food = 1,
  range_agents = 1,
  range_move = 1,
  handling_time = 5,
  regen_time = c(20, 50, 100),
  pTransmit = 0.05,
  initialInfections = 20,
  costInfect = c(0.1, 0.25, 0.5),
  multithreaded = FALSE,
  replicates = 10,
  dispersal = 2.0, # for local-ish dispersal
  vertical = FALSE,
  infect_percent = FALSE,
  mProb = 0.01,
  mSize = 0.01,
  spillover_rate = 0.0,
  which_file = param_file_default
)

# the R binary path
Rbin <- file.path(R.home("bin"), "Rscript.exe")

# file to run
rscript <- "scripts/do_sim_pathomove.R"

# nrow of parameter file
row_number <- seq(nrow(fread(param_file)))

# make commands
lines <- c(
  "cd ../",
  glue("{Rbin} {rscript} {param_file} {row_number} {scenario_tag}")
)

# write batch file
writeLines(
  text = as.character(lines),
  con = glue("scripts/pathomove_runs_{date}_sc_all.bat")
)
