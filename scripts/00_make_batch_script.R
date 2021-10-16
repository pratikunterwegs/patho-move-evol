#### script to make batch scripts for snevo ####
library(data.table)
library(glue)
library(stringr)

# param file name
param_file = "data/parameters/parameters_all.csv"

# make parameter combinations
snevo::make_parameter_file(
  scenario = c(0, 1, 2),
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
  regen_time = 20,
  pTransmit = "0.05",
  initialInfections = 10,
  costInfect = 0.2,
  nThreads = 2,
  replicates = 5,
  which_file = param_file
)

# the R binary path
Rbin = file.path(R.home("bin"), "Rscript.exe")

# file to run
rscript = "scripts/do_sim_snevo.R"

# nrow of parameter file
row_number = seq(nrow(fread(param_file)))

# make commands
lines = c("cd ../", glue("{Rbin} {rscript} {param_file} {row_number}"))
date = Sys.time() |> str_replace_all(" |:", "_")

# write batch file
writeLines(
    text = as.character(lines),
    con = glue("scripts/snevo_runs_{date}_sc_all.bat")
)
