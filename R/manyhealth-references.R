#' references database documentation
#'
#' @format The references database is a list that contains the
#' following 2 datasets: GHHR_REF, WHO_REF.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{GHHR_REF: }{A dataset with 224 observations and the following
#' 3 variables: Treaty1, Treaty2, RefType.}
#' \item{WHO_REF: }{A dataset with 65 observations and the following
#' 3 variables: Treaty1, Treaty2, RefType.}
#' }

#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(references, skimr::skim_without_charts)
#' ```
"references"
