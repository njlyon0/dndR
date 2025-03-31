# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-roll.R"))

# Error testing
test_that("Errors work as desired", {
  expect_error(dndR::roll(dice = 20))
})

# Warning testing
test_that("Warnings work as desired", {
  expect_warning(dndR::roll(dice = "1d20", show_dice = "true", re_roll = FALSE))
  expect_warning(dndR::roll(dice = "1d20", show_dice = FALSE, re_roll = "true"))
})

# Message testing
test_that("Messages work as desired", {
  expect_message(dndR::roll(dice = "d20"))
})

# Output testing
test_that("Outputs are as expected", {
  ## Rolling 2 d20s should return a dataframe
  value <- dndR::roll(dice = "2d20", show_dice = FALSE, re_roll = FALSE)
  expect_equal(class(value), "data.frame")

  ## All other dice types should return a single number
  value <- dndR::roll(dice = "2d4", show_dice = FALSE, re_roll = FALSE)
  expect_equal(class(value), "integer")
  value <- dndR::roll(dice = "3d6", show_dice = FALSE, re_roll = FALSE)
  expect_equal(class(value), "integer")
  value <- dndR::roll(dice = "4d8", show_dice = FALSE, re_roll = FALSE)
  expect_equal(class(value), "integer")
  value <- dndR::roll(dice = "5d10", show_dice = FALSE, re_roll = FALSE)
  expect_equal(class(value), "integer")
  value <- dndR::roll(dice = "6d12", show_dice = FALSE, re_roll = FALSE)
  expect_equal(class(value), "integer")
  value <- dndR::roll(dice = "1d20", show_dice = FALSE, re_roll = FALSE)
  expect_equal(class(value), "integer")
  value <- dndR::roll(dice = "3d20", show_dice = FALSE, re_roll = FALSE)
  expect_equal(class(value), "integer")
})
