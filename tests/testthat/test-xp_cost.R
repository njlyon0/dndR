# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-xp_cost.R"))

# Error testing
test_that("Errors work as desired", {
  ## Any input unspecified
  expect_error(dndR::xp_cost(monster_xp = NULL, monster_count = 3, party_size = 2))
  expect_error(dndR::xp_cost(monster_xp = 100, monster_count = NULL, party_size = 2))
  expect_error(dndR::xp_cost(monster_xp = 100, monster_count = 3, party_size = NULL))
  ## Any input not numeric
  expect_error(dndR::xp_cost(monster_xp = "xxx", monster_count = 3, party_size = 2))
  expect_error(dndR::xp_cost(monster_xp = 100, monster_count = "xxx", party_size = 2))
  expect_error(dndR::xp_cost(monster_xp = 100, monster_count = 3, party_size = "xxx"))
})

# Warning testing
test_that("Warnings work as desired", {
  expect_warning(dndR::xp_cost(monster_xp = 10000, monster_count = 32, party_size = 7))
})

# # Message testing
# test_that("Messages work as desired", {
#   # No messages in this function
# })

# Output testing
test_that("Outputs are as expected", {
  spent_xp <- dndR::xp_cost(monster_xp = 650, monster_count = 2, party_size = 5)
  expect_equal(class(spent_xp), "numeric")
})
