# CHATHAM Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the package from the many universe.

# Stage one: Collecting data
CHATHAM <- readxl::read_excel("data-raw/organizations/CHATHAM/actors_map.xlsx")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'CHATHAM' object until the object created
# below (in stage three) passes all the tests.
CHATHAM <- as_tibble(CHATHAM) %>%
  manydata::transmutate(OrganizationID = Code,
                        Actor = manypkgs::standardise_titles(Actors),
                        CountryID = manystates::code_states(HQ_states),
                        City = HQ_city,
                        Beg = manypkgs::standardise_dates(lubridate::as_date(Year_inception)))

CHATHAM$Country <- ifelse(is.na(CHATHAM$CountryID), "UK", CHATHAM$CountryID)
CHATHAM <- CHATHAM %>%
  dplyr::select(Actor, OrganizationID, Beg, CountryID, City) %>%
  dplyr::arrange(Beg)

# manydata includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make CHATHAM available
# within the package.
manypkgs::export_data(CHATHAM,
                      database = "organizations",
                      URL = "https://www.chathamhouse.org/sites/default/files/field/field_document/20150120GlobalHealthArchitectureHoffmanColePearcey.pdf")
# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence
# to certain standards.You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows)
# to run these tests locally at any point.
# Any test failures should be pretty self-explanatory and may require
# you to return to stage two and further clean, standardise, or wrangle
# your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please make sure that you cite any sources appropriately and fill in as
# much detail about the variables etc as possible.
