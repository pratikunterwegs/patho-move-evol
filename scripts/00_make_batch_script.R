#### script to make batch scripts for snevo ####
library(data.table)
library(glue)
library(stringr)

# param file name
param_file = "data/parameters/parameters_sc_0.csv"

# make parameter combinations
snevo::make_parameter_file(
  scenario = 0,
  popsize = 500,
  nItems = 500,
  landsize = 200,
  nClusters = 50,
  clusterSpread = c(2, 10),
  tmax = 100,
  genmax = 500,
  range_food = 1,
  range_agents = 1,
  handling_time = 5,
  regen_time = 50,
  pTransmit = "0.00",
  initialInfections = 2,
  costInfect = 0.00,
  nThreads = 2,
  replicates = 5,
  which_file = param_file
)

# the R binary path
Rbin = file.path(R.home("bin"), "Rscript.exe")

# make commands
lines = glue(
    "{Rbin}"
)

# file to run
rscript = "scripts/do_sim_snevo.R"

# nrow of parameter file
row_number = seq(nrow(fread(param_file)))

# make commands
lines = glue("{Rbin} {rscript} {param_file} {row_number}")
date = Sys.time() |> str_replace_all(" |:", "_")

# write batch file
writeLines(
    text = as.character(lines),
    con = glue("scripts/snevo_runs_{date}_sc_0.bat")
)

