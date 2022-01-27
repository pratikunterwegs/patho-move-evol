# load libraries
library(pathomove)
library(stringr)
library(glue)

# param file name
date = Sys.time() |> str_replace_all(" |:", "_")
param_file = glue("data/parameters/parameters_{date}.csv")

password = readLines("data/password")

# prepare parameters
pathomove::make_parameter_file(
  scenario = 2,
  popsize = 500,
  nItems = 1800,
  landsize = 60,
  nClusters = 60,
  clusterSpread = 1,
  tmax = 300,
  genmax = 5000,
  g_patho_init = 3000,
  range_food = 1,
  range_agents = 1,
  range_move = 1,
  handling_time = 5,
  regen_time = c(20, 50, 100),
  pTransmit = "0.05",
  initialInfections = 20,
  costInfect = c(0.01, 0.02, 0.05),
  nThreads = 1,
  replicates = 5,
  which_file = param_file
)

# try sending in a job
pathomove::use_cluster(
  ssh_con = "p284074@peregrine.hpc.rug.nl",
  password = password, 
  script = "scripts/do_sim_pathomove.R",
  folder = "patho-move-evol", 
  template_job = "bash/main_job_maker.sh", 
  parameter_file = param_file
)
