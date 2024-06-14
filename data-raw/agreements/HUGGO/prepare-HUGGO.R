# HUGGO Preparation Script

# The HUGGO dataset is a consolidated dataset of the health agreements
# identified in the WHO and GHHR datasets
# but improves on the precision of dates (eg. Signature, Entry into Force),
# resolves any conflicts between these datasets,
# and fills in any missing information that could be found.
# This is a template for importing, cleaning, and exporting data
# ready for the many package.
# Treaty texts are formatted and stored in .txt files in the
# 'data_raw/agreements/HUGGO/TreatyText' folder.
# The TreatyText variable denotes if the corresponding text has been stored in the folder.

# Stage one: Assembling data from existing datasets to identify conflicts
HUGGO_original <- manydata::consolidate(manyhealth::agreements,
                               "any",
                               "any",
                               "coalesce",
                               "manyID") %>%
  dplyr::mutate(Begin = messydates::as_messydate(Begin))

# Stage two: Resolving conflicts
conflicts <- manydata::db_comp(manyhealth::agreements,
                               variable = c("Title", "Begin"),
                               category = "conflicting")

# Stage three: load and clean verified data to export as HUGGO dataset
# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.
HUGGO2 <- readr::read_csv("data-raw/agreements/HUGGO/HUGGO_reconciled.csv")
HUGGO2 <- HUGGO2 %>%
  dplyr::mutate(Title = manypkgs::standardise_titles(Title),
                Begin = messydates::as_messydate(Begin),
                Signature = messydates::as_messydate(Signature),
                Force = messydates::as_messydate(Force),
                End = messydates::as_messydate(End))

## Added 'Formal' variable identifying legally-binding formal agreements
## Formal = 1 indicates the agreement is legally-binding.
## 'Dataset' variable indicates the dataset in which agreement is also found
## (WHO, GHHR, or Both)
## 'Source' variable indicates the source of the agreement:
## WHO, UN, OAS (Organization of American States), AU (African Union),
## ACHPR (African Commission of Human and Peoples' Rights),
## COE (Council of Europe), EU (European Union), WMA (World Medical Association),
## WPA (World Psychiatric association), PAHO (Pan-American Health Organization)
## 'Health_as_primary_intent' variable indicates if agreement is primarily
## intended to govern health issues; either Y (Yes) or N (No)

# make sure manyIDs and treatyIDs are updated
HUGGO2$treatyID <- manypkgs::code_agreements(HUGGO2, HUGGO2$Title, HUGGO2$Begin)
manyID <- manypkgs::condense_agreements(manyhealth::agreements)
HUGGO2 <- dplyr::left_join(HUGGO2, manyID, by = "treatyID")
HUGGO2 <- HUGGO2 %>%
  manydata::transmutate(manyID = ifelse(!is.na(manyID.y), manyID.y, manyID.x)) %>%
  dplyr::distinct()
HUGGO2 <- HUGGO2 %>%
  dplyr::relocate(manyID, treatyID, Title, Begin, Signature, Force, End) %>%
  dplyr::select(-c(Health_in_scope, Type))

# Stage four: Improve Topic variable
## Improve Topic variable identifying issue of agreements.
## ___ issues are identified and coded here:
# compare with Topic and Lineage variables
# Currently, 9 topics are coded from the agreement titles:
# Labour, Human Rights, Protection, Mental Health, Prevention, Diseases,
# Healthcare, Pollution, Climate change
HUGGO2$Topic <- manypkgs::code_domain(HUGGO2$Title, type  = "health")

# Stage four: re-export HUGGO dataset
HUGGO <- HUGGO2 %>%
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(., "^NA$", NA_character_))) %>%
  dplyr::mutate(Title = manypkgs::standardise_titles(Title),
                Begin = messydates::as_messydate(Begin),
                Signature = messydates::as_messydate(Signature),
                Force = messydates::as_messydate(Force),
                End = messydates::as_messydate(End)) %>%
  dplyr::distinct(.keep_all = TRUE) %>%
  dplyr::arrange(Begin) %>%
  dplyr::relocate(manyID, treatyID, Title, Begin, Signature, Force, End)

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
manypkgs::export_data(HUGGO, datacube = "agreements",
                      URL = "Hand-coded by the GGO team")
