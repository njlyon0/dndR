#' @title Create a Non-Player Character (NPC)
#'
#' @description Randomly selects a race and job for a user-specified number of NPCs
#'
#' @param npc_count (numeric) number of NPCs for which to choose race/positions
#'
#' @return (dataframe) dataframe with two columns (one for race and one for job) and a number of rows equal to `npc_count`
#'
#' @export
#'
#' @examples
#' # Create some information for an NPC
#' npc_creator(npc_count = 1)
#'
npc_creator <- function(npc_count = 1){

  # Error out if count isn't a number
  if(is.numeric(npc_count) != TRUE)
    stop("'npc_count' must be numeric")

  # Handle non-integer values
  if(is.integer(npc_count) != TRUE){
    npc_count <- ceiling(x = npc_count) }

  # Pick a race
  npc_race <- sample(x = dndR::dnd_races(), size = npc_count, replace = TRUE)

  # Pick a career
  npc_role <- sample(x = c("acolyte", "adventurer", "ambassador", "anthropologist", "archaeologist", "artisan", "barber", "bounty hunter", "caravan driver", "caravan guard", "carpenter", "charlatan", "city watch", "criminal", "diplomat", "doctor", "farmer", "farrier", "entertainer", "gladiator", "hermit", "initiate", "inquisitor", "investigator", "knight", "mercenary", "merchant", "navigator", "noble", "outlander", "sage", "scholar", "smith", "soldier", "spy", "student of magic", "smuggler", "urchin", "veteran"),
                     size = npc_count, replace = TRUE)

  # Assemble into named vector
  npc_info <- data.frame("Race" = npc_race, "Job" = npc_role)

  # Return the data.frame
  return(npc_info) }
