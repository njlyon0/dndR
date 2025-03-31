# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-spell_list.R"))

# Error testing
test_that("Errors work as desired", {
  ## ritual is neither NULL nor logical
  expect_error(spell_list(ritual = "false"))
})

# Warning testing
test_that("Warnings work as desired", {
  expect_warning(spell_list(name = "fake spell that doesn't exist"))
  expect_warning(spell_list(name = "chill touch", ver = "2024"))
})

# # Message testing
# test_that("Messages work as desired", {
#   # No messages in this function
# })

# Output testing
test_that("Outputs are as expected", {
  spell_set <- spell_list(name = "chill touch")
  expect_equal(class(spell_set), "data.frame")
})
