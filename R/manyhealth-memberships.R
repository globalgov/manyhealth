#' memberships database documentation
#'
#' @format The memberships database is a list that contains the
#' following 1 datasets: HUGGO_MEM.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{HUGGO_MEM: }{A dataset with 39989 observations and the following
#' 13 variables: manyID, stateID, Title, Begin, Signature, Force, End,
#' stateSignature, stateRat, stateForce, stateEnd, treatyID, StateName.}
#' }
#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(memberships, messydates::mreport)
#' ```
"memberships"
