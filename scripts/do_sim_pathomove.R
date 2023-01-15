#### Script to run the pathomove simulation in an HPC run ####
args <- commandArgs(TRUE)

# print the working directory
message(getwd())

# access parameter file
param_file <- args[1]
# get the row to read from the parameter file
row_n <- as.numeric(args[2])
# get the scenario type
# argument 3 is the array id
scenario_tag <- args[3]

# print the file identity to screen (to the output log)
message(
  paste("Reading parameter file:", param_file)
)

# print the row to screen
message(
  paste("Reading parameters from row:", row_n)
)

# read the parameter file in
params <- read.csv(param_file)

# get replicate and remove from params
replicate <- params[row_n, "replicate"]

# print the R version
version
# print the pathomove package version
devtools::package_info("pathomove", dependencies = FALSE)

# load library
library(pathomove)

# print to log
writeLines(
  c(
    "\n",
    "#### Scenario information ####"
  )
)

# run simulation
data <- do.call(
  run_pathomove,
  as.list(
    subset(params, select = -c(replicate))[row_n, ]
  )
)

# append full list of parameters and the scenario tag
data <- list(
  output = data,
  params = as.list(params[row_n, ]),
  scenario_tag = scenario_tag
)

seed <- params$seed[row_n]

# name of rdata file
output_file <- glue::glue(
  "data/output/scenario_{scenario_tag}_{seed}.Rds"
)

# save
saveRDS(
  data,
  file = output_file
)
