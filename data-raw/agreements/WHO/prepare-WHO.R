# WHO Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the many package.

# Stage one: scraping information from WHO website
who_url <- rvest::read_html("https://extranet.who.int/mindbank/collection/un_who_resolutions/all?page=all")

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

#Extract Topic
extr_topic <- who_url %>%
  rvest::html_nodes(".light:nth-child(1)") %>%
  rvest::html_text()

WHO$Topic <- extr_topic

#Step two: create date column
WHO$Begin <- ifelse(stringr::str_detect(WHO$Org_date, "[:digit:]{4}"),
                  stringr::str_extract(WHO$Org_date, "[:digit:]{4}"),
                  stringr::str_extract(WHO$Title, "[:digit:]{4}"))

WHO$Begin <- messydates::as_messydate(WHO$Begin)

# Creae Organization column
WHO$Organisation <- stringr::str_remove(WHO$Org_date, "\\([:digit:]{4}\\)$")

# Select columns
WHO <- as_tibble(WHO) %>%
  dplyr::select(Title, Begin, Organisation, Topic)

# Add treatyID
WHO$treatyID <- manypkgs::code_agreements(WHO, WHO$Title, WHO$Begin)

# Add Lineage column
# WHO$Lineage <- manypkgs::code_lineage(WHO$Title)

# Add manyID
manyID <- manypkgs::condense_agreements(manyhealth::agreements)
WHO <- dplyr::left_join(WHO, manyID, by = "treatyID")

# Re-order columns
WHO <- WHO %>%
  dplyr::select(manyID, treatyID, Title, Begin, Organisation, Topic) %>%
  dplyr::arrange(Begin)

# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make WHO available
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
# run `manypkgs::add_bib("agreements", "WHO")`.
manypkgs::export_data(WHO,
                      datacube = "agreements",
                      URL = "https://www.mindbank.info/collection/un_who_resolutions/all?page=all")
