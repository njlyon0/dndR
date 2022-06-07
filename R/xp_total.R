#' @title Calculate Total XP of Monsters for Given Party Level and Difficulty
#'
#' @description Returns the total XP (experience points) of all creatures that would make an encounter the specified level of difficulty for a party of the supplied level. This 'pool' can be used by a GM (game master) to "purchase" monsters to identify how many a party is likely to be able to handle given their average level. NOTE: this does not take into account creature-specific abilities or traits so care should be taken if a monster has many such traits that modify its difficulty beyond its experience point value.
#'
#' @param party_level a number indicating the average party level. If all players are the same level, that level is the average party level
#' @param party_size a number indicating how many player characters (PCs) are in the party
#' @param difficulty one of "easy", "medium", "hard", or "deadly" for the desired difficulty of the encounter.
#'
#' @return a number of total encounter XP
#' @export
#'
#' @examples
#' # Supply a party level and difficulty and get the total XP of such an encounter
#' xp_total(party_level = 3, party_size = 2, difficulty = 'medium')
#'
xp_total <- function(party_level = NULL, party_size = NULL, difficulty = NULL){

  # Error out if party_level or difficulty is unspecified
  if(base::is.null(party_level) | base::is.null(party_size) | base::is.null(difficulty)) stop("At least one parameter is unspecified. See `?dndR::xp_total()` for details.")

  if(base::is.numeric(party_level) != TRUE | base::is.numeric(party_size) != TRUE)
    stop("Party level and party size must be a number.")

  # Error out if too many party levels are provided
  if(base::length(party_level) > 1) stop("Too many values provided. What is the *average* level of PCs in the party?")

  # Error out if difficulty is not supported
  if(!base::tolower(difficulty) %in% c('easy', 'medium', 'hard', 'deadly'))
    stop("Unrecognized difficulty level. Please use only one of 'easy', 'medium', 'hard', or 'deadly'.")

  # Identify the quadratic coefficients
  ## (Nick did this manually and got a decent fit for the line)
  a <- 8.216374
  b <- -26.49122
  c <- 43.27485

  # Calculate XP value for adventurers of this level (for an easy encounter)
  base_xp_amount <- ( (a * (party_level^2)) + (b * party_level) + c )

  # The formula for the line isn't perfect so we have another quick modification to make
  if(party_level < 2) { easy_xp_amount <- base_xp_amount }
  if(party_level >= 2 & party_level < 12) { easy_xp_amount <- (base_xp_amount + 55) }
  if(party_level >= 12) { easy_xp_amount <- base_xp_amount }

  # Now multiply as needed for the desired difficulty (this is straight from the DMG's table)
  if(difficulty == "easy"){ single_xp_amount <- easy_xp_amount }
  if(difficulty == "medium"){ single_xp_amount <- (easy_xp_amount * 2) }
  if(difficulty == "hard"){ single_xp_amount <- (easy_xp_amount * 3) }
  if(difficulty == "deadly"){ single_xp_amount <- (easy_xp_amount * 4) }

  # Multiply that by the number of PCs in the party
  xp_amount <- (single_xp_amount * party_size)

  # And round that value to not return weird decimals
  xp_actual <- base::trunc(x = xp_amount)

  # Return the xp_amount
  return(xp_actual)
}

