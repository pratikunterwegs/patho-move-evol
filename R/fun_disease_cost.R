
#' Get disease cost from time infected.
#'
#' @param df A dataframe with time infected.
#' @param cost Disease cost per timestep.
#'
#' @return Assign total disease cost per individual.
#' @export
get_total_disease_cost = function(df, cost) {
  assertthat::assert_that(
    "t_infec" %in% colnames(df)
  )
  data.table::setDT(df)
  df[, cost_disease := t_infec * cost]
}