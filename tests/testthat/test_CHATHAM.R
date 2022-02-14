# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", organizations[["CHATHAM"]])))
  expect_false(any(grepl("^N/A$", organizations[["CHATHAM"]])))
  expect_false(any(grepl("^\\s$", organizations[["CHATHAM"]])))
  expect_false(any(grepl("^\\.$", organizations[["CHATHAM"]])))
  expect_false(any(grepl("N\\.A\\.$", organizations[["CHATHAM"]])))
  expect_false(any(grepl("n\\.a\\.$", organizations[["CHATHAM"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(organizations[["CHATHAM"]])))
  expect_false(any(lubridate::is.POSIXct(organizations[["CHATHAM"]])))
  expect_false(any(lubridate::is.POSIXlt(organizations[["CHATHAM"]])))
})
