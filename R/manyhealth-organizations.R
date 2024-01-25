#' organizations datacube documentation
#'
#' @format The organizations datacube is a list that contains the
#' following 3 datasets: CHATHAM, IHEID, GHS.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{CHATHAM: }{A dataset with 203 observations and the following
#' 7 variables: organizationID, Organization, Begin, City, State, Type,
#' Health_as_primary_intent.}
#' \item{IHEID: }{A dataset with 124 observations and the following
#' 5 variables: organizationID, Organization, Begin, Areas, City.}
#' \item{GHS: }{A dataset with 203 observations and the following
#' 8 variables: organizationID, Organization, Begin, City, State, URL, Type,
#' Health as primary intent?.}
#' }
#' @source
#' \itemize{
#' \item{CHATHAM: }{
#' S. J. Hoffman, C. B. Cole, and M. Pearcey.
#' In: _Mapping global health architecture to inform thefuture_.
#' Chatham House London, 2015.}
#' \item{IHEID: }{
#' In: _Directory of Global Health Actors_. 2021.}
#' \item{GHS: }{
#' S. J. Hoffman and C. B. Cole.
#' “Defining the global health system and systematically mapping itsnetwork of actors”.
#' In: _Global Health_ 14.38 (2018).}
#' }
#' @section URL:
#' \itemize{
#' \item{CHATHAM: }{
#' \url{https://www.chathamhouse.org/sites/default/files/field/field_document/20150120GlobalHealthArchitectureHoffmanColePearcey.pdf}
#' }
#' \item{IHEID: }{
#' \url{https://www.graduateinstitute.ch/GHC-directories}
#' }
#' \item{GHS: }{
#' \url{https://doi.org/10.1186/s12992-018-0340-2}
#' }
#' }
#' @section Mapping:
#' \itemize{
#' \item{CHATHAM: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | Code | organizationID |
#' | Actors | Organization |
#' | HQ_states | State |
#' | HQ_city | City |
#' | Year_inception | Begin |
#'
#' }
#' \item{IHEID: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | Abbreviation | organizationID |
#' | Name | Organization |
#' | Start | Begin |
#' | 'HQ/Offices' | City |
#'
#' }
#' \item{GHS: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | Code | organizationID |
#' | Actor | Organization |
#' | 'Year of Inception' | Begin |
#' | 'Headquarters Location' | City |
#'
#' }
#' }
#' @md
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(organizations, messydates::mreport)
#' ```
"organizations"
