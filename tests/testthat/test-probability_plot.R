# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-probability_plot.R"))

# Error testing
test_that("Errors work as desired", {
  expect_error(probability_plot(dice = "2d20", roll_num = "yyy"))
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
  my_plot <- probability_plot(dice = "2d8", roll_num = 10)
  expect_equal(class(my_plot), c("gg", "ggplot"))
})
