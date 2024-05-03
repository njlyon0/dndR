# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-creature_text.R"))

# # Error testing
# test_that("Errors work as desired", {
#   # No errors in this function
# })

# Warning testing
test_that("Warnings work as desired", {
  expect_warning(creature_text(name = "fake creature that doesn't exist"))
})

# # Message testing
# test_that("Messages work as desired", {
#   # No messages in this function
# })

# Output testing
test_that("Outputs are as expected", {
  ## Single creature
  my_creature <- creature_text(name = "goblin")
  expect_equal(class(my_creature), "data.frame")
  ## Multiple creatures
  my_creature <- creature_text(name = c("hunter shark", "vampire spawn"))
  expect_equal(class(my_creature), "data.frame")
})
