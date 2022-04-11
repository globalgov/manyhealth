#' texts database documentation
#'
#' @format The texts database is a list that contains the
#' following 1 datasets: AGR_TXT.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{AGR_TXT: }{A dataset with 184 observations and the following
#' 7 variables: manyID, Title, Beg, Text_URL, TreatyText, Source, treatyID.}
#' }

#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(texts, skimr::skim_without_charts)
#' ```
"texts"
