# manyhealth 0.3.0

2024-03-01

## Package

* Added `memberships` to pkgdown.yml for website.
* Updated vignette with data from memberships datacube and used new graphing functions from `{manynet}`.

## Data

* Closed #25 by renaming `Beg` variable `Begin` across all datasets.
* Closed #29 by adding a `Formal` variable in `HUGGO` dataset to distinguish between formal agreements and other non-legally binding resolutions, declarations, etc.
* Closed #24 by recoding End dates for all agreements, so that agreements that are known to be still in force are coded '9999-12-31' rather than NA.
* Closed #18 by adding `HUGGO_MEM` dataset and memberships database.
* Closed #26 by updating the state names and stateIDs in the `HUGGO_MEM` dataset, so that stateIDs are unique and names are standardised.
* Closed #28 by adding a `Succession` variable in `HUGGO_MEM` to indicate the states that have a predecessor or successor since 1945.
* Added an `Accession` variable in `HUGGO_MEM` that records the date of accession to each agreement for states.
* Closed #30 by adding date of deposit as a proxy for date of ratification in variable `StateRat`.

# manyhealth 0.2.0

2023-02-14

## Data

* Closed #14 by adding `GHS` (short for Global Health System) dataset by Hoffman and Cole (2018) in the `organisations` database
* Closed #15 by adding `HUGGO` dataset, based on a consolidated version of the `GHHR` and `WHO` datasets in the `agreements` database.
* Closed #16 by adding contributions to the `HUGGO` dataset, including the addition and verification of metadata (Title and dates -- Beg, Signature, Force, and End -- variables) and sources/url links of treaty texts.
* Removed `texts` database. Treaty texts are in the process of being incorporated into the `agreements` database in the HUGGO dataset. This release excludes the treaty texts as they are being formatted and stored as .txt files to facilitate future use.

# manyhealth 0.1.1

2022-02-11

## Package

* Added a vignette to present data package

## Data

* Closed #5 by web scraping agreements data
* Closed #6 by web scraping WHO agreements data

**Created texts database**
* Added treaty texts from WHO by web scraping data
* Added treaty texts from GHHR by web scraping data

**Created references database**
* Added GHHR_REF dataset by hand-coding "cites" relationships between treaty texts

# manyhealth 0.1.0

2022-01-10

## Package

* Renamed package from qHealth to manyhealth
* Fixed #3 by changing the logo and updated references from qData to manydata

## Data

* Closed #2 by creating the actors database with the CHATHAM dataset

# qHealth 0.0.1

* Set up qHealth package using qData::setup_package()
  * Added `DESCRIPTION` file
  * Added `R` folder
  * Added `LICENSE` file
  * Added `NAMESPACE` file
  * Added `NEWS` file
  * Added `README` file
  * Added `.github` folder
  * Added `CODE_OF_CONDUCT` file
  * Added `CONTRIBUTING` file
  * Added `pull_request_template` file
  * Added `ISSUE_TEMPLATE` folder
  * Added `bug_report` file
  * Added `feature_request` file
  * Added `workflows` folder
  * Added `prchecks` file
  * Added `pushrelease` file
  * Added `prcommands` file
  * Added `tests` folder
  * Added `testthat` folder
  * Added `testthat` file
