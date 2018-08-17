#' Fiscal Year Day Number
#'
#' @param x a date to convert to a numeric day of the fiscal year. Note that x should be of class "Date".
#'
#' @return a numeric value describing what day of the fiscal year x is.
#' @export
#'
fydaynum  <- function(x) {

    x  <- as.Date(x)

    fyx  <- fy(x)

    thisfystart  <- lubridate::ymd(paste0(fyx-1, "-07-01" ))

    as.numeric( x - thisfystart) + 1

}
