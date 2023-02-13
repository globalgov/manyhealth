# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", references[["GHHR_REF"]])))
  expect_false(any(grepl("^N/A$", references[["GHHR_REF"]])))
  expect_false(any(grepl("^\\s$", references[["GHHR_REF"]])))
  expect_false(any(grepl("^\\.$", references[["GHHR_REF"]])))
  expect_false(any(grepl("N\\.A\\.$", references[["GHHR_REF"]])))
  expect_false(any(grepl("n\\.a\\.$", references[["GHHR_REF"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(references[["GHHR_REF"]])))
  expect_false(any(lubridate::is.POSIXct(references[["GHHR_REF"]])))
  expect_false(any(lubridate::is.POSIXlt(references[["GHHR_REF"]])))
})
