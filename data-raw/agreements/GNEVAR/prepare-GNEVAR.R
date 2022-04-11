# GNEVAR Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Assembling data from existing datasets
GNEVAR <- manydata::consolidate(manyhealth::agreements,
                                "any",
                                "any",
                                "coalesce",
                                "manyID")

# Stage two: Adding membership conditions and membership procedures variables
AGR_TXT <- manyhealth::texts$AGR_TXT
AGR_TXT$Memb.conditions <- manypkgs::code_memberships(AGR_TXT$TreatyText,
                                                      AGR_TXT$Title,
                                                      memberships = "condition")
AGR_TXT$Memb.procedures <- manypkgs::code_memberships(AGR_TXT$TreatyText,
                                                      memberships = "process")
AGR_TXT <- dplyr::select(AGR_TXT, manyID, Title, Memb.conditions, Memb.procedures)
GNEVAR <- dplyr::left_join(GNEVAR, AGR_TXT,
                           by = c("manyID", "Title"))
GNEVAR <- dplyr::relocate(GNEVAR, manyID, Organisation, Topic, Title, Beg, Region,
                          LegalStatus, Lineage, Memb.conditions, Memb.procedures,
                          treatyID)
GNEVAR <- GNEVAR %>%
  dplyr::arrange(Beg)

# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make GNEVAR available
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
# To add a template of .bib file to the package,
# please run `manypkgs::add_bib(agreements, GNEVAR)`.
manypkgs::export_data(GNEVAR, database = "agreements",
                     URL = c("https://www.mindbank.info/collection/un_who_resolutions/all?page=all",
                             "https://www.globalhealthrights.org/"))
