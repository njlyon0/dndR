# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-encounter_creator.R"))

# Error testing
test_that("Errors work as desired", {
  ## Non-numeric max creatures
 expect_error(encounter_creator(party_level = 5, party_size = 5,
                                ver = "2024", difficulty = "moderate",
                                max_creatures = "no max", try = 5))
  ## Non positive max creatures
  expect_error(encounter_creator(party_level = 5, party_size = 5,
                                 ver = "2024", difficulty = "moderate",
                                 max_creatures = -10, try = 5))
 })

# Warning testing
test_that("Warnings work as desired", {
  expect_warning(encounter_creator(party_level = 10, party_size = 3,
                                   ver = "2014", difficulty = "deadly",
                                   try = "xxx"))
})

# Message testing
# test_that("Messages work as desired", {
#   # No messages in this function
# })

# Output testing
test_that("Outputs are as expected", {
  my_battle <- encounter_creator(party_level = 10, party_size = 4,
                                 ver = "2014", difficulty = "hard", try = 2)
  expect_equal(class(my_battle), c("tbl_df", "tbl", "data.frame"))
})
