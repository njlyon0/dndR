#' @title Roll Any Number of Dice
#'
#' @description Rolls the specified number and type of dice. Dice are specified in the shorthand common to Dungeons & Dragons (i.e., number of dice, "d", number of faces of those dice). Includes an argument for whether each die's value should be returned as a message (rather than just the total of all dice in the roll). Rolling two twenty-sided dice (i.e., "2d20") is assumed to be rolling with advantage/disadvantage so both numbers are returned.
#'
#' @param dice (character) number and type of dice to roll specified in Dungeons & Dragons shorthand (e.g., "2d4" to roll two four-sided dice). Defaults to a single twenty-sided die (i.e., "1d20")
#' @param show_dice (logical) whether to print the values of each individual die included in the total. Defaults to FALSE
#'
#' @return (numeric) sum of specified dice outcomes
#'
#' @export
#'
#' @examples
#' # Roll your desired dice
#' roll(dice = "4d6", show_dice = TRUE)







# Working on a re-roll function


# Function variant ----

# Clear environment
rm(list = ls())

# Define function
reroll <- function(dice_type, first_result = NULL){

  # Identify number of sides (without "d")
  dice_faces <- base::as.numeric(base::gsub(pattern = "d", replacement = "", x = dice_type))

  # Count number of dice to re-roll
  reroll_ct <- base::sum(first_result == 1, na.rm = F)

  # Re-roll with the specified dice type
  new_vals <- base::sample(x = 1:dice_faces, size = reroll_ct, replace = TRUE)

  # Drop 1s in original result
  partial_result <- base::setdiff(x = first_result, y = 1)

  # Attach the new rolls to the old rolls without 1s
  full_vals <- c(partial_result, new_vals)

  # Return new results
  return(full_vals) }

# Invoke function
reroll(dice_type = "d8", first_result = c(1, 5, 3, 7, 1))


