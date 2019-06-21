#' FCC Geocoder
#'
#' Employs the FCC geocoder to turn Longitude and Latitude into a 15-digit FIPS code
#'
#' @param lat Latitude
#' @param long Longidude
#' @param sleep
#'
#' @return 15-character string.
#' @export
#'
#' @examples
#' fcc <- get_FIPS(41.063742, -73.517909)
#'
get_FIPS <- function(lat, long,sleep = 0.025){
  if(!is.numeric(lat)|!is.numeric(long)){
    stop("Non-numeric Latitude and/or Longitude supplied.")
  }

  # Delay request by sleep time
  Sys.sleep(sleep)
  # Create the URL from the inputs. Forces XML response
  url <- sprintf("https://geo.fcc.gov/api/census/block/find?latitude=%f&longitude=%f&format=xml",lat,long)

  # Read the response as XML
  response <- xml2::read_xml(url)
  # Find the "Block" node
  data <- xml2::xml_find_first(response,"Block")
  # Extract and return the FIPS code
  fips <- xml2::xml_attr(data,"FIPS")

  # For Failed Geocoding:
  if(fips == "null"){
    fips <- NA
    message(sprintf("Geocoding Failed for (%f,%f)",lat,long))}

  return(fips)
}


#' Parsing FIPS codes
#'
#' A single FIPS code concatenates multiple points of information into a single
#' string. This function parses the 2-digit state, 3-digit county, 5-digit
#' tract, block group, and 4-digit block codes (if present) from a 5-15 character long string.
#'
#' @param fips FIPS code, as a 5 to 15 character string, containing only numeric characters
#'
#' @return
#' @export
#'
#' @examples
#' parse_fips("090010218022000")
#'
parse_fips <- function(fips){
  # Error Handling
  if(!is.character(fips)|grepl("[^0-9]", fips)){
    stop("The FIPS Code must be string of numbers.")
  }

  state <- substr(fips, 0,2)
  county <- substr(fips,3,5)
  tract <- substr(fips, 6,11)
  blkgrp <- substr(fips, 12,12)
  block <- substr(fips, 12, 15)

  out <- list(
    state = state,
    county = county,
    tract = tract,
    blkgrp = blkgrp,
    block = block
  )

  # Replace empty strings with NA
  out[out == ""] <- NA

  return(out)
}

