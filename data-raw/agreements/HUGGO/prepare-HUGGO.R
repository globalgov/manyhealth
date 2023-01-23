# HUGGO Preparation Script

# The HUGGO dataset is a consolidated dataset of the health agreements
# identified in the WHO and GHHR datasets
# and contains original treaty texts.
# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Assembling data from existing datasets
HUGGO <- manydata::consolidate(manyhealth::agreements,
                               "any",
                               "any",
                               "coalesce",
                               "manyID") %>%
  dplyr::mutate(Beg = messydates::as_messydate(Beg))

# Stage two: Adding texts
#Extract titles and dates from GHR dataset
urls <- paste0("https://www.globalhealthrights.org/instruments/instrument-region/page/",
               1:16, "/")

#Title variable
extr_title <- purrr::map(
  urls,
  . %>%
    rvest::read_html() %>%
    rvest::html_nodes("#content h2") %>%
    rvest::html_text()
)
Title <- manypkgs::standardise_titles(unlist(extr_title))

#Create dataframe
GHHR <- as.data.frame(Title)

extr_date <- purrr::map(
  urls,
  . %>%
    rvest::read_html() %>%
    rvest::html_text()
)

s <- stringr::str_extract_all(extr_date,
                              "Year of adoption\\:\\s[:digit:]{4}|Year of adoption\\:\\sRegion")
date <- unlist(s)
date <- stringr::str_replace_all(date,
                                 "Year of adoption\\:\\sRegion",
                                 "NA")
date <- stringr::str_remove_all(date,
                                "Year of adoption\\:\\s")

GHHR$Beg <- manypkgs::standardise_dates(date)

#Web scraping instruments texts from the GHHR pages
#Extract url that contains link to treaty text
extr_text <- purrr::map(
  urls,
  . %>%
    rvest::read_html() %>%
    rvest::html_nodes("#content h2 a") %>%
    rvest::html_attr("href")
)

extr_text <- unlist(extr_text)
GHHR$Treaty_URL <- extr_text

#Extract the URL of the text itself
GHHR$Text_URL <- lapply(GHHR$Treaty_URL,
                        function(s) purrr::map(s,
                                               . %>%
                                                 rvest::read_html() %>%
                                                 rvest::html_nodes(".downloaddecision a") %>%
                                                 rvest::html_attr("href")))
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

GHHR$Source <- "GHHR"
GHHR <- as_tibble(GHHR) %>%
  dplyr::select(Title, Beg, Text_URL, TreatyText, Source)

GHHR$treatyID <- manypkgs::code_agreements(GHHR, GHHR$Title, GHHR$Beg)

#Repeat process for WHO database
who_url <- rvest::read_html("https://www.mindbank.info/collection/un_who_resolutions/all?page=all")

extr_title <- who_url %>%
  rvest::html_nodes("strong a") %>%
  rvest::html_text()

Title <- manypkgs::standardise_titles(extr_title)

# Create dataframe
WHO <- as.data.frame(Title)

#Extract Date
extr_date <- who_url %>%
  rvest::html_nodes("p.light") %>%
  rvest::html_text()

WHO$Org_date <- extr_date

# Create Beg column
WHO$Beg <- ifelse(stringr::str_detect(WHO$Org_date, "[:digit:]{4}"),
                  stringr::str_extract(WHO$Org_date, "[:digit:]{4}"),
                  stringr::str_extract(WHO$Title, "[:digit:]{4}"))

WHO$Beg <- manypkgs::standardise_dates(WHO$Beg)

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

WHO$Source <- "WHO"
WHO <- as_tibble(WHO) %>%
  dplyr::filter(TreatyText != "Not found") %>%
  dplyr::select(Title, Beg, Text_URL, TreatyText, Source)

WHO$Text_URL <- unlist(WHO$Text_URL)

WHO$treatyID <- manypkgs::code_agreements(WHO, WHO$Title, WHO$Beg)

# Join texts to HUGGO dataset
texts <- rbind(GHHR, WHO)
manyID <- manypkgs::condense_agreements(manyhealth::agreements) # Add manyID
texts <- dplyr::left_join(texts, manyID, by = "treatyID")
texts <- texts %>% dplyr::relocate(manyID) %>%
  dplyr::rename(url = Text_URL)
HUGGO <- dplyr::left_join(HUGGO, texts,
                          by = c("manyID", "Title", "Beg", "treatyID"))
HUGGO <- HUGGO %>%
  dplyr::mutate(TreatyText = ifelse(TreatyText == "Not found" | TreatyText == "NULL",
                                    gsub("Not found|NULL", NA, TreatyText),
                                    TreatyText))

HUGGO <- dplyr::distinct(HUGGO)

# Stage three: Adding membership conditions and membership procedures variables
HUGGO$Memb.conditions <- manypkgs::code_accession_terms(HUGGO$TreatyText,
                                                        HUGGO$Title,
                                                        accession = "condition")
HUGGO$Memb.procedures <- manypkgs::code_accession_terms(HUGGO$TreatyText,
                                                        accession = "process")
HUGGO <- dplyr::relocate(HUGGO, manyID, Title, Beg, Organisation,
                         Topic, Region, LegalStatus, Lineage, Memb.conditions,
                         Memb.procedures, treatyID, TreatyText, url, Source)
HUGGO <- HUGGO %>%
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(., "^NA$", NA_character_))) %>%
  dplyr::distinct(.keep_all = TRUE) %>%
  dplyr::mutate(Beg = messydates::as_messydate(Beg)) %>%
  dplyr::arrange(Beg)

# Stage four: Resolving conflicts
conflicts <- manydata::db_comp(manyhealth::agreements,
                               variable = c("Title", "Beg"),
                               category = "conflicting")

# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make HUGGO available within the package.
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
# To add a template of .bib file to the package,
# please run `manypkgs::add_bib("agreements", "HUGGO")`.
manypkgs::export_data(HUGGO, database = "agreements",
                      URL = c("https://www.mindbank.info/collection/un_who_resolutions/all?page=all",
                              "https://www.globalhealthrights.org/"))
