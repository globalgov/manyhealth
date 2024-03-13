# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", agreements[["WHO"]])))
  expect_false(any(grepl("^N/A$", agreements[["WHO"]])))
  expect_false(any(grepl("^\\s$", agreements[["WHO"]])))
  expect_false(any(grepl("^\\.$", agreements[["WHO"]])))
  expect_false(any(grepl("N\\.A\\.$", agreements[["WHO"]])))
  expect_false(any(grepl("n\\.a\\.$", agreements[["WHO"]])))
})

# Uniformity tests (agreements have a source ID, a string title, a signature and
# entry into force date)
test_that("datasets have the required variables", {
  pointblank::expect_col_exists(agreements[["WHO"]],
                                pointblank::vars(Title))
  pointblank::expect_col_exists(agreements[["WHO"]],
                                pointblank::vars(Begin))
  expect_true(any(grepl("ID$", colnames(agreements[["WHO"]]))))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(agreements[["WHO"]])))
  expect_false(any(lubridate::is.POSIXct(agreements[["WHO"]])))
  expect_false(any(lubridate::is.POSIXlt(agreements[["WHO"]])))
})

# Dates are standardized for mandatory column
test_that("Column `Begin` has standardised dates", {
  expect_equal(class(agreements[["WHO"]]$Begin), "mdate")
  expect_false(any(grepl("/", agreements[["WHO"]]$Begin)))
  expect_false(any(grepl("^[:alpha:]$",
                         agreements[["WHO"]]$Begin)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         agreements[["WHO"]]$Begin)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         agreements[["WHO"]]$Begin)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         agreements[["WHO"]]$Begin)))
})

# Dataset should be ordered according to the "Begin" column
test_that("dataset is arranged by date variable", {
  expect_true(agreements[["WHO"]]$Begin[1] <
                agreements[["WHO"]]$Begin[10])
  expect_true(agreements[["WHO"]]$Begin[50] <
                agreements[["WHO"]]$Begin[75])
  expect_true(agreements[["WHO"]]$Begin[80] <
                agreements[["WHO"]]$Begin[100])
})
