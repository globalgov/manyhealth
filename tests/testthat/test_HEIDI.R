# Test if  meets the q ecosystem requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", agreements[["HEIDI"]])))
  expect_false(any(grepl("^n/a$", agreements[["HEIDI"]])))
  expect_false(any(grepl("^N/A$", agreements[["HEIDI"]])))
  expect_false(any(grepl("^\\s$", agreements[["HEIDI"]])))
  expect_false(any(grepl("^\\.$", agreements[["HEIDI"]])))
  expect_false(any(grepl("N\\.A\\.$", agreements[["HEIDI"]])))
  expect_false(any(grepl("n\\.a\\.$", agreements[["HEIDI"]])))
})

# Uniformity tests (agreements have a source ID, a string title, a signature and
# entry into force date)
test_that("datasets have the required variables", {
  expect_col_exists(agreements[["HEIDI"]], vars(Title))
  expect_col_exists(agreements[["HEIDI"]], vars(Beg))
  expect_true(any(grepl("_ID$", colnames(agreements[["HEIDI"]]))))
  expect_col_exists(agreements[["HEIDI"]], vars(Signature))
  expect_col_exists(agreements[["HEIDI"]], vars(Force))
})

# Dates are standardized for mandatory column
test_that("Column `Beg` has standardised dates", {
  expect_col_is_date(agreements[["HEIDI"]], vars(Beg))
  expect_false(any(grepl("/", agreements[["HEIDI"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                         agreements[["HEIDI"]]$Beg)))
})

test_that("Column `Signature` has standardised dates", {
  expect_col_is_date(agreements[["HEIDI"]], vars(Signature))
  expect_false(any(grepl("/", agreements[["HEIDI"]]$Signature)))
  expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Signature)))
  expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Signature)))
  expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Signature)))
  expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Signature)))
  expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Signature)))
  expect_false(any(grepl("^[:alpha:]$",
                         agreements[["HEIDI"]]$Signature)))
})

test_that("Column `Force` has standardised dates", {
  expect_col_is_date(agreements[["HEIDI"]], vars(Force))
  expect_false(any(grepl("/", agreements[["HEIDI"]]$Force)))
  expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Force)))
  expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Force)))
  expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Force)))
  expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Force)))
  expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                         agreements[["HEIDI"]]$Force)))
  expect_false(any(grepl("^[:alpha:]$",
                         agreements[["HEIDI"]]$Force)))
})

# Dates are standardized for optional columns
test_that("Columns with dates are standardized", {
  if (!is.null(agreements[["HEIDI"]]$End)) {
    expect_false(any(grepl("/", agreements[["HEIDI"]]$End)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$End)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$End)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$End)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$End)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$End)))
    expect_false(any(grepl("^[:alpha:]$",
                           agreements[["HEIDI"]]$End)))
  }
  if (!is.null(agreements[["HEIDI"]]$Rat)) {
    expect_false(any(grepl("/", agreements[["HEIDI"]]$Rat)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$Rat)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$Rat)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$Rat)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$Rat)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$Rat)))
    expect_false(any(grepl("^[:alpha:]$",
                           agreements[["HEIDI"]]$Rat)))
  }
  if (!is.null(agreements[["HEIDI"]]$Term)) {
    expect_false(any(grepl("/", agreements[["HEIDI"]]$Term)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$Term)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$Term)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$Term)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$Term)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                           agreements[["HEIDI"]]$Term)))
    expect_false(any(grepl("^[:alpha:]$",
                           agreements[["HEIDI"]]$Term)))
  }
})
