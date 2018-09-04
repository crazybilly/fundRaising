#' Cut Giving
#'
#' @description a version of cut designed to cut a vector of gifts (or gift totals) into useful bins
#'
#' @param x a numeric vector of gifts or gift bins
#'
#' @return a factor vector with bins based on the values in x
#'
#' @details `cutgiving()` categorizes x into a series of bins, much like a histogram would, but uses `asinh()` to log transform the data first, working on the assumption that giving will be highly skewed.
#'
#' @export
#'
cutgiving <- function(x) {


  # get some reasonable bins
  #   unfortunately, we have log transform the data to get useful bins
  #   which makes the results of pretty() not so pretty pretty when we transform it back
  rawbins <- pretty(
    range(asinh(x))
    , n = grDevices::nclass.Sturges(asinh(x))
    , min.n = 1, na.rm = T
  ) %>%
  sinh()


  # turn the raw bins into something more human readable and what we expect
  refinedbins  <- dplyr::case_when(
    rawbins   <= 1   ~ signif(rawbins, 1)
    , rawbins <= 10  ~ rawbins - (rawbins %% 5)
    , rawbins <= 100 ~ rawbins - (rawbins %% 25)
    , rawbins <= 1000 ~ rawbins - (rawbins %% 250)
    , rawbins <= 10000 ~ rawbins - (rawbins %% 2500)
    , rawbins <= 100000 ~ rawbins - (rawbins %% 10000)
    , rawbins <  1000000 ~ rawbins - (rawbins %% 100000)
    , rawbins >= 1000000 ~ rawbins - (rawbins %% 1000000)
  ) %>%
  unique()

  # create labels for the bins
  refinedlabels  <- paste0(abbrdollars(refinedbins), " - ", abbrdollars(dplyr::lead(refinedbins, default = Inf)) ) %>%
    stringr::str_replace(" - Inf", "+")

  # actually cut x by the newly created bins
  cut(x, breaks = c(refinedbins,Inf), labels = refinedlabels)



}
