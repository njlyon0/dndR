#' @title Roll Any Number of Dice
#'
#' @description Rolls the Specified Number and Type of Dice
#'
#' @param what a character specifying the number of dice and which type (e.g., "2d4" for two, four-sided dice). Defaults to a twenty-sided dice
#'
#'
#' @return Numeric, the sum of specified dice outcomes
#' @export

roll <- function(what = "d20"){

  # Identify number of dice to roll
  dice_count <- base::gsub(pattern = "d", replacement = "",
                           x = stringr::str_extract(string = what,
                                     pattern = "[:digit:]{1,10000000}d"))
  # If number is left blank, assume one but print warning
  if(base::nchar(dice_count) == 0 | is.na(dice_count)){
    base::message("Number of dice unspecified, assuming 1")
    dice_count <- 1
  }

  # Identify which dice type
  dice_type <- stringr::str_extract(string = what,
                                    pattern = "d[:digit:]{1,10000000}")

  # Error out if dice_type not of recognized type
  if(!dice_type %in% c("d2", "d4", "d6", "d8", "d10", "d12", "d20", "d100"))
    stop('Dice type not recognized')

  # Create empty list to store roll result
  dice_result <- base::list()

  # Roll the specified type of dice the specified number of times
  ## d2
  if(dice_type == "d2"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = dndR::d2())
    } }

  ## d4
  if(dice_type == "d4"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = dndR::d4())
    } }

  ## d6
  if(dice_type == "d6"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = dndR::d6())
    } }

  ## d8
  if(dice_type == "d8"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = dndR::d8())
    } }

  ## d10
  if(dice_type == "d10"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = dndR::d10())
    } }

  ## d12
  if(dice_type == "d12"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = dndR::d12())
    } }

  ## d20
  if(dice_type == "d20"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = dndR::d20())
    } }

  ## d100
  if(dice_type == "d100"){
    for(k in 1:dice_count){
      dice_result[[k]] <- base::data.frame('result' = dndR::d100())
    } }

  # Collapse list into dataframe
  dice_result_df <- purrr::map_dfr(.x = dice_result, .f = dplyr::bind_rows)

  # Calculate final sum
  total <- base::sum(dice_result_df$result, na.rm = TRUE)

  # Return total
  return(total) }

