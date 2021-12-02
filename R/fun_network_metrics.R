
#' Get network global efficiency.
#'
#' @param g An igraph or tidygraph object.
#' @param vertices Number of nodes, 500 by default.
#'
#' @return A numeric global efficiency value.
#' @export
get_global_efficiency = function(g, vertices = 500) {
  size = igraph::gsize(g)
  diameter = igraph::diameter(g)
  
  diameter * vertices / size
  
}

#' Get wrapped distance.
#'
#' @param x1 X coord 1.
#' @param y1 Y coord 1.
#' @param x2 X coord 2.
#' @param y2 Y coord 2.
#' #' @param vertices Number of nodes, 500 by default.
#'
#' @return A numeric global efficiency value.
#' @export
get_wrapped_distance = function(x1, y1, x2, y2, max_dist = 50) {
  sqrt((x2 - x1)^2 + (y2 - y1)^2) %% max_dist
}

#' Get landscape distance between individual positions.
#'
#' @param g An igraph or tidygraph object.
#'
#' @return A data.table of edges with landscapes distances between nodes.
#' @export
get_edge_distance = function(g) {
  edges = data.frame(activate(g, edges))
  data.table::setDT(edges)
  
  nodes = data.frame(activate(g, nodes))
  data.table::setDT(nodes)
  nodes = nodes[, c("id", "x", "y")]

  # link nodes and edges
  edges = data.table::merge.data.table(
    edges, nodes,
    by.x = "from",
    by.y = "id"
  )
  edges = data.table::merge.data.table(
    edges, nodes,
    by.x = "to",
    by.y = "id"
  )
  data.table::setnames(
    edges, c("x.x", "y.x", "x.y", "y.y"),
    c("x1", "y1", "x2", "y2")
  )
  edges[, distance := unlist(Map(x1, y1, x2, y2, f = get_wrapped_distance))]
  edges[, !c("x1", "y1", "x2", "y2")]
}

#' Get connections between social strategies.
#'
#' @param g An igraph or tidygraph object, with node data containing social
#' strategy information.
#'
#' @return A tidygraph network of connections between social strategies.
#' @export
get_strategy_networks = function(g) {
  edges = data.frame(activate(g, edges))
  data.table::setDT(edges)
  
  nodes = data.frame(activate(g, nodes))
  assertthat::assert_that(
    "social_strat" %in% colnames(nodes),
    msg = "get_strat_networks: social strategy is missing from node data"
  )
  data.table::setDT(nodes)
  nodes = nodes[, c("id", "social_strat")]

  # link nodes and edges
  edges = data.table::merge.data.table(
    edges, nodes,
    by.x = "from",
    by.y = "id"
  )
  edges = data.table::merge.data.table(
    edges, nodes,
    by.x = "to",
    by.y = "id"
  )
  # get unique strategy pairs
  edges[, c("ss1", "ss2") := list(
    pmin(social_strat.x, social_strat.y),
    pmax(social_strat.x, social_strat.y)
  )]
  # the edge data
  edges = edges[, list(
    mean_weight = mean(weight),
    sum_weight = sum(weight),
    sd_weight = sd(weight)
  ), by = c("ss1", "ss2")]
  # get node data for frequency
  nodes = nodes[,.N, by = "social_strat"]

  tidygraph::tbl_graph(
    nodes = nodes,
    edges = edges,
    directed = FALSE
  )
}