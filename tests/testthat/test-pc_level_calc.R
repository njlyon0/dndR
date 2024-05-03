# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-pc_level_calc.R"))

# Error testing
test_that("Errors work as desired", {
  expect_error(pc_level_calc(player_xp = NULL))
  expect_error(pc_level_calc(player_xp = "xxx"))
  expect_error(pc_level_calc(player_xp = c(4000, 250)))
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
  expect_equal(class(pc_level_calc(player_xp = 3600)), "data.frame")
})
