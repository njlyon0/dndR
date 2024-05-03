# Run all tests in this script:
## testthat::test_file(file.path("tests", "testthat", "test-party_diagram.R"))

# Error testing
test_that("Errors work as desired", {
  expect_error(party_diagram(by = "nothing"))
})

# Warning testing
test_that("Warnings work as desired", {
  ## Malformed logical
  party_list <- list(Vax = list(STR = "10", DEX = "13", CON = "14",
                                INT = "15", WIS = "16", CHA = "12"),
                     Beldra = list(STR = "20", DEX = "15", CON = "10",
                                   INT = "10", WIS = "11", CHA = "12"),
                     Rook = list(STR = "10", DEX = "10", CON = "18",
                                 INT = "9", WIS = "11", CHA = "16"))
  expect_warning(party_diagram(by = "player", pc_stats = party_list, quiet = "false"))
})

# # Message testing
# test_that("Messages work as desired", {
#   # No messages in this function
# })

# Output testing
test_that("Outputs are as expected", {
  party_list <- list(Vax = list(STR = "10", DEX = "13", CON = "14",
                                INT = "15", WIS = "16", CHA = "12"),
                     Beldra = list(STR = "20", DEX = "15", CON = "10",
                                   INT = "10", WIS = "11", CHA = "12"),
                     Rook = list(STR = "10", DEX = "10", CON = "18",
                                 INT = "9", WIS = "11", CHA = "16"))
  party_plot <- party_diagram(by = "player", pc_stats = party_list, quiet = TRUE)
  expect_equal(class(party_plot), c("gg", "ggplot"))
})
