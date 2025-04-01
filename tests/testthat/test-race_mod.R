# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-race_mod.R"))

# Error testing
test_that("Errors work as desired", {
  ## Unspecified PC race
  expect_error(dndR::race_mods(race = NULL))
  ## Unsupported PC race
  expect_error(dndR::race_mods(race = "fake pc race"))
})

# # Warning testing
# test_that("Warnings work as desired", {
#   # No warnings in function
# })

# Message testing
test_that("Messages work as desired", {
  expect_message(dndR::race_mods(race = "random"))
  expect_message(dndR::race_mods(race = "plasmoid"))
})

# Output testing
test_that("Outputs are as expected", {
  expect_equal(class(dndR::race_mods(race = "stout halfling")), "data.frame")
})
