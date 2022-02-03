# TEXT Preparation Script

# Select two columns from GHHR dataset
GHHR <- manyhealth::agreements$GHHR %>%
  dplyr::select(Title, Beg)

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
GHHR$Text_URL <- lapply(GHHR$Treaty_URL,
                        function(s) purrr::map(s,
                                               . %>%
                                                 rvest::read_html() %>%
                                                 rvest::html_nodes(".downloaddecision a") %>%
                                                 rvest::html_attr("href")))

# Clean the ouptut
GHHR$Text_URL[GHHR$Text_URL == "list(character(0))"] <- "NA"
GHHR$Text_URL <- stringr::str_remove_all(GHHR$Text_URL, "list")
GHHR$Text_URL <- stringr::str_remove_all(GHHR$Text_URL, "\\(")
GHHR$Text_URL <- stringr::str_remove_all(GHHR$Text_URL, "\"")
GHHR$Text_URL <- stringr::str_remove_all(GHHR$Text_URL, "\\)")


#Extract treaty texts
GHHR$TreatyText <- lapply(GHHR$Text_URL,
                          function(s) tryCatch(pdftools::pdf_text(s),
                                               error = function(e) {
                                                 as.character("Not found")
                                                 }))


GHHR <- as_tibble(GHHR) %>%
  dplyr::select(Title, Beg, Text_URL, TreatyText)

# Repeat process for WHO database
WHO <- manyhealth::agreements$WHO %>%
  dplyr::select(Title, Beg)

# Web scrape url
url <- "https://www.mindbank.info/collection/un_who_resolutions/all?page=all"
page = rvest::read_html(url)

extr_whotext = page %>%
  rvest::html_nodes("strong a") %>%
  rvest::html_attr("href") %>%
  paste("https://www.mindbank.info/", ., sep="")

WHO$Treaty_URL <- extr_whotext

WHO$Text_URL <- lapply(WHO$Treaty_URL,
                       function(s) purrr::map(s,
                                              . %>%
                                                rvest::read_html() %>%
                                                rvest::html_nodes(".contents_link a") %>%
                                                rvest::html_attr("href") %>%
                                                paste("https://www.mindbank.info/", ., sep="")))

for(i in 1:109){
  WHO$Text_URL[i] <- WHO$Text_URL[[i]][1]
}

for(i in 1:109){
  WHO$Text_URL[i] <- WHO$Text_URL[[i]][1]
}

# Web scrape WHO treaty texts
WHO$TreatyText <- lapply(WHO$Text_URL,
                         function(s) tryCatch(pdftools::pdf_text(s),
                                              error = function(e) {
                                                as.character("Not found")
                                                }))


WHO <- as_tibble(WHO) %>%
  dplyr::filter(TreatyText != "Not found") %>%
  dplyr::select(Title, Beg, Text_URL, TreatyText)

WHO$Text_URL <- unlist(WHO$Text_URL )

# Join two texts source into one dataset: AGR_TXT
AGR_TXT <- rbind(GHHR, WHO)

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
manypkgs::export_data(AGR_TXT,
                      database = "texts",
                      URL = "NA")
