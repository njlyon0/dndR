#' @title Create a Non-Player Character (NPC)
#'
#' @description Randomly generates a name for a user-specified number of Non-Player Characters (NPCs) as well as a species (a.k.a. "race" in 2014 rules) and a job. Shout out to Billy Mitchell for providing the work to include names for NPCs.
#' 
#' @param npc_count (numeric) number of NPCs for which to return names, species, and positions
#'
#' @return (dataframe) dataframe with three columns (one each for name, race, and job) and a number of rows equal to `npc_count`
#'
#' @export
#'
#' @examples
#' # Create some information for an NPC
#' dndR::npc_creator(npc_count = 1)
#'
npc_creator <- function(npc_count = 1){
  
  # NPC count must be a single number
  if(is.null(npc_count) || is.numeric(npc_count) != TRUE || length(npc_count) != 1 || npc_count < 1)
    stop("'npc_count' must be specified as a single, positive number")
  
  # Make sure count is an integer
  npc_count <- round(x = npc_count, digits = 0)
  
  # Make an empty list for storing outputs
  npc_list <- list()
  
  # Iterate across the number of NPCs
  for(k in 1:npc_count){
    
    # Pick a race
    npc_race <- sample(x = dndR::dnd_races(), size = 1)
    
    # Pick a job
    npc_job <- sample(x = c("acolyte", "adventurer", "ambassador", "anthropologist", "archaeologist", "artisan", "barber", "bounty hunter", "caravan driver", "caravan guard", "carpenter", "charlatan", "city watch", "criminal", "diplomat", "doctor", "farmer", "farrier", "entertainer", "gladiator", "hermit", "initiate", "inquisitor", "investigator", "knight", "mercenary", "merchant", "navigator", "noble", "outlander", "sage", "scholar", "smith", "soldier", "spy", "student of magic", "smuggler", "urchin", "veteran"),
                      size = 1)
    
    # Toss a coin
    flip <- dndR::coin()
    
    # Pick a first name from one of the ref functions
    if(flip == 1){
      npc_first <- sample(x = dndR::first_names_fem(), size = 1)
    } else {
      npc_first <- sample(x = dndR::first_names_masc(), size = 1)
    }
    
    # Pick a last name
    npc_last <- sample(x = dndR::surnames(), size = 1)
    
    # Assemble this information into a dataframe
    npc_list[[paste("npc_", k)]] <- data.frame("name" = paste(npc_first, npc_last),
                                               "species" = npc_race, 
                                               "job" = npc_job)
    
    
  } # Close the loop
  
  # Collapse list into a dataframe
  npc_df <- purrr::list_rbind(x = npc_list)
  
  # Return the data.frame
  return(npc_df) }
