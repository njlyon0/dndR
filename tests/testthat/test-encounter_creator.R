# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-encounter_creator.R"))

# # Error testing
# test_that("Errors work as desired", {
#   All inputs received from/tested in `xp_pool` and/or `xp_cost`
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
  my_battle <- encounter_creator(party_level = 10, party_size = 4, difficulty = "hard")
  expect_equal(class(my_battle), c("tbl_df", "tbl", "data.frame"))
})
