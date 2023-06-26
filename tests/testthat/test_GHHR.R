# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", agreements[["GHHR"]])))
  expect_false(any(grepl("^N/A$", agreements[["GHHR"]])))
  expect_false(any(grepl("^\\s$", agreements[["GHHR"]])))
  expect_false(any(grepl("^\\.$", agreements[["GHHR"]])))
  expect_false(any(grepl("N\\.A\\.$", agreements[["GHHR"]])))
  expect_false(any(grepl("n\\.a\\.$", agreements[["GHHR"]])))
})

# Uniformity tests (agreements have a source ID, a string title, a signature and
# entry into force date)
test_that("datasets have the required variables", {
  pointblank::expect_col_exists(agreements[["GHHR"]],
                                pointblank::vars(Title))
  pointblank::expect_col_exists(agreements[["GHHR"]],
                                pointblank::vars(Begin))
  expect_true(any(grepl("ID$", colnames(agreements[["GHHR"]]))))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(agreements[["GHHR"]])))
  expect_false(any(lubridate::is.POSIXct(agreements[["GHHR"]])))
  expect_false(any(lubridate::is.POSIXlt(agreements[["GHHR"]])))
})

# Dates are standardized for mandatory column
test_that("Column `Begin` has standardised dates", {
  expect_equal(class(agreements[["GHHR"]]$Begin), "mdate")
  expect_false(any(grepl("/", agreements[["GHHR"]]$Begin)))
  expect_false(any(grepl("^[:alpha:]$",
                         agreements[["GHHR"]]$Begin)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         agreements[["GHHR"]]$Begin)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         agreements[["GHHR"]]$Begin)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         agreements[["GHHR"]]$Begin)))
})

# Dataset should be ordered according to the "Begin" column
test_that("dataset is arranged by date variable", {
  expect_true(agreements[["GHHR"]]$Begin[1] <
                agreements[["GHHR"]]$Begin[10])
  expect_true(agreements[["GHHR"]]$Begin[50] <
                agreements[["GHHR"]]$Begin[75])
  expect_true(agreements[["GHHR"]]$Begin[100] <
                agreements[["GHHR"]]$Begin[120])
})
