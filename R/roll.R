#' @title Roll Any Number of Dice
#'
#' @description Rolls the specified number and type of dice. Dice are specified in the shorthand common to Dungeons & Dragons (i.e., number of dice, "d", number of faces of those dice). Includes an argument for whether each die's value should be returned as a message (rather than just the total of all dice in the roll). Rolling two twenty-sided dice (i.e., "2d20") is assumed to be rolling with advantage/disadvantage so both numbers are returned.
#'
#' @param dice (character) specifying the number of dice and which type (e.g., "2d4" for two, four-sided dice). Defaults to a single twenty-sided die
#' @param show_dice (logical) whether to print the values of each individual die included in the total. Defaults to FALSE
#'
#' @return (numeric) sum of specified dice outcomes
#'
#' @export
#'
#' @examples
#' # Roll your desired dice (i.e., randomly sample the specified die)
#' roll(dice = "4d6")
#'
#' # Returned as a number so you can add rolls together or integers
#' roll('1d20') + 5
#' roll('2d8') + roll('1d4')
#'
roll <- function(dice = "d20", show_dice = FALSE){

  # Error out if not a character
  if(!is.character(dice))
    stop("`dice` must be specified as a character (e.g., '3d8')")

  # Identify number of dice to roll
  dice_count <- base::gsub(pattern = "d", replacement = "",
                           x = stringr::str_extract(string = dice,
                                     pattern = "[:digit:]{1,10000000}d"))

  # If number is left blank, assume one but print warning
  if(base::nchar(dice_count) == 0 | is.na(dice_count)){
    base::message("Number of dice unspecified, assuming 1")
    dice_count <- 1 }

  # Identify which dice type
  dice_type <- stringr::str_extract(string = dice,
                                    pattern = "d[:digit:]{1,3}")

  # Error out if dice_type not of recognized type
  if(!dice_type %in% c("d2", "d3", "d4", "d6", "d8", "d10", "d12", "d20", "d100"))
    stop('Dice type not recognized')

  # Create empty list to store roll result
  dice_result <- base::list()

  # Roll the specified type of dice the specified number of times
  ## d2
  if(dice_type == "d2"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = d2())
    } }

  ## d3
  if(dice_type == "d3"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = d3())
    } }

  ## d4
  if(dice_type == "d4"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = d4())
    } }

  ## d6
  if(dice_type == "d6"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = d6())
    } }

  ## d8
  if(dice_type == "d8"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = d8())
    } }

  ## d10
  if(dice_type == "d10"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = d10())
    } }

  ## d12
  if(dice_type == "d12"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = d12())
    } }

  ## d20
  if(dice_type == "d20" & dice_count != 2){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = d20())
    } }

  ## d100
  if(dice_type == "d100"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = d100())
    } }

  # Collapse list into dataframe
  dice_result_df <- purrr::list_rbind(x = dice_result)

  # Calculate final sum
  total <- base::sum(dice_result_df$result, na.rm = TRUE)

  # If two d20 are rolled, assume they're rolling for advantage/disadvantage and don't sum
  if(dice_type == "d20" & dice_count == 2){
    total <- base::data.frame('roll_1' = d20(), 'roll_2' = d20())
    base::message("Assuming you're rolling for (dis)advantage so both rolls returned") }

  # If desired (and necessary), message the individual roll values
  if(show_dice == TRUE & dice_count > 1 & dice != "2d20"){
    base::message("Individual rolls: ", paste(dice_result_df$result, collapse = ", ")) }

  # Return total
  return(total) }
