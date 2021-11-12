
#' Get disease cost from time infected.
#'
#' @param df A dataframe with time infected.
#' @param cost Disease cost per timestep.
#'
#' @return Assign total disease cost per individual.
#' @export
get_total_disease_cost = function(df, cost = 0.25) {
  assertthat::assert_that(
    "t_infec" %in% colnames(df)
  )
  data.table::setDT(df)
  df[, cost_disease := t_infec * cost]
}

#' Get agent energy.
#'
#' @param df A dataframe with agent intake and time infected.
#' @param cost_disease The cost of the disease.
#'
#' @return
#' @export
#'
#' @examples
get_total_energy = function(df, cost_disease = 0.25) {
  data.table::setDT(df)
  # add disease cost
  get_total_disease_cost(df, cost = cost_disease)
  # calculate energy
  df[, energy := intake - cost_disease]
}