

#' Abbreviate Dollars
#'
#' @description format dollars abbreviate
#' @param x a numeric vector of dollar values
#' @param thousandabbr a single character string to be used as the abbreviation for thousands
#' @param millionabbr a single character string to be used as the abbreviation for thousands
#' @param billionabbr a single character string to be used as the abbreviation for thousands
#' @param currency the currency symbol to be used. Prepended to each vaue of x
#'
#' @return a character vector of abbreviated dollar values. Values are rounded to 3 significant digits using `floor()`.
#' @export
#'
abbrdollars  <- function(x,thousandabbr = "K", millionabbr = "M", billionabbr = "B", currency = "$" ) {

  dplyr::case_when(
    is.infinite(x) ~ "Inf"
    , x >=1000000000 ~ paste0(currency, floor(x/1000000000), billionabbr)
    , x >=1000000    ~ paste0(currency, floor(x/1000000)   , millionabbr)
    , x >=1000       ~ paste0(currency, floor(x/1000)      , thousandabbr)
    , T              ~ paste0(currency, as.character(floor(x)))
  )

}
