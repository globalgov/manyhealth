# GHS Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.
# The GHS dataset is obtained from the list of global health actors
# included in Table 2 in Hoffman and Cole (2018) \doi{10.1186/s12992-018-0340-2}

# Stage one: Collecting data
library(rvest)
library(dplyr)
library(readr)

page <- read_html("https://globalizationandhealth.biomedcentral.com/articles/10.1186/s12992-018-0340-2/tables/2")
text <- page %>%
  html_elements(".u-text-char , .u-text-left, th") %>%
  html_text()
data <- stringr::str_squish(text)
header <- page %>%
  html_elements(".c-article-table-head p") %>%
  html_text()
header # extract variable names for dataframe
varnames <- c("Number", "Actor", "Code", "URL", "Type", "Headquarters Location",
           "State", "Health as primary intent?", "Year of Inception")
id <- 1:203 # create identifying numbers for rows
data <- data %>%
  as.data.frame(row.names = NULL) %>%
  dplyr::filter(!row_number() %in% c(1:length(header))) %>%
  dplyr::mutate(names = rep(names, 203)) %>%
  subset(names != "Number") %>%
  dplyr::mutate(id = rep(id, each = 8))
GHS <- tidyr::pivot_wider(data, id_cols = "id",
                          names_from = "names", values_from = ".")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'GHS' object until the object created
# below (in stage three) passes all the tests.
# manydata includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.
GHS <- as_tibble(GHS) %>%
  manydata::transmutate(Organization = Actor,
                        organizationID = Code,
                        Beg = messydates::as_messydate(as.character(`Year of Inception`)),
                        City = `Headquarters Location`) %>%
  dplyr::relocate(organizationID, Organization, Beg, City, State) %>%
  dplyr::select(-id) %>%
  dplyr::arrange(Beg)
# If using the data in combination with manystates data on state actors,
# please note that there may be overlaps in three-letter organizationID and
# three-letter stateID.

# Stage three: Connecting data
# Next run the following line to make GHS available
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
# run `manypkgs::add_bib("organizations", "GHS")`.
manypkgs::export_data(GHS,
                      database = "organizations",
                      URL = "https://doi.org/10.1186/s12992-018-0340-2")
