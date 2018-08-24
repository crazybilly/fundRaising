#' Calculate the longest consecutive giving streak
#'
#' @description calculates the longest consecutive giving streak given giving details for constituents containing a fiscal year field
#'
#' @param data a data frame with donor ids and the fiscal year of gifts
#' @param ids the column name that contains the constituent IDs
#' @param fys the column name that contains the fiscal year for gifts. If not present, run fy() or fy2().
#' @param fy_range the maximum consecutive giving streak to try to find. By default, this uses the maximum range given the fiscal years provided.
#' @param mode options for the output mode. By default, "append" creates a new data frame with all provided columns and the consecutive giving years column. There are two other options. "just_consecutive" will provide a table of IDs and values representing the longest consecutive giving streak. "summary" provides a count of donors for every consecutive giving value.
#'
#' @return a data frame of one out three possible options controlled by the value passed to the mode argument
#' @export
#'

longest_consecutive <- function(data,ids,fys,fy_range = NA, mode = "append") {

  ## data type check(s):
  if(!is.data.frame(data)){
    stop("The first argument must be a data frame")
  }

  # function to see if consecutive numbers of length n exist
  improved.rle <- function(x, n, incr = 1L) {
    result <- rle(diff(as.integer(x)) == incr)
    any(result$lengths >= n-1L  & result$values)
  }

  # enquosurate the column names provided as function arguments
  id_col <- dplyr::enquo(ids)
  fy_col <- dplyr::enquo(fys)

  # use the full possible fiscal year range by default
  if(is.na(fy_range)) {
    recent_year <- max(data[,dplyr::quo_name(fy_col)])
    first_year <- min(data[,dplyr::quo_name(fy_col)])
    fy_range <- (recent_year-first_year)+1
  } else {
    fy_range <- fy_range
  }

  ## get the longest consecutive giving streak
  consecutive_giving <- data %>%
    dplyr::select(!!id_col,!!fy_col) %>%
    dplyr::distinct() %>%
    dplyr::arrange(!!fy_col) %>%
    dplyr::group_by(!!id_col) %>%
    dplyr::summarise(cons_count = sum(purrr::map_lgl(1:fy_range, ~improved.rle(!!fy_col,.)))) %>%
    ungroup()

  if(mode == "just_consecutive"){
    return(consecutive_giving)
  }

  if(mode == "append"){
    # append the data to the data provided
    data <- data %>%
      dplyr::inner_join(consecutive_giving, by = quo_name(id_col))
  }

  if(mode == "summary"){
    # summary table for all consecutive giving values
    consecutive_giving_summary <- consecutive_giving %>%
      dplyr::group_by(cons_count) %>%
      dplyr::summarise(donor_count = dplyr::n_distinct(!!id_col)) %>%
      dplyr::ungroup() %>%
      dplyr::arrange(-cons_count)
    return(consecutive_giving_summary)
  }

  if(!mode %in% c("just_consecutive","append","summary")){
    stop('mode must be one of these three options: "just_consecutive","append","summary"')
  }
}
