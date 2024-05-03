# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-xp_pool.R"))

# Error testing
test_that("Errors work as desired", {
  ## Any input unspecified
  expect_error(xp_pool(party_level = NULL, party_size = 2, difficulty = 'medium'))
  expect_error(xp_pool(party_level = 3, party_size = NULL, difficulty = 'medium'))
  expect_error(xp_pool(party_level = 3, party_size = 2, difficulty = NULL))
  ## Party information non-numeric
  expect_error(xp_pool(party_level = "x", party_size = 2, difficulty = 'medium'))
  expect_error(xp_pool(party_level = 3, party_size = "x", difficulty = 'medium'))
  ## Too many party levels
  expect_error(xp_pool(party_level = 1:10, party_size = 2, difficulty = 'medium'))
  ## Unsupported difficulty
  expect_error(xp_pool(party_level = 3, party_size = 2, difficulty = 'super easy'))
})

# # Warning testing
# test_that("Warnings work as desired", {
#   # No warnings in this function
# })

# Output testing
test_that("Outputs are as expected", {
  ## Integer party level
  available_xp <- xp_pool(party_level = 5, party_size = 5, difficulty = 'medium')
  expect_equal(class(available_xp), "numeric")

  ## Non-integer party level
  available_xp <- xp_pool(party_level = 3.6, party_size = 5, difficulty = 'medium')
  expect_equal(class(available_xp), "numeric")
})
