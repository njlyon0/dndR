# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-<SCRIPT NAME>.R"))

# Error testing
test_that("Errors work as desired", {
  expect_error()
})

# Warning testing
test_that("Warnings work as desired", {
  expect_warning()
})

# Message testing
test_that("Messages work as desired", {
  expect_message()
})

# Output testing
test_that("Outputs are as expected", {
  expect_equal()
})
