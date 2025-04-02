# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-npc_creator.R"))

# Error testing
test_that("Errors work as desired", {
  expect_error(dndR::npc_creator(npc_count = "bbb"))
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
  expect_equal(nrow(npc_creator(npc_count = 4)), 4)
  expect_equal(class(npc_creator(npc_count = 5)), "data.frame")
  ## Make sure sampling is with replacement
  race_num <- length(dnd_races())
  expect_equal(nrow(npc_creator(npc_count = race_num + 10)), race_num + 10)
})
