#### script to make batch scripts for snevo ####
library(data.table)
library(glue)
library(stringr)
library(ggplot2)

# param file name
date = Sys.time() |> str_replace_all(" |:", "_")
param_file = glue("data/parameters/parameters_{date}.csv")

# vis landscape
d = snevo::get_test_landscape(
  nItems = 1440,
  landsize = 60,
  nClusters = 60,
  clusterSpread = 1,
  regen_time = 20
)

ggplot(d)+
  geom_point(
    aes(x,y,col=tAvail),
    alpha = 0.5,
    size = 2
  )+
  scale_colour_viridis_b(
    option = "H"
  )+
  coord_equal()

# make parameter combinations
snevo::make_parameter_file(
  scenario = c(2),
  popsize = 500,
  nItems = 1440,
  landsize = 60,
  nClusters = 60,
  clusterSpread = 1,
  tmax = 100,
  genmax = 5000,
  range_food = 1,
  range_agents = 1,
  range_move = 1,
  handling_time = 5,
  regen_time = 100,
  pTransmit = "0.05",
  initialInfections = 25,
  costInfect = 0.25,
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


# write batch file
writeLines(
    text = as.character(lines),
    con = glue("scripts/snevo_runs_{date}_sc_all.bat")
)
