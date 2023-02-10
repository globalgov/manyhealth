# manyhealth 0.2.0

2023-02-10

## Data

* Closed #14 by adding `GHS` (short for Global Health System) dataset by Hoffman and Cole (2018) in the `organisations` database
* Closed #15 by adding `HUGGO` dataset, based on a consolidated version of the `GHHR` and `WHO` datasets in the `agreements` database.
* Closed #16 by adding contributions to the `HUGGO` dataset, including the addition and verification of metadata (Title and date -- Beg, Signature, Force, and End -- variables) and sources/url links of treaty texts.
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
