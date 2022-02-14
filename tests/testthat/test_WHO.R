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
  expect_col_exists(agreements[["WHO"]], vars(Title))
  expect_col_exists(agreements[["WHO"]], vars(Beg))
  expect_true(any(grepl("ID$", colnames(agreements[["WHO"]]))))
  # expect_col_exists(agreements[["WHO"]], vars(Signature))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(agreements[["WHO"]])))
  expect_false(any(lubridate::is.POSIXct(agreements[["WHO"]])))
  expect_false(any(lubridate::is.POSIXlt(agreements[["WHO"]])))
})

# Dates are standardized for mandatory column
test_that("Column `Beg` has standardised dates", {
  expect_equal(class(agreements[["WHO"]]$Beg), "messydt")
  expect_false(any(grepl("/", agreements[["WHO"]]$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                         agreements[["WHO"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         agreements[["WHO"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         agreements[["WHO"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         agreements[["WHO"]]$Beg)))
})

# test_that("Column `Signature` has standardised dates", {
#   expect_equal(class(agreements[["WHO"]]$Signature), "messydt")
#   expect_false(any(grepl("/", agreements[["WHO"]]$Signature)))
#   expect_false(any(grepl("^[:alpha:]$",
#                          agreements[["WHO"]]$Signature)))
#   expect_false(any(grepl("^[:digit:]{2}$",
#                          agreements[["WHO"]]$Signature)))
#   expect_false(any(grepl("^[:digit:]{3}$",
#                          agreements[["WHO"]]$Signature)))
#   expect_false(any(grepl("^[:digit:]{1}$",
#                          agreements[["WHO"]]$Signature)))
# })

# Dataset should be ordered according to the "Beg" column
test_that("dataset is arranged by date variable", {
  expect_true(agreements[["WHO"]]$Beg[1] <
                agreements[["WHO"]]$Beg[10])
  expect_true(agreements[["WHO"]]$Beg[50] <
                agreements[["WHO"]]$Beg[75])
  # expect_true(agreements[["WHO"]]$Beg[100] <
  #               agreements[["WHO"]]$Beg[120])
})
