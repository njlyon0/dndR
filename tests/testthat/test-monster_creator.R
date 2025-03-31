# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-monster_creator.R"))

# Error testing
test_that("Errors work as desired", {
  expect_error(dndR::monster_creator(party_level = NULL, party_size = NULL))
  expect_error(dndR::monster_creator(party_level = 6, party_size = NULL))
  expect_error(dndR::monster_creator(party_level = NULL, party_size = 4))
  expect_error(dndR::monster_creator(party_level = "six", party_size = 4))
  expect_error(dndR::monster_creator(party_level = 6, party_size = "four"))
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
  expect_equal(class(dndR::monster_creator(party_level = 4, party_size = 4)), "data.frame")
})
