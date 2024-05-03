# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-pc_creator.R"))

# # Error testing
# test_that("Errors work as desired", {
#   # All errors tested by helper sub-functions
# })

# # Warning testing
# test_that("Warnings work as desired", {
#   # All warnings tested by helper sub-functions
# })

# # Message testing
# test_that("Messages work as desired", {
#   # All messages tested by helper sub-functions
# })

# Output testing
test_that("Outputs are as expected", {
  my_pc <- pc_creator(class = "wizard", race = "kalashtar",
                      score_method = "4d6", scores_rolled = FALSE,
                      quiet = TRUE)
  expect_equal(class(my_pc), "data.frame")
})
