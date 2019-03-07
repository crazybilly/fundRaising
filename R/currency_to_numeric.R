#' Currency to Numeric
#'
#' @description coerce dollar amounts to numeric values. Removes "$" and "," and coerces to numeric.
#'
#' @param x a vector of dollar amounts
#'
#' @return a numeric vector
#' @export
#'
currency_to_numeric  <- function(x) {

  stringr::str_remove_all(x, "\\$|,|£|€") %>%
    as.numeric()

}
