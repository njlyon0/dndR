## ---------------------------------------------- ##
          # Automated Encounter Creation
## ---------------------------------------------- ##
# Script author(s): Nick Lyon

# PURPOSE
## Randomly select creatures to design an encounter of desired difficulty
## Lean on several related existing `dndR` functions under the hood

## --------------------------- ##
      # Housekeeping ----
## --------------------------- ##
# Load libraries
librarian::shelf(dndR, tidyverse, magrittr)

# Clear environment
rm(list = ls())

## --------------------------- ##
# Exploration ----
## --------------------------- ##

# Define draft function
encounter_creator <- function(party_level = 5, party_size = 4,
                              difficulty = "deadly", enemy_type = "undead"){

  # Load creature information
  dndR::creatures

  # If enemy type is null
  if(is.null(enemy_type) == TRUE){

    # Just simplify the creature data
    available <- creatures %>%
      dplyr::filter(creature_xp > 0 & !is.na(creature_xp)) %>%
      dplyr::select(creature_type, creature_name, creature_xp)

    # If enemy type is not null & is in the data
  } else if(is.null(enemy_type) != TRUE &
            any(stringr::str_detect(string = unique(creatures$creature_type),
                                    pattern = enemy_type)) == TRUE){

    # Simplify **and filter** the creature data
    available <- creatures %>%
      dplyr::filter(creature_xp > 0 & !is.na(creature_xp)) %>%
      dplyr::select(creature_type, creature_name, creature_xp) %>%
      dplyr::filter(stringr::str_detect(string = creature_type, pattern = enemy_type))

    # If enemy type is not null but isn't in the data
  } else if(is.null(enemy_type) != TRUE &
            any(stringr::str_detect(string = unique(creatures$creature_type),
                                    pattern = enemy_type)) == FALSE){

    # Warning message
    rlang::warn("Enemy type not found in data. Including all enemy types as possibilities")

    # Do same processing as when it isn't supplied
    available <- creatures %>%
      dplyr::filter(creature_xp > 0 & !is.na(creature_xp)) %>%
      dplyr::select(creature_type, creature_name, creature_xp)

  } # Close conditional

  # REST OF FUNCTION WILL GO HERE ----

  # Return available creatures
  return(available)

}

# Invoke it to get as far as it'll take us
available_df <- encounter_creator(enemy_type = "construct")

# Check that
str(available_df)

# Define other needed objects (will be arguments eventually)
party_level = 5
party_size = 4
difficulty = "deadly"

# Calculate maximum allowed XP for this encounter
(max_xp <- xp_pool(party_level = party_level, party_size = party_size,
                   difficulty = difficulty))

# Put a ceiling on that to be able to include more creatures
(capped_xp <- ceiling(x = max_xp - (0.4 * max_xp)))

# Pick the first creature of the encounter
picked <- available_df %>%
  # Choose highest possible XP that is still less than the capped XP
  dplyr::filter(creature_xp == max(creature_xp[creature_xp < capped_xp])) %>%
  # Pick one row of the result (if more than one)
  dplyr::slice_sample(.data = ., n = 1)

# Look at chosen creature
picked

# Calculate spent XP for this creature
(spent_xp <- xp_cost(monster_xp = sum(picked$creature_xp),
                     monster_count = nrow(picked),
                     party_size = party_size))

# Calculate remaining xp
(remaining_xp <- max_xp - spent_xp)

# Update set of available creatures
available_df %<>%
  # XP value less than (or equal to) remaining XP
  dplyr::filter(creature_xp <= remaining_xp)








# Compare to XP cost
current_cost <- xp_cost(monster_xp = sum(creature_pick$creature_xp),
                        monster_count = nrow(creature_pick),
                        party_size = pc_size)

# If that's less than the allowed, try to grab another
if(current_cost < (max_xp - min(creatures_avail$creature_xp))){

  # Calculate difference in XP
  remaining_xp <- max_xp - current_cost

  # Filter again
  creature_pick2 <- creatures_avail %>%
    dplyr::filter(creature_xp == max(creature_xp[creature_xp < remaining_xp], na.rm = TRUE))

  # If more than one, pick one at random
  if(nrow(creature_pick2) > 1){
    creature_pick2 <- creature_pick2[sample(x = 1:nrow(creature_pick2), size = 1), ]
  }

  # Check XP cost again
  attempt_cost <- xp_cost(monster_xp = sum(creature_pick$creature_xp,
                                           creature_pick2$creature_xp),
                          monster_count = length(c(creature_pick$creature_name,
                                                   creature_pick2$creature_name)),
                          party_size = pc_size)

  # If above allowed XP cost...
  if(attempt_cost > max_xp){

    # Information message
    message("Exceeding allowable XP cost of encounter")

    # # Drop creatures of this value of XP and try again with one tier lower
    # creatures_avail <- creatures_avail %>%
    #   dplyr::filter()
  }


}


# End ----
