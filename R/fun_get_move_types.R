
#' Get functional variation in movement weights.
#'
#' @param df A dataframe with generation, id, and movement weights.
#'
#' @return A dataframe with scaled weights.
#' @export
get_functional_variation = function(df) {
  data.table::setDT(df)
  
  assertthat::assert_that(
    all(
      c("sF", "sH", "sN", "gen", "id") %in% colnames(df)
    )
  )
  
  df = df[, c("sF", "sH", "sN", "gen", "id")]
  df = melt(df, id.vars = c("gen", "id"))
  df[, scaled_value := value / sum(abs(value)), 
    by = c("gen", "id")]
  df = dcast(
    df[, !("value")],
    gen + id ~ variable,
    value.var = "scaled_value"
  )
  df
}

#' Assign movement types.
#'
#' @param df A dataframe with generation, id, and movement weights.
#'
#' @return A dataframe with assigned movement strategies.
#' @export
assign_movement_types = function(df) {
  data.table::setDT(df)
  
  df = get_functional_variation(df)
  
  # assign strategy
  df[, move_strat := dplyr::case_when(
    sF > 0.6 ~ "prey tracking",
    ((sF > 0) & (sH > 0) & (abs(sF - sH) < 0.1)) ~ "prey and handler tracking",
    sH > 0.5 ~ "handler tracking",
    sH < -0.5 ~ "handler avoiding",
    sN > 0.5 ~ "non-handler tracking",
    sN < -0.5 ~ "non-handler avoiding",
    T ~ "other"
  )]
  
  df
}