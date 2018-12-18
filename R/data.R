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

#' Network Dataset
#'
#' A dataset containing 30 links between entities for exploring network
#' relationships. This dataset is included with the book Data Science
#' for Fundraising and is used with permission in this package.
#'
#' @format A data frame with 30 rows and 2 variables:
#' \describe{
#'   \item{from}{the starting point for the relationship}
#'   \item{to}{the ending point for the relationship}
#' }
#' @source \url{https://www.kaggle.com/michaelpawlus/fundraising-data}
"network_data"

#' Survey Responses
#'
#' A dataset containing 1263 survey responses where the survey responses
#' are expressed as a single numeric value for every respondent. This dataset
#' in included with the book Cool Data: A how-to guide... and is used with
#' permission in this package.
#'
#' @format A data frame with 30 rows and 2 variables:
#' \describe{
#'   \item{ID Number}{the unique identifier for each survey taker}
#'   \item{Survey Response}{a numeric value reflecting a survey response}
#' }
#' @source \url{https://www.kaggle.com/michaelpawlus/fundraising-data}
"survey_data"

#' Donor Data 2
#'
#' A dataset containing 5000 alumni rows with a number of factors
#' for creating a predictive model. This dataset in included with
#' the book Cool Data: A how-to guide... and is used with
#' permission in this package.
#'
#' @format A data frame with 5000 rows and 16 variables:
#' \describe{
#'   \item{ID Number}{the unique identifier for each alumnus}
#'   \item{Lifetime HC}{the lifetime hard credit total for the alumnus}
#'   \item{Email Present}{a binary flag to indicate if an email address is present}
#'   \item{BusPhone Present}{a binary flag to indicate if a business phone is present}
#'   \item{Grad Year}{the graduation year for the alumnus}
#'   \item{Marital Status}{the marital status of th alumnus}
#'   \item{SpouseID Present}{a binary flag to indicate if an ID is connected to this alumnus as a spouse}
#'   \item{JobTitle Present}{a binary flag to indicate if a job title is present}
#'   \item{VarsityAth Present}{a binary flag to indicate if the alumnus participated in varsity athletics}
#'   \item{StudGovt Present}{a binary flag to indicate if the alumnus participated in student government}
#'   \item{OtherStudActs Present}{a binary flag to indicate if the alumnus participated in other student activities}
#'   \item{Greek Present}{a binary flag to indicate if the alumnus has Greek involvement}
#'   \item{Prefix is Mr.}{a binary flag to indicate if the alumnus prefix is Mr}
#'   \item{Prefix is Ms.}{a binary flag to indicate if the alumnus prefix is Ms}
#'   \item{Prefix is Dr.}{a binary flag to indicate if the alumnus prefix is Dr}
#'   \item{Prefix is Mrs.}{a binary flag to indicate if the alumnus prefix is Mrs}
#' }
#' @source \url{https://www.kaggle.com/michaelpawlus/fundraising-data}
"donor_data2"
