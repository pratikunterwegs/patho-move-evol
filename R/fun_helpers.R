
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