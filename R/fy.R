#' Calculate the MU fiscal year
#'
#' @description calculates the fiscal year based on an existing date
#'
#' @param x a date-time object
#'
#' @return a numeric value of fiscal years
#' @export
#'
fy  <- function(x) {

  ifelse(lubridate::month(x) >= 7, year(x) +1, year(x) )

}
