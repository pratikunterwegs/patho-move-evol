#### script to make batch scripts for pathomove ####
library(data.table)
library(glue)
library(stringr)
library(ggplot2)

# param file name
date = Sys.time() |> str_replace_all(" |:", "_")
param_file = glue("data/parameters/parameters_{date}.csv")

# vis landscape
d = pathomove::get_test_landscape(
  nItems = 1200,
  landsize = 60,
  nClusters = 60,
  clusterSpread = 1,
  regen_time = 20
)

ggplot(d)+
  geom_point(
    aes(x,y,col=tAvail),
    alpha = 0.5,
    size = 1
  )+
  scale_colour_viridis_b(
    option = "H"
  )+
  coord_equal()

# make parameter combinations
pathomove::make_parameter_file(
  scenario = 2,
  popsize = 500,
  nItems = 1800,
  landsize = 60,
  nClusters = 60,
  clusterSpread = 1,
  tmax = 500,
  genmax = 5000,
  range_food = 1,
  range_agents = 1,
  range_move = 1,
  handling_time = 5,
  regen_time = c(20, 50, 100),
  pTransmit = "0.05",
  initialInfections = 20,
  costInfect = c(0.1, 0.25, 0.5),
  nThreads = 2,
  replicates = 5,
  which_file = param_file
)

# the R binary path
Rbin = file.path(R.home("bin"), "Rscript.exe")

# file to run
rscript = "scripts/do_sim_pathomove.R"

# nrow of parameter file
row_number = seq(nrow(fread(param_file)))

# make commands
lines = c("cd ../", glue("{Rbin} {rscript} {param_file} {row_number}"))


# write batch file
writeLines(
    text = as.character(lines),
    con = glue("scripts/pathomove_runs_{date}_sc_all.bat")
)
