% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fips.R
\name{get_FIPS}
\alias{get_FIPS}
\title{FCC Geocoder}
\usage{
get_FIPS(lat, long, sleep = 0.025)
}
\arguments{
\item{lat}{Latitude}

\item{long}{Longidude}

\item{sleep}{}
}
\value{
15-character string.
}
\description{
Employs the FCC geocoder to turn Longitude and Latitude into a 15-digit FIPS code
}
\examples{
fcc <- get_FIPS(41.063742, -73.517909)

}
