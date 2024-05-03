# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-class_block.R"))

# Error testing
test_that("Errors work as desired", {
  ## Specified that scores have been rolled but data not provided to function
  expect_error(class_block(class = "cleric", scores_rolled = TRUE, scores_df = NULL))
  ## Pre-rolled scores not provided as a dataframe
  expect_error(class_block(class = "fighter", scores_rolled = TRUE, scores_df = 10:15))
  ## Pre-rolled scores provided but not enough of them
  my_stats <- ability_scores(method = "4d6", quiet = TRUE)[-1,]
  expect_error(class_block(class = "warlock", scores_rolled = TRUE, scores_df = my_stats))
  ## Class is null
  expect_error(class_block(class = NULL, quiet = TRUE))
  ## Class is unsupported
  expect_error(class_block(class = "fake class", quiet = TRUE))
})

# Warning testing
test_that("Warnings work as desired", {
  expect_warning(class_block(class = "wizard", scores_rolled = "false"))
})

# Message testing
test_that("Messages work as desired", {
  expect_message(class_block(class = "random", quiet = TRUE))
})

# Output testing
test_that("Outputs are as expected", {
  ## Rolling stats and adding class info
  my_block <- class_block(class = "paladin", quiet = TRUE)
  expect_equal(class(my_block), "data.frame")
  ## Using pre-rolled stats
  my_stats <- ability_scores(method = "4d6", quiet = TRUE)
  my_block <- class_block(class = "ranger", scores_rolled = TRUE,
                          scores_df = my_stats, quiet = TRUE)
  expect_equal(class(my_block), "data.frame")
})
