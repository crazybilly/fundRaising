#' Calculate the consistency rate for constituents (the percentage of time they have given during a defined range of time)
#'
#' @description calculates consistency a rate of how often gifts have been made during a defined time period
#'
#' @param data a data frame
#' @param id_col a column from the data frame containing constituent IDs - column name should be unquoted
#' @param fy_col a column from the data frame containing fiscal years for gifts - column name should be unquoted (use the fy() function if fiscal years are not already in the data)
#' @param threshold a numeric value for the minimum active years to consider - for example, if someone is a first time donor they will have 100% consistency to only include those that could have given at least 3 fiscal years, change threshold to 3
#' @param alt_year a numeric value or a quoted column name from the data frame containing which fiscal years should be used for the lower bound of the active years range. By default, the minimum fiscal year for gifts will be used however graduation year could also be used or just any given fiscal year
#' @param max_year a numeric value for the upper bound of the active years. By default, the maximum fiscal year for gifts will be used however any fiscal year can be used to override this such as the current fiscal year
#'
#' @return a summary data frame with the unique ID, first and last year of the active range, the defined active giving years, the number of fiscal years during the active giving years when a gift was a received, the consistency rate of fiscal years with a gift over active giving range
#' @export
#'

consistency <- function(data,id_col,fy_col,threshold = 1, alt_year = NA, max_year = 0){

  id_string <- rlang::as_string(ensym(id_col))
  id_col <- enquo(id_col)
  fy_col <- enquo(fy_col)
  if(!is.na(alt_year) & is.character(alt_year)){
    alt_year <- rlang::sym(alt_year)
  } else if (!is.na(alt_year) & is.numeric(alt_year)){
    alt_year <- alt_year
  } else {
    alt_year <- NA
  }

  d2 <- data %>%
    group_by(!!id_col) %>%
    summarise(
      first_year = if (class(alt_year) == "numeric") {
        alt_year
      } else if (class(alt_year) == "symbol") {
        min(!!alt_year)
      } else {
        min(!!fy_col)
      }
    ) %>%
    ungroup()

  data %>%
    inner_join(d2, by=id_string) %>%
    mutate(filter_col = FISCAL_YEAR - first_year) %>%
    filter(filter_col > -1) %>%
    group_by(!!id_col) %>%
    summarise(
      first_year = max(first_year),
      last_year = if_else(max_year==0,max(!!fy_col),max_year),
      active_years = (last_year - first_year) + 1,
      fys_giving = n_distinct(as.character(!!fy_col)),
      consistency = if_else(fys_giving > active_years, 0, fys_giving / active_years)
    ) %>%
    ungroup() %>%
    arrange(-consistency) %>%
    filter(active_years > threshold-1)
}
