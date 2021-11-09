
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