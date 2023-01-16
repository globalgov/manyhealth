#' organizations database documentation
#'
#' @format The organizations database is a list that contains the
#' following 3 datasets: CHATHAM, IHEID, GHS.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#' @imports manydata
#'\describe{
#' \item{CHATHAM: }{A dataset with 203 observations and the following
#' 5 variables: Actor, OrganizationID, Beg, CountryID, City.}
#' \item{IHEID: }{A dataset with 124 observations and the following
#' 5 variables: Abbreviation, Areas, organizationID, Beg, Place.}
#' \item{GHS: }{A dataset with 203 observations and the following
#' 8 variables: Abbreviation, organizationID, Beg, Place, State, URL, Type,
#' Health as primary intent?.}
#' }
#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(organizations, messydates::mreport)
#' ```
"organizations"
