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
  expect_col_exists(agreements[["GHHR"]], vars(Title))
  expect_col_exists(agreements[["GHHR"]], vars(Beg))
  expect_true(any(grepl("ID$", colnames(agreements[["GHHR"]]))))
  # expect_col_exists(agreements[["GHHR"]], vars(Signature))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(agreements[["GHHR"]])))
  expect_false(any(lubridate::is.POSIXct(agreements[["GHHR"]])))
  expect_false(any(lubridate::is.POSIXlt(agreements[["GHHR"]])))
})

# Dates are standardized for mandatory column
test_that("Column `Beg` has standardised dates", {
  expect_equal(class(agreements[["GHHR"]]$Beg), "messydt")
  expect_false(any(grepl("/", agreements[["GHHR"]]$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                         agreements[["GHHR"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         agreements[["GHHR"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         agreements[["GHHR"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         agreements[["GHHR"]]$Beg)))
})

# test_that("Column `Signature` has standardised dates", {
#   expect_equal(class(agreements[["GHHR"]]$Signature), "messydt")
#   expect_false(any(grepl("/", agreements[["GHHR"]]$Signature)))
#   expect_false(any(grepl("^[:alpha:]$",
#                          agreements[["GHHR"]]$Signature)))
#   expect_false(any(grepl("^[:digit:]{2}$",
#                          agreements[["GHHR"]]$Signature)))
#   expect_false(any(grepl("^[:digit:]{3}$",
#                          agreements[["GHHR"]]$Signature)))
#   expect_false(any(grepl("^[:digit:]{1}$",
#                          agreements[["GHHR"]]$Signature)))
# })

# Dataset should be ordered according to the "Beg" column
test_that("dataset is arranged by date variable", {
  expect_true(agreements[["GHHR"]]$Beg[1] <
                agreements[["GHHR"]]$Beg[10])
  expect_true(agreements[["GHHR"]]$Beg[50] <
                agreements[["GHHR"]]$Beg[75])
  # expect_true(agreements[["GHHR"]]$Beg[100] <
  #               agreements[["GHHR"]]$Beg[120])
})
