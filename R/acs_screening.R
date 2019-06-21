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
  x <- x %>% dplyr::mutate(full_name = paste(!!fn, !!ln))
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
  ##load("data/zipcode.rda")
  ## think of a way to remove the zipcode object and not return to users
  data("zipcode")
  adln <- rlang::enexpr(addr_line_col)
  adct <- rlang::enexpr(addr_city_col)
  adpc <- rlang::enexpr(addr_postal_col)
  x <- x %>%
    ## remove columns that are made if they exist?
    dplyr::mutate(short_zip = stringr::str_sub(!!adpc,1,5)) %>% ## convert any plus-4s to 5 digit ZIPs
    dplyr::left_join(zipcode, by = c("short_zip" = "zip")) %>% # join zipcodes to get the state abbr
    dplyr::mutate(concat_add = stringr::str_c(!!adln, !!adct, state, sep=",")) # create a concat addr, city, state
  return(x)
}

#' Get the latitide and longitude values based on address data
#'
#' @description creates a data frame with latitude and longitude values based on address data
#'
#' @param address a vector containing the concatenated address as a string most likely in the form of data dollar sign column
#' @param name a vector containing the full name for the record as a string most likely in the form of data dollar sign column
#'
#' @return a data frame with latitide and longitude data for every address
#' @export
#'

get_lat_lon <- function(name,address) {

  gc <- reticulate::import("geocoder")  # this can't be where this goes but where ..... \_(~)_/

  addrs <- vector()
  lats <- vector()
  lngs <- vector()

  names <- name

  for(i in 1:length(address)) {
    res <- gc$arcgis(address[i])$json
    addr <- res$address
    addrs <- c(addrs,addr)
    lat <- res$lat
    lats <- c(lats,lat)
    lng <- res$lng
    lngs <- c(lngs,lng)
  }

  ll_tbl <- tibble(
    ll_names = names,
    ll_address = addrs,
    ll_lat = lats,
    ll_lng = lngs
  )

  return(ll_tbl)
}

#' Get a block id for every longitude and latitude value - a helper function that is iterated through to make a table
#'
#' @description pulls a block id values for a given set of coordinates
#'
#' @param lat a value for latitude
#' @param lon a value for longitude
#'
#' @return block id value or values
#' @export
#'


get_block_ids <- function(lat, lon) {
  fcc <- "https://geo.fcc.gov/api/census/area?lat=%f&lon=%f&format=json"
  fcc <- sprintf(fcc, lat, lon)
  json <- xml2::read_html(fcc)
  json <- jsonlite::fromJSON(fcc)

  dplyr::tibble (
    block_id = json$results$block_fips,
    fcc_lat = json$input$lat,
    fcc_lon = json$input$lon
  )

}


#' Iterate through get_block_ids to create a table of block ids - a list for now but a table soon
#'
#' @description creates a data frame with block ids generated from longitude and latitude values
#'
#' @param result a data frane output as a result of the get_lat_lon function containing a value for longitude and latitude labelled lon and lat respectively
#'
#' @return a data frame with block ids
#' @export
#'


get_block_id_table <- function(result){

  blocks <- purrr::map2(result$lat,result$lon,get_block_ids)
  return(blocks)

}
