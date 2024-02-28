#' agreements datacube documentation
#'
#' @format The agreements datacube is a list that contains the
#' following 3 datasets: WHO, GHHR, HUGGO.
#' For more information and references to each of the datasets used,
#' please use the `manydata::call_sources()` and `manydata::compare_dimensions()` functions.
#'\describe{
#' \item{WHO: }{A dataset with 108 observations and the following
#' 8 variables: manyID, treatyID, Title, Begin, Organisation, Topic, Lineage,
#' whoID.}
#' \item{GHHR: }{A dataset with 149 observations and the following
#' 8 variables: manyID, treatyID, Title, Begin, Region, LegalStatus, Lineage,
#' ghhrID.}
#' \item{HUGGO: }{A dataset with 254 observations and the following
#' 20 variables: manyID, treatyID, Title, Begin, Signature, Force, End,
#' Organisation, Topic, Region, LegalStatus, Formal, Lineage, whoID, ghhrID,
#' TreatyText, url, Source, Comments, Topic2.}
#' }
#' @source
#' \itemize{
#' \item{WHO: }{
#' D. Bhugra, S. Pathare, R. Joshi, et al.
#' “A review of mental health policies from Commonwealthcountries”.
#' In: _International Journal of Social Psychiatry_ 64.1 (2018), pp. 3-8.}
#' \item{GHHR: }{
#' B. M. Meier, O. A. Cabrera, A. Ayala, et al.
#' “Bridging international law and rights-based litigation:mapping health-related rights through the development of the global health and human rights database”.
#' In: _Health & Human Rights._ 14 (2012), p. 20.}
#' \item{HUGGO: }{
#' J. Hollway. Health agreements for manydata. 2021.}
#' }
#' @section URL:
#' \itemize{
#' \item{WHO: }{
#' \url{https://www.mindbank.info/collection/un_who_resolutions/all?page=all}
#' }
#' \item{GHHR: }{
#' \url{https://www.globalhealthrights.org/instruments/instrument-region/}
#' }
#' \item{HUGGO: }{Hand-coded data by the GGO team}
#' }
#' @section Mapping:
#' \itemize{
#' \item{WHO: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | NA | NA |
#'
#' }
#' \item{GHHR: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | Year of adoption | Begin |
#'
#' }
#' }
#' @md
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(agreements, messydates::mreport)
#' ```
"agreements"
