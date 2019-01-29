#' Identify donors who gave last year or some year other than last but are not current donors
#'
#' @description create a column identifying lapsed donors
#'
#' @param x a data set
#' @param last_gift_date a column with the last gift date
#' @param fy_start_month the number of the fiscal start month
#'
#' @return a tibble with a column identifying lapsed donors
#' @export
#'

flag_lapsed <- function(x, last_gift_date, fy_start_month = 7){
  lgd <- rlang::enexpr(last_gift_date)

  x %>%
    dplyr::mutate(
      fiscal_year = fy(date = !!lgd, fy_start_month = fy_start_month),
      current_fy = fy(date = Sys.Date(), fy_start_month = fy_start_month),
      lapsed_attribute = dplyr::case_when(
        is.na(fiscal_year) ~ 'Non-Donor',
        fiscal_year == current_fy ~ 'Current Donor',
        fiscal_year == current_fy-1 ~ 'LYBUNT',
        !is.na(fiscal_year) ~ 'SYBUNT'
      )
    ) %>%
  dplyr::select(-fiscal_year, -current_fy)
}

