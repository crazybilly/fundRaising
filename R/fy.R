#' Calculate the fiscal year based on any starting month
#'
#' @description calculates the fiscal year based on an existing date
#'
#' @param date a vector of date or date-times
#' @param fy_start_month a number representing the starting month for the fiscal year (defaults to 7, ie. July)
#'
#' @return a numeric vector of fiscal years with the length of the date argument
#' @export
#'
fy  <- function(date = Sys.Date(), fy_start_month = 7 ) {

  if(!is.character(date)&!lubridate::is.Date(date)&!lubridate::is.POSIXct(date)&!lubridate::is.POSIXlt(date)) {
    stop("Please use values formatted as dates or character strings with only numbers convertible to dates like '2017-07-01'")
  }

  ## there is probably a nicer way to do this but need a way to deal with missing values
  if(any(as.logical(stringr::str_replace_na(stringr::str_detect(date,"[:alpha:]"),replacement = FALSE)))) {
    stop("Please use values formatted as dates or character strings with only numbers convertible to dates like '2017-07-01'")
  }

  if(!is.numeric(fy_start_month)|fy_start_month>12) {
    stop("The fiscal year start month must be a number between 1 and 12 for example 3 for March")
  }

  ifelse(lubridate::month(date) >= fy_start_month, lubridate::year(date) +1, lubridate::year(date) )

}
