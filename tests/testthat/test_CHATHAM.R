# Test if  meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", actors[["CHATHAM"]])))
  expect_false(any(grepl("^n/a$", actors[["CHATHAM"]])))
  expect_false(any(grepl("^N/A$", actors[["CHATHAM"]])))
  expect_false(any(grepl("^\\s$", actors[["CHATHAM"]])))
  expect_false(any(grepl("^\\.$", actors[["CHATHAM"]])))
  expect_false(any(grepl("N\\.A\\.$", actors[["CHATHAM"]])))
  expect_false(any(grepl("n\\.a\\.$", actors[["CHATHAM"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  expect_col_exists(actors[["CHATHAM"]], vars(ID))
  expect_col_exists(actors[["CHATHAM"]], vars(Beg))
  expect_col_exists(actors[["CHATHAM"]], vars(Actor))
  expect_col_exists(actors[["CHATHAM"]], vars(Country))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(actors[["CHATHAM"]])))
  expect_false(any(lubridate::is.POSIXct(actors[["CHATHAM"]])))
  expect_false(any(lubridate::is.POSIXlt(actors[["CHATHAM"]])))
})

# Column Beg is in messydt class
test_that("Beg column is in messydt class and standardized", {
  expect_equal(class(actors[["CHATHAM"]]$Beg), "messydt")
  expect_false(any(grepl("/", actors[["CHATHAM"]]$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                         actors[["CHATHAM"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         actors[["CHATHAM"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         actors[["CHATHAM"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         actors[["CHATHAM"]]$Beg)))
})
