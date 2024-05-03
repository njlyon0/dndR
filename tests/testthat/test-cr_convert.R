# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-cr_convert.R"))

# Error testing
test_that("Errors work as desired", {
  expect_error(cr_convert(cr = NULL))
  expect_error(cr_convert(cr = c(10, 15)))
  expect_error(cr_convert(cr = 0.75))
})

# # Warning testing
# test_that("Warnings work as desired", {
#   # No warnings in function
# })

# # Message testing
# test_that("Messages work as desired", {
#   # No messages in function
# })

# Output testing
test_that("Outputs are as expected", {
  expect_equal(class(cr_convert(cr = 12)), "numeric")
})
