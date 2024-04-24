# HUGGO_MEM Preparation Script

# This is a dataset of hand-coded data of states' memberships to
# health agreements listed in HUGGO dataset in agreements datacube.
# This is a template for importing, cleaning, and exporting data
# ready for the many package.

# Stage one: Collecting data
HUGGO_MEM <- readr::read_csv("data-raw/memberships/HUGGO_MEM/HUGGO_MEM_additional.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'HUGGO_MEM' object until the object created
# below (in stage three) passes all the tests.
# We recommend that you avoid using one letter variable names to keep
# away from issues with ambiguous names down the road.
HUGGO_MEM <- as_tibble(HUGGO_MEM) %>%
  dplyr::mutate(stateID = manypkgs::code_states(StateName, activity = FALSE,
                                                replace = "ID"),
                Begin = messydates::as_messydate(Begin),
                Signature = messydates::as_messydate(Signature),
                Force = messydates::as_messydate(Force),
                End = messydates::as_messydate(End),
                StateSignature = messydates::as_messydate(StateSignature),
                StateRatification = messydates::as_messydate(StateRatification),
                StateEnd = messydates::as_messydate(StateEnd),
                StateForce = messydates::as_messydate(StateForce)) %>%
  dplyr::arrange(Begin)

HUGGO_MEM <- HUGGO_MEM %>%
  dplyr::mutate(StateName = ifelse(StateName == "Democratic Republic of the Congo - Congo",
                                   "Democratic Republic of the Congo",
                                   StateName),
                # correct double StateNames and stateIDs
                stateID = ifelse(stateID == "COD - COG",
                                 "COD",
                                 stateID)) %>%
  # remove entries for NA: StateNames that were European Atomic Energy Community
  # and World Psychiatric Association
  dplyr::filter(!is.na(StateName))

# Ensure NAs and data are coded correctly
HUGGO_MEM <- HUGGO_MEM %>%
  dplyr::mutate(Begin = ifelse(Begin == "-", NA, Begin),
                Signature = ifelse(Signature == "-", NA, Signature),
                Force = ifelse(Force == "-", NA, Force),
                End = ifelse(End == "-", NA, End),
                StateSignature = ifelse(StateSignature == "-", NA,
                                        StateSignature),
                StateRatification = ifelse(StateRatification == "-", NA,
                                           StateRatification),
                StateForce = ifelse(StateForce == "-", NA, StateForce),
                StateEnd = ifelse(StateEnd == "-", NA, StateEnd)) %>%
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(., "^NA$", NA_character_))) %>%
  dplyr::mutate(Begin = messydates::as_messydate(Begin),
                Signature = messydates::as_messydate(Signature),
                Force = messydates::as_messydate(Force),
                End = messydates::as_messydate(End),
                StateSignature = messydates::as_messydate(StateSignature),
                StateRatification = messydates::as_messydate(StateRatification),
                StateForce = messydates::as_messydate(StateForce),
                StateEnd = messydates::as_messydate(StateEnd),
                StateName = manypkgs::standardise_titles(StateName),
                Accession = messydates::as_messydate(Accession)) %>%
  dplyr::arrange(Begin, manyID, stateID) %>%
  dplyr::select(manyID, Title, Begin, stateID, StateName,
                StateSignature, StateRatification, StateForce, StateEnd,
                `Rat=Notif`, Accession, Succession,
                treatyID, Signature, Force, End, Coder) %>%
  dplyr::distinct()

# manypkgs includes several functions that should help with
# cleaning and standardising your data
# such as `standardise_titles()` and `standardise_texts()`.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make HUGGO_MEM available
# within the package.
# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence
# to certain standards.
# You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows)
# to run these tests locally at any point.
# Any test failures should be pretty self-explanatory
# and may require you to return to stage two and further clean,
# standardise, or wrangle your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please note that the export_data() function requires a .bib file to be
# present in the data_raw folder of the package for citation purposes.
# Therefore, please make sure that you have permission to use the dataset
# that you're including in the package.
# To add a template of .bib file to the package,
# please run `manypkgs::add_bib("memberships", "HUGGO_MEM")`.
manypkgs::export_data(HUGGO_MEM, datacube = "memberships",
                      URL = "Hand-coded by the GGO team")
