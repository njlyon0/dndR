# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-spell_text.R"))

# # Error testing
# test_that("Errors work as desired", {
#   # No errors in this function
# })

# Warning testing
test_that("Warnings work as desired", {
  expect_warning(dndR::spell_text(name = "fake spell that doesn't exist"))
  expect_warning(dndR::spell_text(name = "chill touch", ver = "2024"))
})

# # Message testing
# test_that("Messages work as desired", {
#   # No messages in this function
# })

# Output testing
test_that("Outputs are as expected", {
  ## Single spell
  my_spell <- dndR::spell_text(name = "fire bolt")
  expect_equal(class(my_spell), "data.frame")
  ## Multiple spells
  my_spell <- dndR::spell_text(name = c("mending", "shocking grasp"))
  expect_equal(class(my_spell), "data.frame")
})
