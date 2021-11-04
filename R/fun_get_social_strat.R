#' Assign a social strategy
#'
#' @param df The dataframe with agent id and social weights.
#'
#' @return A dataframe with social strategy assigned.
#' @export
#' @import data.table
#'
get_social_strategy = function(df) {
  assertthat::assert_that(
    all(c("sH", "sN") %in% names(df)),
    msg = "get_social_strat: data does not have social weights"
  )
  df = data.table::setDT(df)
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
#' @import data.table
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


#' Get disease burden per social class.
#'
#' @param df A dataframe with social weights and ecological outcomes.
#'
#' @return A dataframe of disease burden, the sum of the time infected per
#' strategy in each generation.
#' @import data.table
#' @export
#' 
get_disease_burden = function(df) {
  # get social strategy
  df_ = get_social_strategy(df)
  
  # sum time infected per gen and strategy
  df_ = df_[, list(inf_load = sum(t_infec)), by = c("gen", "strat_social")]
  
  df_ = df_[, inf_load_prop := inf_load / sum(inf_load), by = c("gen")]
}

get_tinfec_stats = function(df) {
  # get social strategy
  get_social_strategy(df)
  
  df = df[t_infec > 1, ]
  
  df[, list(
    mean_tinfec = mean(t_infec),
    sd_tinfec = sd(t_infec)
  ), by = c("gen", "strat_social")]
}
