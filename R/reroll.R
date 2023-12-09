#' @title Re-Roll 1s from a Prior Dice Roll
#'
#' @description Re-rolls only the dice that "landed on" 1 from a prior use of `roll`. Retains other dice results from the first roll but replaces the ones.
#'
#' @param dice_faces (numeric) number of faces on the die/dice to re-roll
#' @param first_result (numeric) vector of original dice results (including 1s to reroll)
#'
#' @return (numeric) vector of non-1 original dice results with re-rolled dice results appended
#'
#' @export
#'
#' @examples
#' # Re-roll ones from a prior result
#' reroll(dice_faces = 8, first_result = c(1, 3, 1))
#'
reroll <- function(dice_faces, first_result = NULL){

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
