#' organizations database documentation
#'
#' @format The organizations database is a list that contains the
#' following 1 datasets: CHATHAM.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{CHATHAM: }{A dataset with 203 observations and the following
#' 5 variables: Actor, OrganizationID, Beg, CountryID, City.}
#' }

#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(organizations, skimr::skim_without_charts)
#' ```
"organizations"
