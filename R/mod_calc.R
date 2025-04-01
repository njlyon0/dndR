#' @title Calculate Modifier for Specified Ability Score
#'
#' @description Ability scores (typically 0-20 for most creatures) relate to roll modifiers. These values are what a player or DM actually adds to a given skill or ability check. This function performs the simple calculation to identify the roll modifier that relates to the supplied ability score.
#'
#' @param score (numeric) ability score value for which to identify the roll modifier
#'
#' @return (character) roll modifier for a given ability score. If positive, includes a plus sign to make the addition explicit. Negative values are also returned as characters for consistency with positive modifiers
#'
#' @export
#'
#' @examples
#' # Calculate roll modifier for an ability score of 17
#' dndR::mod_calc(score = 17)
#'
mod_calc <- function(score = 10){

  # Score must be specified as a single number
  if(is.null(score) || is.numeric(score) != TRUE)
    stop("'score' must be defined as a numeric vector")
  
  # Calculate modifier from score
  mod_num <- base::floor(x = ((score - 10) / 2))

  # Add a plus if it's positive
  mod <- ifelse(test = mod_num >= 0,
                yes = paste0("+", mod_num),
                no = as.character(mod_num))

  # Return modifier
  return(mod) }
