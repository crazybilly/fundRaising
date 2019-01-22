#' Create a lookup table that calculates fiscal months based on the start of the fiscal calendar
#'
#' @description an intermediate function - uses the calendar month that starts the fiscal year to create a table with fiscal months
#'
#' @param fy_start_month an integer between 1 ans 12 indicating the first month of the fiscal year
#'
#' @return a tibble with two columns the calendar month and the fiscal month based on the month that starts the fiscal year
#' @export
#'

fiscal_months <- function(fy_start_month = 7){

  if(!is.numeric(fy_start_month)|fy_start_month>12) {
    stop("The fiscal year start month must be a number between 1 and 12 for example 3 for March")
  }

  cal_month <- seq(fy_start_month,fy_start_month+11,1)
  cal_month <- dplyr::if_else(cal_month > 12, cal_month-12, cal_month)
  fiscal_month <- seq(1,12,1)
  fiscal_months_table <- tibble::tibble(
    cal_month = cal_month,
    fiscal_month = fiscal_month
  )
  return(fiscal_months_table)
}


#' Append a data frame with the gift month, fiscal month and fiscal quarter
#'
#' @description Uses the start month for the fiscal year to calculate the fiscal month and fiscal quarter
#'
#' @param x a data frame
#' @param gift_date_col a column with gift dates
#' @param fy_start_month an integer between 1 ans 12 indicating the first month of the fiscal year
#'
#' @return the data frame provided by the user with three additional columns: gift_month, fiscal_month and fiscal_quarter
#' @export
#'

fy_quarters <- function(x, gift_date_col, fy_start_month = 7){
  gd <- rlang::enexpr(gift_date_col)

  fiscal_months_table <- fiscal_months(fy_start_month)

  x <- x %>%
    dplyr::mutate(gift_month = lubridate::month(!!gd)) %>%
    dplyr::left_join(fiscal_months_table, by = c("gift_month" = "cal_month")) %>%
    dplyr::mutate(fiscal_quarter = dplyr::case_when(
      fiscal_month < 4 ~ 1,
      fiscal_month < 7 & fiscal_month > 3 ~ 2,
      fiscal_month < 10 & fiscal_month > 6 ~ 3,
      fiscal_month < 13 & fiscal_month > 9 ~ 4
    )
    )
  return(x)
}
