#' Geocode an address
#'
#' @description calculates the lat and lon pair for an address and returns the address along with the coordinates. This function is primarily for reference as we work on a better one.
#'
#' @param addr the address to be geocoded
#'
#' @return a vector with addr, long, and lat
#' @export
#'

geo.dsk <- function(addr){
  require(httr)
  require(rjson)
  
  out <- tryCatch({
    url <- "http://www.datasciencetoolkit.org/maps/api/geocode/json"
    response <- GET(url,query=list(sensor="FALSE",address=addr))
    json <- fromJSON(content(response,type="text"))
    loc <- json['results'][[1]][[1]]$geometry$location
    return(c(address=addr,long=loc$lng, lat= loc$lat))
  },
  
  error = function(cond) {
    message(paste("Address not geocoded:", addr))
    message("Here's the original error message:")
    message(cond)
    # Choose a return value in case of error
    return(NA)
  },
  
  warning = function(cond) {
    message(paste("Address caused a warning:", addr))
    message("Here's the original warning message:")
    message(cond)
    # Choose a return value in case of warning
    return(NULL)
  },
  
  finally = {
    message(paste("Processed Address:", addr))
    message("One down...")
  }
  
)
  return(out)
}
