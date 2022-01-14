# GHHR Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: creating empty dataset
Title <- 1:151
GHHR <- as.data.frame(Title)


# Stage two: scraping information from Global Health and Human Rights website
urls <- paste0("https://www.globalhealthrights.org/instruments/instrument-region/page/", 1:16, "/")

# Title variable
extr_title <- purrr::map(
  urls,
  . %>%
    rvest::read_html() %>%
    rvest::html_nodes("#content h2") %>%
    rvest::html_text()
)

title <- unlist(extr_title)

GHHR$Title <- title

# Variable region
extr_region <- purrr::map(
  urls,
  . %>%
    rvest::read_html() %>%
    rvest::html_nodes("#content a:nth-child(5)") %>%
    rvest::html_text()
)
region <- unlist(extr_region)
GHHR$Region <- region

# Variable legal_status
extr_legal <- purrr::map(
  urls,
  . %>%
    rvest::read_html() %>%
    rvest::html_nodes("a:nth-child(8)") %>%
    rvest::html_text()
)
legal <- unlist(extr_legal)
# GHHR$LegalStatus <- legal


GHHR <- as_tibble(GHHR)

# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make GHHR available
# within the package.
# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence
# to certain standards.You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows)
# to run these tests locally at any point.
# Any test failures should be pretty self-explanatory and may require
# you to return to stage two and further clean, standardise, or wrangle
# your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please note that the export_data() function requires a .bib file to be
# present in the data_raw folder of the package for citation purposes.
# Therefore, please make sure that you have permission to use the dataset
# that you're including in the package.
# To add a template of .bib file to package,
# run `manypkgs::add_bib(agreements, GHHR)`.
# manypkgs::export_data(GHHR, database = "agreements",
#                      URL = NULL) Didn't run it yet
