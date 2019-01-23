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

#' Donor Data
#'
#' A dataset containing 3451 constituent rows and 23 features.
#' This dataset is a random 10% slice of the dataset included
#' with the book Data Science for Fundraising and is used with
#' permission in this package. The dataset was sampled to keep
#' the object size under 1MB
#'
#' @format A data frame with 3451 rows and 23 variables:
#' \describe{
#'   \item{ID}{the unique identifier for each constituent}
#'   \item{ZIPCODE}{the ZIP code for the constituent}
#'   \item{AGE}{the age of the constituent}
#'   \item{MARITAL_STATUS}{the marital status of the constituent}
#'   \item{GENDER}{the gender of the constituent}
#'   \item{MEMBERSHIP_IND}{a binary flag indicating if a constituent is a radio member}
#'   \item{ALUMNUS_IND}{a binary flag indicating if a constituent is an alumnus}
#'   \item{PARENT_IND}{a binary flag indicating if a constituent is a parent}
#'   \item{HAS_INVOLVEMENT_IND}{a binary flag indicating if a constituent has an involvement code}
#'   \item{WEALTH_RATING}{a descriptive factor with the results of a wealth screen}
#'   \item{DEGREE_LEVEL}{the degree level of the constituent if they are an alumnus}
#'   \item{PREF_ADDRESS_TYPE}{the preferred address type for the constituent}
#'   \item{EMAIL_PRESENT_IND}{a binary flag indicating if an email address is present}
#'   \item{CON_YEARS}{consecutive giving years}
#'   \item{PrevFYGiving}{the fiscal year giving for the previous fiscal year}
#'   \item{PrevFY1Giving}{the fiscal year giving for the year before the previous fiscal year}
#'   \item{PrevFY2Giving}{the fiscal year giving for two years before the previous fiscal year}
#'   \item{PrevFY3Giving}{the fiscal year giving for three years before the previous fiscal year}
#'   \item{PrevFY4Giving}{the fiscal year giving for four years before the previous fiscal year}
#'   \item{CurrFYGiving}{the fiscal year giving for the current fiscal year}
#'   \item{TotalGiving}{the total giving for the constituent}
#'   \item{DONOR_IND}{a binary flag indicating if a constituent is a donor}
#'   \item{BIRTH_DATE}{the birth date for the constituent}
#' }
#' @source \url{https://www.kaggle.com/michaelpawlus/fundraising-data}
"donor_data"

#' Mapping Data
#'
#' A dataset containing 300 constituent rows and 36 features.
#' This dataset was provided by Michael Lasala as part of his
#' 2018 DAS presentation and is used with permission here
#'
#' @format A data frame with 300 rows and 36 variables:
#' \describe{
#'   \item{ID}{the unique identifier for each constituent}
#'   \item{Name}{the name of the constituent}
#'   \item{AGE}{the age of the constituent}
#'   \item{Age Bin}{the binned age group of the constituent}
#'   \item{Gender}{the gender of the constituent}
#'   \item{Affiliation}{the graduation year and degree for each constituent when applicable}
#'   \item{DonorCode}{descriptive data regarding the connection between the constituent and the organization}
#'   \item{Manager}{the staff member managing the relationship}
#'   \item{Major}{the major studied by an alumnus when applicable}
#'   \item{Address}{the address type indicator}
#'   \item{City}{the address city}
#'   \item{State}{the address state}
#'   \item{Zip Code}{the address ZIP code}
#'   \item{Job Title}{the job title for the constituent}
#'   \item{Emploter}{the employer for the constituent}
#'   \item{Annual Fund Rating}{a rating indicating how much to ask for annually}
#'   \item{Major Gift Capacity}{a rating indicating the size of major gift this constituent is able to make}
#'   \item{LOW_EGC}{a rnumeric value representing the low end of the Major Gift Capacity rating}
#'   \item{HIGH_EGC}{a rnumeric value representing the high end of the Major Gift Capacity rating}
#'   \item{Inclination}{a value indicating the liklihood of making a gift}
#'   \item{Alumni Engagement}{a value indicating the involvement level of an alumnus when applicable}
#'   \item{Stage}{the current stage of the major giving cycle for the constituent}
#'   \item{Last Gift Date}{the date of the most recent gift}
#'   \item{Last Gift Amount}{the amount of the most recent gift}
#'   \item{FY'17 Giving}{the total amount given in fiscal year 2017}
#'   \item{FY'16 Giving}{the total amount given in fiscal year 2016}
#'   \item{FY'15 Giving}{the total amount given in fiscal year 2015}
#'   \item{FY'14 Giving}{the total amount given in fiscal year 2014}
#'   \item{FY'13 Giving}{the total amount given in fiscal year 2013}
#'   \item{Lifetime Giving}{the total amount given by the constituent}
#'   \item{Last Attempt Date}{the date of the last contact attempt}
#'   \item{Last Contact Date}{the date of the last contact}
#'   \item{Last Contact Type}{a value indicating the type of contact made most recently}
#'   \item{Phone Count}{the number of phone calls with the constituent}
#'   \item{FTF Visit Count}{the number of face to face visits with the constituent}
#'   \item{Gift Count}{the number of gifts from the constituent}
#' }
#' @source \url{https://www.kaggle.com/michaelpawlus/fundraising-data}
"mapping_data"
