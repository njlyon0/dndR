# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-ability_scores.R"))

# `ability_singular` Tests ----

# Error testing
test_that("Errors work as desired", {
  expect_error(ability_singular(method = "5d4"))
})

# # Warning testing
# test_that("Warnings work as desired", {
#   # No warnings in this function
# })

# # Message testing
# test_that("Messages work as desired", {
#   # No messages in this function
# })

# Output testing
test_that("Outputs are as expected", {
  expect_equal(class(ability_singular()), "numeric")
  expect_equal(class(ability_singular(method = "3d6")), "numeric")
  expect_equal(class(ability_singular(method = "4d6")), "numeric")
  expect_equal(class(ability_singular(method = "d20")), "numeric")
  expect_equal(class(ability_singular(method = "1d20")), "numeric")
})

# `ability_scores` Tests ----

# Error testing
test_that("Errors work as desired", {
  expect_error(ability_scores(method = "5d4", quiet = TRUE))
})

# Warning testing
test_that("Warnings work as desired", {
  ## Malformed logical
  expect_warning(ability_scores(method = "4d6", quiet = "true"))
})

# # Message testing
# test_that("Messages work as desired", {
#   ## Risky to test this because message is dependent on random output
#   expect_message(ability_scores(method = "1d20", quiet = FALSE))
# })

# Output testing
test_that("Outputs are as expected", {
  my_stats <- ability_scores(method = "4d6", quiet = TRUE)
  expect_equal(class(my_stats), "data.frame")
})
