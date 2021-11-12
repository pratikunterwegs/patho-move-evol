
get_networks = function(datafile, assoc_threshold = 5) {
    load(datafile)

    # scenario
    scenario = data[["scenario"]]
    repl = data[["replicate"]]

    # edgelist collection and work
    el = data[["edgeLists"]]
    el = el[-1] # all edgelists except first

    el = lapply(el, function(le) {
      le = le[le$assoc > 1,]
      data.table::setDT(le)
      setnames(le, c("from", "to", "weight"))
      le = le[from != to,]
      le$to= le$to + 1
      le$from = le$from + 1

      le
    })

    # handle generations
    genmax = data[["genmax"]]
    genseq = seq(genmax / 10, genmax, by = (genmax / 10))
    genseq[length(genseq)] = last(genseq) - 1 # generations of edgelists

    # handle nodes
    nodes = data[["gen_data"]][["pop_data"]]
    nodes = nodes[data[["gen_data"]][["gens"]] %in% genseq] # id data for el

    # work on nodes
    nodes = Map(nodes, genseq, f = function(n, g) {
      n$gen = g
      n$id = seq(nrow(n))
      setDT(n)

      # assign scenario etc
      n$scenario = scenario
      n$repl = repl
      assign_movement_types(n)
      get_social_strategy(n)
      n
    })

    assertthat::assert_that(
      length(el) == length(nodes),
      msg = "make networks: nodes and edgelists have different lengths"
    )

    # make tidygraph objects
    g = Map(nodes, el, f = function(n, edges) {
      tidygraph::tbl_graph(
        nodes = n,
        edges = edges,
        directed = FALSE
      ) |>
      tidygraph::mutate(
        degree = tidygraph::centrality_degree(weights = weight),
        isolated = tidygraph::node_is_isolated()
      )
    })

    g
  }