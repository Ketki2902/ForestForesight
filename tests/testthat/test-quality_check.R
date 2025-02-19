library(testthat)

# Mock input data
dates <- Sys.getenv("TEST_FF_PREP_QC_DATE")
country <- Sys.getenv("TEST_FF_PREP_COUNTRY")
datafolder <- Sys.getenv("TEST_DATA_FOLDER")
# cat("From test-QC: the country is ")
# cat(country)
shape <- NULL
tiles <- NULL
shrink <- "none"

test_that("quality_check works as expected", {
  # Test valid input, expecting to return a list with datafolder and shrink
  result <- quality_check(dates, country, shape, tiles, datafolder, shrink)
  expect_equal(result$datafolder, datafolder)
  expect_equal(result$shrink, shrink)

  # Test missing country and shape, expecting shrink to be set to 'none'
  result <- quality_check(dates, country, NULL, tiles, datafolder, shrink)
  expect_equal(result$shrink, "none")

  # Test missing dates with NA
  expect_error(
    quality_check(NA, country, shape, tiles, datafolder, shrink),
    "No dates were given"
  )

  # Test missing dates with NULL
  expect_error(
    quality_check(NULL, country, shape, tiles, datafolder, shrink),
    "No dates were given"
  )

  # Test missing dates with an empty string
  expect_error(
    quality_check("", country, shape, tiles, datafolder, shrink),
    "No dates were given"
  )

  # Test missing tiles, country, and shape
  expect_error(
    quality_check(dates, NULL, NULL, NULL, datafolder, shrink),
    "Unknown what to process since no tiles, country, or shape were given"
  )

  # Test shape is not SpatVector
  expect_error(
    quality_check(dates, country, "invalid_shape", tiles, datafolder, shrink),
    "Shape should be of class SpatVector"
  )
})
