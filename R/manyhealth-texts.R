#' texts database documentation
#'
#' @format The texts database is a list that contains the
#' following 1 datasets: AGR_TXT.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{AGR_TXT: }{A dataset with 193 observations and the following
#' 5 variables: Title, Beg, Text_URL, TreatyText, Source.}
#' }

#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(texts, skimr::skim_without_charts)
#' ```
"texts"
