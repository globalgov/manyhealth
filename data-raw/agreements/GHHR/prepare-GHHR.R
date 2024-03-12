# GHHR Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the many package.

# Stage one: scraping information from Global Health and Human Rights website
urls <- paste0("https://www.globalhealthrights.org/instruments/instrument-region/page/", 1:16, "/")

# Title variable
extr_title <- purrr::map(
  urls,
  . %>%
    rvest::read_html() %>%
    rvest::html_nodes("#content h2") %>%
    rvest::html_text()
)
Title <- manypkgs::standardise_titles(unlist(extr_title))

# Create dataframe
GHHR <- as.data.frame(Title)

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
legal <- legal[-c(11, 42, 53, 64, 75, 86, 97, 108, 119, 130, 141, 152, 164)]
GHHR$LegalStatus <- legal

# Variable adoption date
extr_date <- purrr::map(
  urls,
  . %>%
    rvest::read_html() %>%
    rvest::html_text()
)

s <- stringr::str_extract_all(extr_date,
                              "Year of adoption\\:\\s[:digit:]{4}|Year of adoption\\:\\sRegion")
date <- unlist(s)
date <- stringr::str_replace_all(date, "Year of adoption\\:\\sRegion", "NA")
date <- stringr::str_remove_all(date, "Year of adoption\\:\\s")

GHHR$Begin <- messydates::as_messydate(date)

GHHR <- as_tibble(GHHR) %>%
  dplyr::select(Title, Begin, Region, LegalStatus)

# Add treatyID
GHHR$treatyID <- manypkgs::code_agreements(GHHR, GHHR$Title, GHHR$Begin)

# Add Lineage
GHHR$Lineage <- manypkgs::code_lineage(GHHR$Title)

# Add manyID
manyID <- manypkgs::condense_agreements(manyhealth::agreements)
GHHR <- dplyr::left_join(GHHR, manyID, by = "treatyID")

# Recode Begin dates that are 'XXXX'
GHHR <- GHHR %>%
  dplyr::mutate(Begin = ifelse(grepl("XXXX", Begin), NA, Begin))

# Add ghhrID
GHHR$ghhrID <- rownames(GHHR)

# Re-order columns
GHHR <- GHHR %>%
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(., "^NA$", NA_character_))) %>%
  dplyr::mutate(Title = manypkgs::standardise_titles(Title),
                Begin = messydates::as_messydate(Begin)) %>%
  dplyr::distinct(.keep_all = TRUE) %>%
  dplyr::select(manyID, treatyID, Title, Begin, Region, LegalStatus, Lineage,
                ghhrID) %>%
  dplyr::arrange(Begin)

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
manypkgs::export_data(GHHR, datacube = "agreements",
                      URL = "https://www.globalhealthrights.org/instruments/instrument-region/")
