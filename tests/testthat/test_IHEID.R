# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", organizations[["IHEID"]])))
  expect_false(any(grepl("^N/A$", organizations[["IHEID"]])))
  expect_false(any(grepl("^\\s$", organizations[["IHEID"]])))
  expect_false(any(grepl("^\\.$", organizations[["IHEID"]])))
  expect_false(any(grepl("N\\.A\\.$", organizations[["IHEID"]])))
  expect_false(any(grepl("n\\.a\\.$", organizations[["IHEID"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(organizations[["IHEID"]])))
  expect_false(any(lubridate::is.POSIXct(organizations[["IHEID"]])))
  expect_false(any(lubridate::is.POSIXlt(organizations[["IHEID"]])))
})
