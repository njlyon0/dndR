#' @title Roll Any Number of Dice
#'
#' @description Rolls the specified number and type of dice. Dice are specified in the shorthand common to Dungeons & Dragons (i.e., number of dice, "d", number of faces of those dice). Includes an argument for whether each die's value should be returned as a message (rather than just the total of all dice in the roll). Rolling two twenty-sided dice (i.e., "2d20") is assumed to be rolling with advantage/disadvantage so both numbers are returned.
#'
#' @param dice (character) number and type of dice to roll specified in Dungeons & Dragons shorthand (e.g., "2d4" to roll two four-sided dice). Defaults to a single twenty-sided die (i.e., "1d20")
#' @param show_dice (logical) whether to print the values of each individual die included in the total. Defaults to FALSE
#' @param re_roll (logical) whether to re-roll 1s from the initial roll result. Defaults to FALSE
#'
#' @return (numeric) sum of specified dice outcomes
#'
#' @export
#'
#' @examples
#' # Roll your desired dice
#' dndR::roll(dice = "4d6", show_dice = TRUE)
#'
#' # Returned as a number so you can add rolls together or integers
#' dndR::roll(dice = '1d20') + 5
#'
#' # Can also re-roll ones if desired
#' dndR::roll(dice = '4d4', re_roll = TRUE)
#'
roll <- function(dice = "d20", show_dice = FALSE, re_roll = FALSE){

  # Dice must be provided as a single character
  if(is.null(dice) || is.character(dice) != TRUE || length(dice) != 1 || stringr::str_detect(string = dice, pattern = "d") != TRUE)
    stop("'dice' must be specified as a character with a lowercase 'd' between the number of dice and the number of sides of that die type (e.g., '3d8')")
  
  # Warn and coerce to default if logical arguments are not correct
  ## 'show_dice'
  if(is.logical(show_dice) != TRUE){
    warning("'show_dice' must be a logical. Coercing to FALSE")
    show_dice <- FALSE }
  ## 'reroll'
  if(is.logical(re_roll) != TRUE){
    warning("'re_roll' must be a logical. Coercing to FALSE")
    re_roll <- FALSE }

  # Identify number of dice to roll
  dice_count <- base::gsub(pattern = "d", replacement = "",
                           x = stringr::str_extract(string = dice,
                                     pattern = "[:digit:]{1,10000000}d"))

  # If number is left blank, assume one but print warning
  if(nchar(dice_count) == 0 | is.na(dice_count)){
    message("Number of dice unspecified, assuming 1")
    dice_count <- 1 }

  # Identify which dice type
  dice_type <- stringr::str_extract(string = dice, pattern = "d[:digit:]{1,3}")

  # Identify number of dice faces (i.e., drop "d")
  dice_faces <- as.numeric(gsub(pattern = "d", replacement = "", x = dice_type))

  # Roll the specified type of dice the specified number of times
  results <- sample(x = 1:dice_faces, size = dice_count, replace = TRUE)

  # If re-rolling is desired, do so here
  if(re_roll == TRUE & 1 %in% results){
    results <- dndR::reroll(dice_faces = dice_faces, first_result = results)
    message("Re-rolling 1s") }

  # Calculate final sum
  total <- base::sum(results, na.rm = TRUE)

  # If two d20 are rolled, assume they're rolling for advantage/disadvantage and don't sum
  if(dice == "2d20"){
    total <- base::data.frame('roll_1' = results[1], 'roll_2' = results[2])
    message("Assuming you're rolling for (dis)advantage so both rolls returned") }

  # If desired (and necessary), message the individual roll values
  if(show_dice == TRUE & dice_count > 1 & dice != "2d20"){
    message("Individual rolls: ", paste(results, collapse = ", ")) }

  # Return total
  return(total) }
