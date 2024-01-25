#' references datacube documentation
#'
#' @format The references datacube is a list that contains the
#' following 2 datasets: GHHR_REF, WHO_REF.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{GHHR_REF: }{A dataset with 224 observations and the following
#' 3 variables: Treaty1, Treaty2, RefType.}
#' \item{WHO_REF: }{A dataset with 65 observations and the following
#' 3 variables: Treaty1, Treaty2, RefType.}
#' }
#' @source
#' \itemize{
#' \item{GHHR_REF: }{
#' B. M. Meier, O. A. Cabrera, A. Ayala, et al.
#' “Bridging international law and rights-basedlitigation: mapping health-related rights through the development of the global health and human rightsdatabase”.
#' In: _Health & Human Rights._ 14 (2012), p. 20.}
#' \item{WHO_REF: }{
#' Bhugra D, Pathare S, Joshi R, Kalra G, Torales J, Ventriglio A.
#' “A review of mental healthpolicies from Commonwealth countries.”
#' In: _International Journal of Social Psychiatry_, *64*(1) (2018), 3-8.}
#' }
#' @section URL:
#' \itemize{
#' \item{GHHR_REF: }{
#' \url{https://www.globalhealthrights.org/instruments/instrument-region/}
#' }
#' \item{WHO_REF: }{
#' \url{https://www.mindbank.info/collection/un_who_resolutions/all?page=all}
#' }
#' }
#' @md
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(references, messydates::mreport)
#' ```
"references"
