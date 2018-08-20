#' Fiscal Year Day Number
#'
#' @param x a date to convert to a numeric day of the fiscal year. Note that x should be of class "Date".
#' @param yet a logical vector. If true only values for dates that are year-to-date will be returned.
#'
#' @return a numeric value describing what day of the fiscal year x is.
#' @export
#'

fydaynum  <- function(x = Sys.Date(), ytd = TRUE){

  x  <- as.Date(x)

  fyx  <- fy(x)

  x_fystart  <- lubridate::ymd(paste0(fyx-1, "-07-01" ))

  x_day <- as.numeric( x - x_fystart) + 1

  if(ytd == TRUE){

    this_fystart <- lubridate::ymd(paste0(fy2()-1, "-07-01" ))

    today_day <- as.numeric( Sys.Date() - this_fystart) + 1

    x_day <- ifelse(x_day <= today_day, x_day, NA)

    x_day
  }

}


