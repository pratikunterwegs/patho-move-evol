
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

#' Lower 95% CI
#'
#' @param x A numeric vector.
#'
#' @return The lower 95% CI value, bounded at 0.
#' @export
ci_lower = function(x) {
  a = mean(x) - qnorm(0.975) * sd(x) / sqrt(length(x))
  a
}

#' Upper 95% CI
#'
#' @param x A numeric vector.
#'
#' @return The upper 95% CI value, bounded at +1.
#' @export
ci_upper = function(x) {
  a = mean(x) + qnorm(0.975) * sd(x) / sqrt(length(x))
  a
}