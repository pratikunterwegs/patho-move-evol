
library(snevo)
library(data.table)

data = run_pathomove(
    scenario = 0,
    popsize = 50,
    nItems = 1000,
    landsize = 50,
    nClusters = 100,
    clusterSpread = 1,
    tmax = 100,
    genmax = 20,
    range_food = 1.0,
    range_agents = 1.0,
    range_move = 1.0,
    handling_time = 5,
    regen_time = 50,
    pTransmit = 0.05,
    initialInfections = 10,
    costInfect = 0.2,
    nThreads = 2
)

names(data)

