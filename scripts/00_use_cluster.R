
# load libraries
library(snevo)
library(stringr)
library(glue)

# param file name
date = Sys.time() |> str_replace_all(" |:", "_")
param_file = glue("data/parameters/parameters_{date}.csv")

# make parameter combinations
snevo::make_parameter_file(
  scenario = c(0, 1, 2),
  popsize = 500,
  nItems = 1440,
  landsize = 60,
  nClusters = 60,
  clusterSpread = 1,
  tmax = 100,
  genmax = 5000,
  range_food = 2,
  range_agents = 2,
  range_move = 1,
  handling_time = 5,
  regen_time = 60,
  pTransmit = "0.05",
  initialInfections = 20,
  costInfect = 0.25,
  nThreads = 2,
  replicates = 3,
  which_file = param_file
)

# try sending in a job
snevo::use_cluster(
  ssh_con = "p284074@peregrine.hpc.rug.nl",
  password = password, 
  script = "scripts/do_sim_snevo.R", 
  template_job = "bash/main_job_maker.sh", 
  parameter_file = param_file
)
