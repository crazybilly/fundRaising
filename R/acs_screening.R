#' Create a full name column using the first and last names
#'
#' @description creates a full name column - a convenience helper function for acs screening
#'
#' @param x a data frame
#' @param first_name_col a column from the data frame containing the first name
#' @param last_name_col a column from the data frame containing the last name
#'
#' @return a given data frame with an appended column containthing the full name - in this case: first name, space, last name
#' @export
#'

make_full_name <- function(x, first_name_col, last_name_col){
  fn <- rlang::enexpr(first_name_col)
  ln <- rlang::enexpr(last_name_col)
  x <- x %>% mutate(full_name = paste(!!fn, !!ln))
  return(x)
}

#' Create a concatenated address column to be used for gathering latitude and longitude values
#'
#' @description creates a concatenatd address column - a convenience helper function for acs screening
#'
#' @param x a data frame
#' @param addr_line_col a column from the data frame containing the address line
#' @param addr_city_col a column from the data frame containing the address city
#' @param addr_postal_col a column from the data frame containing the address postal code
#'
#' @return a given data frame with an appended column containthing a concatenated address - in this case: address line, comma, city, comma, postal code
#' @export
#'

make_concat_address <- function(x, addr_line_col, addr_city_col, addr_postal_col){
  data("zipcode")
  adln <- rlang::enexpr(addr_line_col)
  adct <- rlang::enexpr(addr_city_col)
  adpc <- rlang::enexpr(addr_postal_col)
  x <- x %>%
    dplyr::mutate(short_zip = stringr::str_sub(!!adpc,1,5)) %>% ## convert any plus-4s to 5 digit ZIPs
    dplyr::left_join(zipcode, by = c("short_zip" = "zip")) %>% # join zipcodes to get the state abbr
    dplyr::mutate(concat_add = stringr::str_c(!!adln, !!adct, state, sep=",")) # create a concat addr, city, state
  return(x)
}

#' Get the latitide and longitude values based on address data
#'
#' @description creates a data frame with latitude and longitude values based on address data
#'
#' @param x a data frame
#' @param address a column from the data frame containing a concatenated address line
#' @param name a column from the data frame containing a name field with a full name
#'
#' @return a data frame with latitide and longitude data for every address
#' @export
#'

get_lat_lon <- function(x, address, name) {
  addr <- rlang::enexpr(address)
  nm <- rlang::enexpr(name)
  addr_vec <- x %>% dplyr::select(!!addr) %>% unname() %>% purrr::as_vector()
  nm_vec <- x %>% dplyr::select(!!nm) %>% unname() %>% purrr::as_vector()
  result <- ggmap::geocode(addr_vec, output = "latlona", source = "dsk")

  result <- result %>%
    dplyr::mutate_at(1:2, ~as.numeric(.)) %>%
    dplyr::mutate(geo_add = as.character(address))

  latlons <- tibble(
    name = nm_vec,
    lon = result$lon,
    lat = result$lat,
    geo_add = result$geo_add
  )

  return(latlons)
}
