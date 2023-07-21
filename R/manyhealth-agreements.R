#' agreements datacube documentation
#'
#' @format The agreements datacube is a list that contains the
#' following 3 datasets: WHO, GHHR, HUGGO.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{WHO: }{A dataset with 108 observations and the following
#' 7 variables: manyID, treatyID, Title, Begin, Organisation, Topic, Lineage.}
#' \item{GHHR: }{A dataset with 149 observations and the following
#' 7 variables: manyID, treatyID, Title, Begin, Region, LegalStatus, Lineage.}
#' \item{HUGGO: }{A dataset with 254 observations and the following
#' 18 variables: manyID, treatyID, Title, Begin, Signature, Force, End,
#' Organisation, Topic, Region, LegalStatus, Lineage, Memb.conditions,
#' Memb.procedures, Text, Comments, url, Source.}
#' }
#' @source
#'\itemize{
#' \item{WHO: }{
#' [1] D. Bhugra, S. Pathare, R. Joshi, et al. “A review of mental health policies from Commonwealth countries”. In: _International Journal of Social Psychiatry_ 64.1 (2018), pp. 3-8.}
#' \item{GHHR: }{
#' [1] B. M. Meier, O. A. Cabrera, A. Ayala, et al. “Bridging international law and rights-based litigation: mapping health-related rights through the development of the global health and human rights database”. In: _Health & Hum. Rts._ 14 (2012), p. 20.}
#' \item{HUGGO: }{
#' [1] J. Hollway. Health agreements for manydata. (2022).}
#' }
#' @section URL:
#'\itemize{
#' \item{WHO: }{ \url https://www.mindbank.info/collection/un_who_resolutions/all?page=all}
#' \item{GHHR: }{ \url https://www.globalhealthrights.org/instruments/instrument-region/}
#' \item{HUGGO: }{ \url "Hand-coded by the GGO team")}
#' }
#' @md
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(agreements, messydates::mreport)
#' ```
"agreements"
