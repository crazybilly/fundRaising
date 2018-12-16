#' Sample Contact Reports
#'
#' A dataset containing 196 contact reports. This dataset is
#' included with the book Data Science for Fundraising and
#' is used with permission in this package
#'
#' @format A data frame with 196 rows and 7 variables:
#' \describe{
#'   \item{Staff Name}{the name of the development officer}
#'   \item{Method}{the contact method: Email, Letter, Phone}
#'   \item{Date}{the date of the contact}
#'   \item{Summary}{descripitive text from the contact}
#'   \item{Substantive}{flag to indicate if contact was substantive}
#'   \item{Donor}{the name of the donor or prospect}
#'   \item{Outcome}{flag to indicate the outcome of the contact}
#' }
#' @source \url{https://www.kaggle.com/michaelpawlus/fundraising-data}
"contact_data"

#' Small Alumni Dataset
#'
#' A dataset containing 2878 anonymized alumni records
#' along with graduate year, degree, major, giving total
#' and an affinity score. This dataset was created by
#' Michael Pawlus.
#'
#' @format A data frame with 2878 rows and 8 variables:
#' \describe{
#'   \item{coreid}{a unique id for an alumni record}
#'   \item{aff_total}{a calculated affinity score - mark of how connected an alum is to the university}
#'   \item{coresex}{the gender of the alumnus}
#'   \item{coreprefyr}{the preferred graduation year for the alumnus}
#'   \item{Degree}{the degree earned by the alumnus}
#'   \item{Major}{the major for the alumnus}
#'   \item{fy14}{the total giving for the alumnus during fiscal year 2014}
#'   \item{donor}{a binary flag of 1 or 0 to indicate if the alumnus is a donor}
#' }
#' @source \url{https://www.kaggle.com/michaelpawlus/fundraising-data}
"small_data"
