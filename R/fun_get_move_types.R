
#' Get functional variation in movement weights.
#'
#' @param df A dataframe with generation, id, and movement weights.
#'
#' @return Nothing. Transforms weights by reference. See data.table.
#' @export
get_functional_variation = function(df) {
  data.table::setDT(df)
  
  assertthat::assert_that(
    all(
      c("sF", "sH", "sN", "gen", "id") %in% colnames(df)
    )
  )
  
  # transform weights
  df[, c("sF", "sH", "sN") := lapply(.SD, function(x) {
    x / (abs(sF) + abs(sH) + abs(sN))
  }), 
  .SDcols = c("sF", "sH", "sN")]
}

#' Assign movement types.
#'
#' @param df A dataframe with generation, id, and movement weights.
#'
#' @return Nothing. Assigns strategy by reference. See data.table.
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
}