# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", finance[["WHO_GHED"]])))
  expect_false(any(grepl("^N/A$", finance[["WHO_GHED"]])))
  expect_false(any(grepl("^\\s$", finance[["WHO_GHED"]])))
  expect_false(any(grepl("^\\.$", finance[["WHO_GHED"]])))
  expect_false(any(grepl("N\\.A\\.$", finance[["WHO_GHED"]])))
  expect_false(any(grepl("n\\.a\\.$", finance[["WHO_GHED"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(finance[["WHO_GHED"]])))
  expect_false(any(lubridate::is.POSIXct(finance[["WHO_GHED"]])))
  expect_false(any(lubridate::is.POSIXlt(finance[["WHO_GHED"]])))
})
