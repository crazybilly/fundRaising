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



#' Obtain 5-Year American Community Survey Estimates
#'
#' @description The U.S. Census Bureau has published 5-year esimates of
#'   demographic data since 2009. The data is aggregated at the national, state,
#'   county, census tract, and census block group levels.
#'
#'   This function queries the
#'   \href{https://www.census.gov/data/developers/data-sets/acs-5year.html}{Census
#'    Bureau API} based on FIPS codes for various geographies. Substituting a
#'   wildcard character \code{"*"} instead of a FIPS code returns all values
#'   within the parent geography (i.e. \code{tract = "*"} will return data for
#'   all tracts within a county).
#'
#'
#'   The API limits the number of queries for users who lack an API key. A key
#'   can be obtained \href{https://api.census.gov/data/key_signup.html}{here}.
#'
#'
#' @param var Variables to query from the ACS. For a list of the available
#'   variables and codes (for the 2017 ACS), see the
#'   \href{https://api.census.gov/data/2017/acs/acs5/variables.html}{Official
#'   Documentation}. Defaults to Median Household Income (B19013_00E) and Median
#'   Home Value (Owner-Occupied Units) (B25077_001E). Supports groups.
#' @param year Four-digit year. Defaults to the most recent data, for 2017.
#' @param state Two-digit state FIPS code. Alternatively, \code{"us"} for
#'   national-level statistics. Supports wildcard string (\code{"*"}).
#' @param county Three-digit county FIPS code. Supports wildcard string
#'   (\code{"*"}).
#' @param tract Five-digit census tract FIPS code. Supports wildcard string
#'   (\code{"*"}).
#' @param blkgrp One-digit blog group FIPS code.
#' @param key (optional) Developer key.
#'
#' @return Tibble of data points and FIPS codes, one line per valid input geography.
#' @export
#'
query_acs <- function(var = c("B19013_001E", "B25077_001E"),
                      year = NULL,
                      state,
                      county = NULL,
                      tract = NULL,
                      blkgrp = NULL,
                      key = NULL) {

  # Validate the Year, defaulting to 2017.
  year <- match.arg(year, c(2017:2009))

  # Format the Variables
  names <- paste("NAME", paste(var, collapse = ","), sep = ",")


  base_url <- glue::glue("https://api.census.gov/data/{year}/acs/acs5?get={names}&for=")


  if (!is.null(blkgrp)) {

    url <- glue::glue("{base_url}block%20group:{blkgrp}&in=state:{state}%20county:{county}%20tract:{tract}")

  } else if (!is.null(tract)) {

    url <- glue::glue("{base_url}tract:{tract}&in=state:{state}%20county:{county}")

  } else if (!is.null(county)) {

    url <- glue::glue("{base_url}county:{county}&in=state:{state}")

  } else if (state == "us") {

    url <- glue::glue("{base_url}us")

  } else {
    url <- glue::glue("{base_url}state:{state}")
  }


  # Include API key, if provided.
  if (!is.null(key)) {
    link <- paste0(url, "&key=", key)
  } else {
    link <- url
  }

  # Fetch Results
  results <- jsonlite::fromJSON(link)

  # The first row of results contains the headers. Set the names and remove this row.
  colnames(results) <- results[1, ]

  results <- dplyr::as_tibble(results[-1, ])

  return(results)
}
