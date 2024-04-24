#' memberships datacube documentation
#'
#' @format The memberships datacube is a list that contains the
#' following 1 datasets: HUGGO_MEM.
#' For more information and references to each of the datasets used,
#' please use the `manydata::call_sources()` and `manydata::compare_dimensions()` functions.
#'\describe{
#' \item{HUGGO_MEM: }{A dataset with 39000 observations and the following
#' 16 variables: manyID, Title, Begin, stateID, StateName, StateSignature,
#' StateRatification, StateForce, StateEnd, Rat=Notif, Accession, Succession,
#' treatyID, Signature, Force, End, Coder.}
#' }
#' @source
#' \itemize{
#' \item{HUGGO_MEM: }{
#' J. Hollway. Health agreements for manydata. 2021.}
#' }
#' @section URL:
#' \itemize{
#' \item{HUGGO_MEM: }{Hand-coded data by the GGO team}
#' }
#' @section Mapping:
#' \itemize{
#' \item{HUGGO_MEM: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | NA | NA |
#'
#' }
#' }
#' @md
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(memberships, messydates::mreport)
#' ```
"memberships"
