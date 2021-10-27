#' Assign a social strategy
#'
#' @param df The dataframe with agent id and social weights.
#'
#' @return A dataframe with social strategy assigned.
#' @export
#'
get_social_strategy = function(df) {
  assertthat::assert_that(
    all(c("sH", "sN") %in% names(df)),
    msg = "get_social_strat: data does not have social weights"
  )
  data.table::setDT(df)
  df[, strat_social := data.table::fcase(
    (sH > 0 & sN > 0), "agent tracking",
    (sH > 0 & sN < 0), "handler tracking",
    (sH < 0 & sN > 0), "non-handler tracking",
    (sH < 0 & sN < 0), "agent avoiding"
  )]
}

#' Get ecological outcomes of evolved social strategies.
#'
#' @param df A dataframe with social weights and ecological outcomes.
#'
#' @return A dataframe with outcomes summarised by generation and social
#' strategy.
#' @export
#'
get_social_outcomes = function(df) {
  # get social strategy
  get_social_strategy(df)
  
  # mean and sd of all covariates
  df = df[, !c("sF", "sH", "sN", "id")]
  
  # count strat per gen
  df[, strat_count := .N, by = c("gen", "strat_social")]
  
  # infected or not
  inf_stats = df[, list(
    inf = sum(t_infec > 0)), 
    by = c("gen", "strat_social", "strat_count")
  ]
  inf_stats[, p_inf := inf / strat_count]
  inf_stats[, c("strat_count", "inf") := NULL]
  
  # convert to numeric
  df = df[, !c("t_infec", "strat_count")]
  df = df[, lapply(.SD, as.numeric), by = "strat_social"]
  df = melt(
    df, id.vars = c("gen", "strat_social")
  )
  # get outcomes
  df = df[, list(
    sd = sd(value, na.rm = T),
    mean = mean(value, na.rm = T)
  ), by = c("gen", "strat_social", "variable")
  ]
  # spread?
  df = dcast(df, gen + strat_social ~ variable, value.var = c("mean", "sd"))
  
  # join prop infec stats
  df = merge(df, inf_stats)
  df
}
