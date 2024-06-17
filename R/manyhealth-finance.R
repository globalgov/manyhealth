#' finance datacube documentation
#'
#' @format The finance datacube is a list that contains the
#' following 1 datasets: WHO_GHED.
#' For more information and references to each of the datasets used,
#' please use the `manydata::call_sources()` and `manydata::compare_dimensions()` functions.
#'\describe{
#' \item{WHO_GHED: }{A dataset with 4244 observations and the following
#' 11 variables: stateID, StateName, year, region, che, che_gdp, dom_che,
#' hk_g_gdp, hk_ext_gdp, ext, ext_che.}
#' }
#' @source
#'\itemize{
#' \item{WHO_GHED: }{
#' WHO. _Global Health Expenditure Database_. 2024.
#' }
#' @section URL:
#'\itemize{
#' \item{WHO_GHED: }{
#' \url{https://apps.who.int/nha/database}
#' }
#' }
#' @section Mapping:
#'\itemize{
#' \item{WHO_GHED: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | country | StateName |
#' | code | stateID |
#' }
#' }
#' @md
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(finance, messydates::mreport)
#' ```
"finance"
