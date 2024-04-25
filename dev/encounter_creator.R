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
librarian::shelf(tidyverse, dndR)

# Clear environment
rm(list = ls())

# Likely needed helper functions
# ?dndR::xp_pool
# ?dndR::xp_cost
# ?dndR::creature_list
# ?dndR::creatures

## --------------------------- ##
# Scripted Exploration ----
## --------------------------- ##

# Define relevant objects
enc_type <- "undead"
pc_level <- 5
pc_size <- 4
enc_diff <- "deadly"

# Subset available creatures to only those of desired 'type'
creatures_avail <- dndR::creatures %>%
  # Drop any creatures worth 0 XP or NA XP (latter should be none but we'll see)
  dplyr::filter(creature_xp > 0 & !is.na(creature_xp)) %>%
  # Drop all but needed columns
  dplyr::select(creature_type, creature_name, creature_xp) %>%
  dplyr::filter(stringr::str_detect(string = creature_type, pattern = enc_type))

# Check available XP manually
(max_xp <- xp_pool(party_level = pc_level, party_size = pc_size, difficulty = enc_diff) )

# Identify creature of the highest possible value still less than the max
creature_pick <- creatures_avail %>%
  dplyr::filter(creature_xp == max(creature_xp[creature_xp < max_xp], na.rm = TRUE))

# If more than one, pick one at random
if(nrow(creature_pick) > 1){
  creature_pick <- creature_pick[sample(x = 1:nrow(creature_pick), size = 1), ]
}

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


## --------------------------- ##
# Function Exploration ----
## --------------------------- ##

encounter_creator <- function(enemy_type = "undead", difficulty = "deadly",
                              party_level = 5, party_size = 4, balance = "tougher"){

  # If enemy type is null
  if(is.null(enemy_type) == TRUE){

    # Just simplify the creature data
    available <- dndR::creatures %>%
      dplyr::filter(creature_xp > 0 & !is.na(creature_xp)) %>%
      dplyr::select(creature_type, creature_name, creature_xp)

    # If enemy type is not null & is in the data
  } else if(is.null(enemy_type) != TRUE &
            stringr::str_detect(string = creature$creature_type,
                                pattern = enemy_type) == TRUE){

    # Simplify **and filter** the creature data
    available <- dndR::creatures %>%
      dplyr::filter(creature_xp > 0 & !is.na(creature_xp)) %>%
      dplyr::select(creature_type, creature_name, creature_xp) %>%
      dplyr::filter(stringr::str_detect(string = creature_type, pattern = enemy_type))

    # If enemy type is not null but isn't in the data
  } else if(is.null(enemy_type) != TRUE &
            stringr::str_detect(string = creature$creature_type,
                                pattern = enemy_type) == FALSE){

    # Warning message
    rlang::warn("Enemy type not found in data. Including all enemy types as possibilities")

    # Do same processing as when it isn't supplied
    available <- dndR::creatures %>%
      dplyr::filter(creature_xp > 0 & !is.na(creature_xp)) %>%
      dplyr::select(creature_type, creature_name, creature_xp)

  } # Close conditional



  # HERE NOW ----




  # Check available XP manually
  (max_xp <- xp_pool(party_level = pc_level, party_size = pc_size, difficulty = enc_diff) )

  # Identify creature of the highest possible value still less than the max
  creature_pick <- creatures_avail %>%
    dplyr::filter(creature_xp == max(creature_xp[creature_xp < max_xp], na.rm = TRUE))

  # If more than one, pick one at random
  if(nrow(creature_pick) > 1){
    creature_pick <- creature_pick[sample(x = 1:nrow(creature_pick), size = 1), ]
  }

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



}



# End ----
