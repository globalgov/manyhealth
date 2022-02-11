# WHO_REF Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
WHO_REF <- readr::read_csv2("data-raw/references/WHO_REF/WHO_REF.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'WHO_REF' object until the object created
# below (in stage three) passes all the tests.
WHO_REF$Beg1 <- manypkgs::standardise_dates(as.character(WHO_REF$Beg1))
WHO_REF$Beg2 <- manypkgs::standardise_dates(as.character(WHO_REF$Beg2))
WHO_REF$Treaty1 <- manypkgs::code_agreements(WHO_REF,
                                             WHO_REF$Treaty1,
                                             WHO_REF$Beg1)
WHO_REF$Treaty2 <- manypkgs::code_agreements(WHO_REF,
                                             WHO_REF$Treaty2,
                                             WHO_REF$Beg2)

WHO_REF <- as_tibble(WHO_REF) %>%
  dplyr::select(Treaty1, Treaty2, RefType)
# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make WHO_REF available
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
# run `manypkgs::add_bib(references, WHO_REF)`.
manypkgs::export_data(WHO_REF, database = "references",
                     URL = "https://www.mindbank.info/collection/un_who_resolutions/all?page=all")