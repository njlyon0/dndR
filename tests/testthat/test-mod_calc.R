# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-mod_calc.R"))

# Error testing
test_that("Errors work as desired", {
  expect_error(dndR::mod_calc(score = "aaa"))
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
  expect_equal(class(dndR::mod_calc(score = 10)), "character")
})
