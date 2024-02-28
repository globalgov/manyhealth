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

# Stage three: merge verified data into HUGGO dataset
HUGGO2 <- readr::read_csv("data-raw/agreements/HUGGO/HUGGO_reconciled.csv")
HUGGO2 <- HUGGO2 %>%
  dplyr::mutate(Title = manypkgs::standardise_titles(Title),
                Begin = messydates::as_messydate(Begin),
                Signature = messydates::as_messydate(Signature),
                Force = messydates::as_messydate(Force),
                End = messydates::as_messydate(End))
# make sure manyIDs and treatyIDs are matched with HUGGO_original
IDs <- dplyr::select(HUGGO_original, manyID, treatyID, Title)
HUGGO2 <- dplyr::left_join(HUGGO2, IDs, by = "Title")
HUGGO2 <- HUGGO2 %>%
  manydata::transmutate(manyID = ifelse(!is.na(manyID.y), manyID.y, manyID.x),
                        treatyID = ifelse(!is.na(treatyID.y), treatyID.y, treatyID.x)) %>%
  dplyr::distinct()

HUGGO_new <- dplyr::full_join(HUGGO_original, HUGGO2, by = c("manyID", "treatyID")) %>%
  dplyr::distinct() %>%
  dplyr::relocate(manyID, Title.x, Title.y, Begin.x, Begin.y, Signature,
                  Force, Organisation)
## Clean merged data
# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.
HUGGO_new <- HUGGO_new %>%
  dplyr::mutate(Title = ifelse(!is.na(Title.y), Title.y, Title.x),
                Begin = ifelse(!is.na(Begin.y), Begin.y, Begin.x)) %>%
  dplyr::select(-c(Title.x, Title.y, Begin.x, Begin.y)) %>%
  dplyr::distinct() %>%
  dplyr::relocate(manyID, Title, Begin, Signature, Force, End, Organisation)

# make sure manyIDs and treatyIDs are updated
HUGGO_new$treatyID <- manypkgs::code_agreements(HUGGO_new, HUGGO_new$Title,
                                                HUGGO_new$Begin)
manyID <- manypkgs::condense_agreements(manyhealth::agreements)
HUGGO_new <- dplyr::left_join(HUGGO_new, manyID, by = "treatyID")
HUGGO_new <- HUGGO_new %>%
  manydata::transmutate(manyID = ifelse(!is.na(manyID.y), manyID.y, manyID.x)) %>%
  dplyr::distinct()

## Remove duplicated entries from merging dataset
which(HUGGO_new$manyID == "WHDSBL_2013O69")
# duplicate due to repeat in Organisation name
HUGGO_new <- HUGGO_new[-which(HUGGO_new$manyID == "WHDSBL_2013O69" & HUGGO_new$Organisation == "World Health Organization; World Health Organization "), ]

which(HUGGO_new$manyID == "FP09CD_2013R")
# duplicate due to different Organisation for same resolution
# Organisation should be World Health Assembly, not World Health Organisation
HUGGO_new <- HUGGO_new[-(which(HUGGO_new$manyID == "FP09CD_2013R" & HUGGO_new$Organisation == "World Health Organization ")), ]

which(HUGGO_new$manyID == "PD12HW_2019R")
# duplicates due to different names
HUGGO_new <- HUGGO_new[-(which(HUGGO_new$manyID == "PD12HW_2019R" & HUGGO_new$whoID == "105")), ]
HUGGO_new <- HUGGO_new[-(which(HUGGO_new$manyID == "PD12HW_2019R" & HUGGO_new$Title == "Political Declaration Of The High-level Meeting On Universal Health Coverage Universal Health Coverage Moving Together To Build A Healthier World")), ]

which(HUGGO_new$manyID == "HLTPDA_2013O")
# duplicates due to wrong whoID
HUGGO_new <- HUGGO_new[-which(HUGGO_new$manyID == "HLTPDA_2013O" & HUGGO_new$whoID == "90"),]

which(HUGGO_new$manyID == "HLTPDA_2014O")
# duplicates due to wrong whoID
HUGGO_new <- HUGGO_new[-which(HUGGO_new$manyID == "HLTPDA_2014O" & HUGGO_new$whoID == "78"),]

which(HUGGO_new$manyID == "IMPLRC_1993A")
# duplicates due to error in year
HUGGO_new <- HUGGO_new[-which(HUGGO_new$manyID == "IMPLRC_1993A" & HUGGO_new$whoID == "14"),]

which(HUGGO_new$manyID == "IW09PD_2005S")
# duplicates due to extra Organization name
HUGGO_new <- HUGGO_new[-(which(HUGGO_new$manyID == "IW09PD_2005S" & HUGGO_new$Organisation == "United Nations Development Programme Fiji Multi- Country Office ")), ]

which(HUGGO_new$manyID == "IW09PD_2007S")
# duplicates due to extra Organization name
HUGGO_new <- HUGGO_new[-(which(HUGGO_new$manyID == "IW09PD_2007S" & HUGGO_new$Organisation == "United Nations Development Programme Fiji Multi- Country Office ")), ]

which(HUGGO_new$manyID == "MA04DG_2008O")
# duplicates due to wrong whoID
HUGGO_new <- HUGGO_new[-which(HUGGO_new$manyID == "MA04DG_2008O" & HUGGO_new$whoID == "46"),]

which(HUGGO_new$manyID == "MA04DG_2010O")
# duplicates due to wrong whoID
HUGGO_new <- HUGGO_new[-which(HUGGO_new$manyID == "MA04DG_2010O" & HUGGO_new$whoID == "39"),]

which(HUGGO_new$manyID == "PCNDIG_2007S")
# duplicates due to wrong whoID
HUGGO_new <- HUGGO_new[-which(HUGGO_new$manyID == "PCNDIG_2007S" & HUGGO_new$whoID == "40"),]

which(HUGGO_new$manyID == "PCNDIG_2008S")
# duplicates due to wrong whoID
HUGGO_new <- HUGGO_new[-which(HUGGO_new$manyID == "PCNDIG_2008S" & HUGGO_new$whoID == "38"),]

which(HUGGO_new$manyID == "AFCHPR_1981A")
# duplicates due to corrected title
HUGGO_new[which(HUGGO_new$manyID == "AFCHPR_1981A"), 9] <- "NA - human rights"
HUGGO_new[which(HUGGO_new$manyID == "AFCHPR_1981A"), 11] <- "Africa"
HUGGO_new[which(HUGGO_new$manyID == "AFCHPR_1981A"), 12] <- "Intergovernmental - Legally Binding"
HUGGO_new[which(HUGGO_new$manyID == "AFCHPR_1981A"), 13] <- 46
HUGGO_new <- HUGGO_new[-which(HUGGO_new$manyID == "AFCHPR_1981A" & HUGGO_new$Title == "African Charter On Humans And Peoples Rights 1981"),]

which(HUGGO_new$treatyID == "DCLRRC_1959R:IMPLRC_1993A")
# duplicates due to entries in different datasets
HUGGO_new[which(HUGGO_new$treatyID == "DCLRRC_1959R:IMPLRC_1993A"), 11] <- "Universal"
HUGGO_new[which(HUGGO_new$treatyID == "DCLRRC_1959R:IMPLRC_1993A"), 12] <- "Intergovernmental - Non-binding"
HUGGO_new[which(HUGGO_new$treatyID == "DCLRRC_1959R:IMPLRC_1993A"), 13] <- 21
HUGGO_new <- HUGGO_new[-which(HUGGO_new$manyID == "DCLRRC_1959R:RGHTSC_1989A"), ]
HUGGO_new <- HUGGO_new[-which(HUGGO_new$manyID == "DCLRRC_1959R:IMPLRC_1992A" & HUGGO_new$TreatyText == 0), ]

# Stage four: add variables identifying Formal agreements and improve Topic variable
## Add 'Formal' variable identifying legally-binding formal agreements
## Formal = 1 indicates the agreement is legally-binding.
HUGGO_new <- HUGGO_new %>%
  dplyr::mutate(Formal = ifelse(stringr::str_detect(LegalStatus,
                                                    "Legally Binding"), 1, 0))
HUGGO_new$Formal <- ifelse(is.na(HUGGO_new$Formal), 0, HUGGO_new$Formal)

## Improve Topic variable identifying issue of agreements.
## ___ issues are identified and coded here:
# compare with Topic and Lineage variables
# Currently, 9 topics are coded from the agreement titles:
# Labour, Human Rights, Protection, Mental Health, Prevention, Diseases,
# Healthcare, Pollution, Climate change
HUGGO$Topic2 <- manypkgs::code_domain(HUGGO$Title, type  = "health")

# Stage five: re-export HUGGO dataset
HUGGO <- HUGGO_new %>%
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(., "^NA$", NA_character_))) %>%
  dplyr::mutate(Title = manypkgs::standardise_titles(Title),
                Begin = messydates::as_messydate(Begin),
                Signature = messydates::as_messydate(Signature),
                Force = messydates::as_messydate(Force),
                End = messydates::as_messydate(End),
                whoID = as.integer(whoID),
                ghhrID = as.integer(ghhrID)) %>%
  dplyr::distinct(.keep_all = TRUE) %>%
  dplyr::arrange(Begin) %>%
  dplyr::relocate(manyID, treatyID, Title, Begin, Signature, Force, End,
                  Organisation, Topic, Region, LegalStatus, Formal)

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
