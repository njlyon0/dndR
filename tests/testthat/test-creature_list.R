# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-creature_list.R"))

# # Error testing
# test_that("Errors work as desired", {
#   # No errors in this function
# })

# Warning testing
test_that("Warnings work as desired", {
  expect_warning(creature_list(name = "fake creature that doesn't exist"))
})

# # Message testing
# test_that("Messages work as desired", {
#   # No messages in this function
# })

# Output testing
test_that("Outputs are as expected", {
  creature_set <- creature_list(name = "shark")
  expect_equal(class(creature_set), "data.frame")
})
