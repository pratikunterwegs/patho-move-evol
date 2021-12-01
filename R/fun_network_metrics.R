
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
#' @return A numeric global efficiency value.
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