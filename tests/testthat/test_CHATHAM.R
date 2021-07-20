# Test if  meets the q ecosystem requirements

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

# At least one column named ID
test_that("a column indicating an ID source exists", {
  expect_true(any(grepl("_ID$", colnames(actors[["CHATHAM"]]))))
})

# Labels are standardized
test_that("labels are standardised", {
  if (!is.null(actors[["CHATHAM"]]$Label)) {
  expect_false(any(grepl("U.S.", actors[["CHATHAM"]])))
  expect_false(any(grepl("U.K.", actors[["CHATHAM"]])))
  expect_false(any(grepl("!", actors[["CHATHAM"]])))
  expect_false(any(grepl("NANA.", actors[["CHATHAM"]])))
  }
})

# Dates are standardized
test_that("Columns with dates are standardized", {
  if (!is.null(actors[["CHATHAM"]]$Beg)) {
    expect_equal(class(actors[["CHATHAM"]]$Beg), "messydt")
    expect_false(any(grepl("/", actors[["CHATHAM"]]$Beg)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Beg)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Beg)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Beg)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Beg)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Beg)))
    expect_false(any(grepl("^[:alpha:]$",
                           actors[["CHATHAM"]]$Beg)))
  }
  if (!is.null(actors[["CHATHAM"]]$End)) {
    expect_equal(class(actors[["CHATHAM"]]$End), "messydt")
    expect_false(any(grepl("/", actors[["CHATHAM"]]$End)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$End)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$End)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$End)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$End)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$End)))
    expect_false(any(grepl("^[:alpha:]$",
                           actors[["CHATHAM"]]$End)))
  }
  if (!is.null(actors[["CHATHAM"]]$Force)) {
    expect_equal(class(actors[["CHATHAM"]]$Force), "messydt")
    expect_false(any(grepl("/", actors[["CHATHAM"]]$Force)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Force)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Force)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Force)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Force)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Force)))
    expect_false(any(grepl("^[:alpha:]$",
                           actors[["CHATHAM"]]$Force)))
  }
  if (!is.null(actors[["CHATHAM"]]$Rat)) {
    expect_equal(class(actors[["CHATHAM"]]$Rat), "messydt")
    expect_false(any(grepl("/", actors[["CHATHAM"]]$Rat)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Rat)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Rat)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Rat)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Rat)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Rat)))
    expect_false(any(grepl("^[:alpha:]$",
                           actors[["CHATHAM"]]$Rat)))
  }
  if (!is.null(actors[["CHATHAM"]]$Signature)) {
    expect_equal(class(actors[["CHATHAM"]]$Signature), "messydt")
    expect_false(any(grepl("/", actors[["CHATHAM"]]$Signature)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Signature)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Signature)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Signature)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Signature)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Signature)))
    expect_false(any(grepl("^[:alpha:]$",
                           actors[["CHATHAM"]]$Signature)))
  }
  if (!is.null(actors[["CHATHAM"]]$Term)) {
    expect_equal(class(actors[["CHATHAM"]]$Term), "messydt")
    expect_false(any(grepl("/", actors[["CHATHAM"]]$Term)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Term)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Term)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Term)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Term)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Term)))
    expect_false(any(grepl("^[:alpha:]$",
                           actors[["CHATHAM"]]$Term)))
  }
  if (!is.null(actors[["CHATHAM"]]$Withdrawal)) {
    expect_equal(class(actors[["CHATHAM"]]$Withdrawal), "messydt")
    expect_false(any(grepl("/", actors[["CHATHAM"]]$Withdrawal)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Withdrawal)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Withdrawal)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{1}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Withdrawal)))
    expect_false(any(grepl("^[:digit:]{1}-[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Withdrawal)))
    expect_false(any(grepl("^[:digit:]{2}-[:digit:]{4}$",
                           actors[["CHATHAM"]]$Withdrawal)))
    expect_false(any(grepl("^[:alpha:]$",
                           actors[["CHATHAM"]]$Withdrawal)))
  }
})

# Dataset should be ordered according to the "Beg" column
# if the column exists
  test_that("dataset is arranged by date variable", {
    if (!is.null(actors[["CHATHAM"]]$Beg)) {
  expect_true(actors[["CHATHAM"]]$Beg[1] < actors[["CHATHAM"]]$Beg[10])
  expect_true(actors[["CHATHAM"]]$Beg[50] < actors[["CHATHAM"]]$Beg[75])
  expect_true(actors[["CHATHAM"]]$Beg[100] < actors[["CHATHAM"]]$Beg[120])
    }
})
