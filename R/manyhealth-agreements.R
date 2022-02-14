#' agreements database documentation
#'
#' @format The agreements database is a list that contains the
#' following 2 datasets: WHO, GHHR.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{WHO: }{A dataset with 109 observations and the following
#' 7 variables: manyID, Title, Beg, Organisation, Topic, Lineage, treatyID.}
#' \item{GHHR: }{A dataset with 151 observations and the following
#' 7 variables: manyID, Title, Beg, Region, LegalStatus, Lineage, treatyID.}
#' }

#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(agreements, skimr::skim_without_charts)
#' ```
"agreements"
