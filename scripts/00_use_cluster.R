# load libraries
library(pathomove)
library(stringr)
library(glue)

# param file name
date = Sys.time() |> str_replace_all(" |:", "_")

password = readLines("data/password")

#### default case ###

# prepare parameters for default case
# param_file_default = glue("data/parameters/parameters_{date}_default.csv")

# pathomove::make_parameter_file(
#   scenario = 2,
#   popsize = 500,
#   nItems = 2000,
#   landsize = 50,
#   nClusters = 200,
#   clusterSpread = 0.5,
#   tmax = 100,
#   genmax = 5000,
#   g_patho_init = 3300,
#   range_food = 1,
#   range_agents = 1,
#   range_move = 1,
#   handling_time = 5,
#   regen_time = c(20, 50, 100),
#   pTransmit = "0.05",
#   initialInfections = 20,
#   costInfect = c(0.1, 0.25, 0.5),
#   nThreads = 1,
#   replicates = 5,
#   local_dispersal = TRUE,
#   infect_percent = FALSE,
#   which_file = param_file_default
# )

# # try sending in a job
# pathomove::use_cluster(
#   ssh_con = "p284074@peregrine.hpc.rug.nl",
#   password = password, 
#   script = "scripts/do_sim_pathomove.R",
#   folder = "patho-move-evol", 
#   template_job = "bash/main_job_maker_default.sh", 
#   parameter_file = param_file_default
# )

# #### global case ###

# # prepare parameters for global case
# param_file_global = glue("data/parameters/parameters_{date}_global.csv")

# pathomove::make_parameter_file(
#   scenario = 2,
#   popsize = 500,
#   nItems = 2000,
#   landsize = 50,
#   nClusters = 200,
#   clusterSpread = 0.5,
#   tmax = 100,
#   genmax = 5000,
#   g_patho_init = 3300,
#   range_food = 1,
#   range_agents = 1,
#   range_move = 1,
#   handling_time = 5,
#   regen_time = c(20, 50, 100),
#   pTransmit = "0.05",
#   initialInfections = 20,
#   costInfect = c(0.1, 0.25, 0.5),
#   nThreads = 1,
#   replicates = 5,
#   local_dispersal = FALSE,
#   infect_percent = FALSE,
#   which_file = param_file_global
# )

# # try sending in a job
# pathomove::use_cluster(
#   ssh_con = "p284074@peregrine.hpc.rug.nl",
#   password = password, 
#   script = "scripts/do_sim_pathomove.R",
#   folder = "patho-move-evol", 
#   template_job = "bash/main_job_maker_global.sh", 
#   parameter_file = param_file_global
# )

#### percent case ###

# prepare parameters for percent case
param_file_percent = glue("data/parameters/parameters_{date}_percent.csv")

pathomove::make_parameter_file(
  scenario = 2,
  popsize = 500,
  nItems = 2000,
  landsize = 50,
  nClusters = 200,
  clusterSpread = 0.5,
  tmax = 100,
  genmax = 1000,
  g_patho_init = 500,
  range_food = 1,
  range_agents = 1,
  range_move = 1,
  handling_time = 5,
  regen_time = c(10, 20, 50, 100),
  pTransmit = "0.05",
  initialInfections = 20,
  costInfect = c(0.025, 0.05, 0.075),
  nThreads = 1,
  replicates = 10,
  local_dispersal = FALSE,
  infect_percent = TRUE,
  which_file = param_file_percent
)

# try sending in a job
pathomove::use_cluster(
  ssh_con = "p284074@peregrine.hpc.rug.nl",
  password = password, 
  script = "scripts/do_sim_pathomove.R",
  folder = "patho-move-evol", 
  template_job = "bash/main_job_maker_percent.sh", 
  parameter_file = param_file_percent
)
