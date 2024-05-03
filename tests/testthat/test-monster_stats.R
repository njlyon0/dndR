# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-monster_stats.R"))

# Error testing
test_that("Errors work as desired", {
  expect_error(monster_stats(xp = NULL, cr = NULL))
})

# Warning testing
test_that("Warnings work as desired", {
  expect_warning(monster_stats(xp = 4000, cr = 6))
})

# # Message testing
# test_that("Messages work as desired", {
#   # No messages in this function
# })

# Output testing
test_that("Outputs are as expected", {
  expect_equal(class(monster_stats(xp = 5300, cr = NULL)), c("tbl_df", "tbl", "data.frame"))
  expect_equal(class(monster_stats(xp = NULL, cr = 12)), c("tbl_df", "tbl", "data.frame"))
})
