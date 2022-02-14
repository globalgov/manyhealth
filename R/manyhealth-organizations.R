#' organizations database documentation
#'
#' @format The organizations database is a list that contains the
#' following 2 datasets: CHATHAM, IHEID.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{CHATHAM: }{A dataset with 203 observations and the following
#' 5 variables: Actor, OrganizationID, Beg, CountryID, City.}
#' \item{IHEID: }{A dataset with 124 observations and the following
#' 5 variables: Abbreviation, Areas, organizationID, Beg, Place.}
#' }

#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(organizations, skimr::skim_without_charts)
#' ```
"organizations"
