# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-reroll.R"))

# NO INPUT TESTS CURRENTLY NEEDED
## `reroll` is only used inside of `roll` so it is not possible for it receive improper inputs

# # Error testing
# test_that("Errors work as desired", {
#   All inputs received from/tested in `roll`
# })

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
  new_values <- dndR::reroll(dice_faces = 1, first_result = c(1, 1, 5, 3, 6))
  expect_equal(class(new_values), "numeric")
})
