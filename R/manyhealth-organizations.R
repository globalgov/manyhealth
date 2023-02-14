#' organizations database documentation
#'
#' @format The organizations database is a list that contains the
#' following 3 datasets: CHATHAM, IHEID, GHS.
#' If using the data in combination with state data,
#' please note that there may be overlaps in three-letter organizationID and
#' three-letter stateID.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{CHATHAM: }{A dataset with 203 observations and the following
#' 7 variables: organizationID, Organization, Beg, City, State, Type,
#' Health_as_primary_intent.}
#' \item{IHEID: }{A dataset with 124 observations and the following
#' 5 variables: organizationID, Organization, Beg, Areas, City.}
#' \item{GHS: }{A dataset with 203 observations and the following
#' 8 variables: organizationID, Organization, Beg, City, State, URL, Type,
#' Health as primary intent?.}
#' }
#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(organizations, messydates::mreport)
#' ```
"organizations"
