# GHHR_REF Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the many package.

# The texts datacube has been used to hand code GHHR_REF. It allowed
# to identify which treaty was citing other treaties. GHHR_REF reflects
# those relationships through the three column Treaty1, RefType and Treaty2.

# Stage one: Collecting data from the hand coded csv file
GHHR_REF <- readr::read_csv2("data-raw/references/GHHR_REF/GHHR_REF.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'GHHR_REF' object until the object created
# below (in stage three) passes all the tests.
GHHR_REF <- GHHR_REF[-c(225, 226, 227), ]

# Put dates columns in messydt
GHHR_REF$Beg1 <- manypkgs::standardise_dates(GHHR_REF$Beg1)
GHHR_REF$Beg2 <- manypkgs::standardise_dates(as.character(GHHR_REF$Beg2))

# Shift to manyID format
GHHR_REF$Treaty1 <- manypkgs::code_agreements(GHHR_REF,
                                              GHHR_REF$Treaty1,
                                              GHHR_REF$Beg1)

GHHR_REF$Treaty2 <- manypkgs::code_agreements(GHHR_REF,
                                              GHHR_REF$Treaty2,
                                              GHHR_REF$Beg2)

GHHR_REF <- as_tibble(GHHR_REF) %>%
  dplyr::select(Treaty1, Treaty2, RefType)
# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make GHHR_REF available
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
# run `manypkgs::add_bib(references, GHHR_REF)`.
manypkgs::export_data(GHHR_REF, datacube = "references",
                      URL = "https://www.globalhealthrights.org/instruments/instrument-region/")
