# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", organizations[["GHS"]])))
  expect_false(any(grepl("^N/A$", organizations[["GHS"]])))
  expect_false(any(grepl("^\\s$", organizations[["GHS"]])))
  expect_false(any(grepl("^\\.$", organizations[["GHS"]])))
  expect_false(any(grepl("N\\.A\\.$", organizations[["GHS"]])))
  expect_false(any(grepl("n\\.a\\.$", organizations[["GHS"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(organizations[["GHS"]])))
  expect_false(any(lubridate::is.POSIXct(organizations[["GHS"]])))
  expect_false(any(lubridate::is.POSIXlt(organizations[["GHS"]])))
})
