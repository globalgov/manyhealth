# TEXT Preparation Script

# Create a combined databaset from agreements datasets

GHHR <- manyhealth::agreements$GHHR %>%
  dplyr::select(Title, Beg)


WHO <- manyhealth::agreements$WHO %>%
  dplyr::select(Title, Beg)

# TEXT <- rbind(GHHR, WHO)

# Web scraping instruments texts from the GHHR webpage
urls <- paste0("https://www.globalhealthrights.org/instruments/instrument-region/page/", 1:16, "/")

# Extract url that contains link to treaty text
extr_text <- purrr::map(
  urls,
  . %>%
    rvest::read_html() %>%
    rvest::html_nodes("#content h2 a") %>%
    rvest::html_attr("href")
)

extr_text <- unlist(extr_text)

GHHR$Treaty_URL <- extr_text

# Extract the URL of the text itself
GHHR$Text_URL <- lapply(GHHR$Treaty_URL, function(s) purrr::map(s,
                                                                . %>%
                                                                  rvest::read_html() %>%
                                                                  rvest::html_nodes(".downloaddecision a") %>%
                                                                  rvest::html_attr("href")))

GHHR$Text_URL[GHHR$Text_URL=="list(character(0))"] <- "NA"
GHHR$Text_URL <- stringr::str_remove_all(GHHR$Text_URL, "list")
GHHR$Text_URL <- stringr::str_remove_all(GHHR$Text_URL, "\\(")
GHHR$Text_URL <- stringr::str_remove_all(GHHR$Text_URL, "\"")
GHHR$Text_URL <- stringr::str_remove_all(GHHR$Text_URL, "\\)")


#Extract treaty texts
GHHR$TreatyText <- lapply(GHHR$Text_URL, function(s) tryCatch(pdftools::pdf_text(s), error = function(e){as.character("Not found")}))


AGR_TXT <- as_tibble(GHHR) %>%
  dplyr::select(Title, Beg, TreatyText)
# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make AGR_TXT available
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
# run `manypkgs::add_bib(texts, AGR_TXT)`.
manypkgs::export_data(AGR_TXT, database = "texts",
                     URL = "NA")
