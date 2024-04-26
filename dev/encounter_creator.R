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

  # Define the minimum allowed XP value of a creature
  weakest_xp <- 10

  # If enemy type is null
  if(is.null(enemy_type) == TRUE){

    # Just simplify the creature data
    available <- creatures %>%
      dplyr::filter(creature_xp > weakest_xp & !is.na(creature_xp)) %>%
      dplyr::select(creature_type, creature_name, creature_xp)

    # If enemy type is not null & is in the data
  } else if(is.null(enemy_type) != TRUE &
            any(stringr::str_detect(string = unique(creatures$creature_type),
                                    pattern = enemy_type)) == TRUE){

    # Simplify **and filter** the creature data
    available <- creatures %>%
      dplyr::filter(creature_xp > weakest_xp & !is.na(creature_xp)) %>%
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
      dplyr::filter(creature_xp > weakest_xp & !is.na(creature_xp)) %>%
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
party_level = 6
party_size = 4
difficulty = "deadly"

# Calculate maximum allowed XP for this encounter
(max_xp <- xp_pool(party_level = party_level, party_size = party_size,
                   difficulty = difficulty))

# Put a ceiling on that to be able to include more creatures
(capped_xp <- ceiling(x = max_xp - (max_xp * 0.65)))

# Pick the first creature of the encounter
(picked <- available_df %>%
  # Choose highest possible XP that is still less than the capped XP
  dplyr::filter(creature_xp == max(creature_xp[creature_xp < capped_xp])) %>%
  # Pick one row of the result (if more than one)
  dplyr::slice_sample(.data = ., n = 1))

# Calculate spent XP for this creature
(spent_xp <- xp_cost(monster_xp = sum(picked$creature_xp),
                     monster_count = nrow(picked),
                     party_size = party_size))

# Calculate remaining xp
(remaining_xp <- max_xp - spent_xp)

# Update set of available creatures
available_df %<>%
  # XP value less than (or equal to) remaining XP
  dplyr::filter(creature_xp <= remaining_xp &
                  creature_xp < max(picked$creature_xp))

# Identify XP levels of available creatures
xp_levels <- unique(available_df$creature_xp)

# Loop across available XPs
for(xp_value in sample(x = xp_levels, size = length(xp_levels))){

  # Progress message
  message("Evaluating creatures worth ", xp_value, " XP")

  # See if including a creature of that XP is still below the threshold
  (possible_cost <- xp_cost(monster_xp = sum(c(picked$creature_xp, xp_value)),
                            monster_count = nrow(picked) + 1,
                            party_size = party_size))

  # If a creature of this value exceeds our available XP, drop it!
  if(possible_cost > max_xp){

    message("Too costly!")

    available_df %<>%
      dplyr::filter(creature_xp < xp_value)

    # If it doesn't push it over the limit, accept one creature of this value
  } else {

    message("Acceptable!")

    candidate <- available_df %>%
      dplyr::filter(creature_xp == xp_value) %>%
      dplyr::slice_sample(.data = ., n = 1)

    picked <- picked %>%
      dplyr::bind_rows(candidate)

  }

}

picked

## --------------------------- ##
# `while` Testing ----
## --------------------------- ##

# Clear environment
rm(list = ls())

# Define draft function
encounter_creator <- function(party_level = 5, party_size = 4,
                              difficulty = "deadly", enemy_type = "undead"){

  # Load creature information
  dndR::creatures

  # Define the minimum allowed XP value of a creature
  weakest_xp <- 10

  # If enemy type is null
  if(is.null(enemy_type) == TRUE){

    # Just simplify the creature data
    available <- creatures %>%
      dplyr::filter(creature_xp > weakest_xp & !is.na(creature_xp)) %>%
      dplyr::select(creature_type, creature_name, creature_xp)

    # If enemy type is not null & is in the data
  } else if(is.null(enemy_type) != TRUE &
            any(stringr::str_detect(string = unique(creatures$creature_type),
                                    pattern = enemy_type)) == TRUE){

    # Simplify **and filter** the creature data
    available <- creatures %>%
      dplyr::filter(creature_xp > weakest_xp & !is.na(creature_xp)) %>%
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
      dplyr::filter(creature_xp > weakest_xp & !is.na(creature_xp)) %>%
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
party_level = 6
party_size = 4
difficulty = "deadly"

# Calculate maximum allowed XP for this encounter
(max_xp <- xp_pool(party_level = party_level, party_size = party_size,
                   difficulty = difficulty))

# Put a ceiling on that to be able to include more creatures
(capped_xp <- ceiling(x = max_xp - (max_xp * 0.65)))

# Pick the first creature of the encounter
(picked <- available_df %>%
    # Choose highest possible XP that is still less than the capped XP
    dplyr::filter(creature_xp == max(creature_xp[creature_xp < capped_xp])) %>%
    # Pick one row of the result (if more than one)
    dplyr::slice_sample(.data = ., n = 1))

# Calculate spent XP for this creature
(spent_xp <- xp_cost(monster_xp = sum(picked$creature_xp),
                     monster_count = nrow(picked),
                     party_size = party_size))

# Calculate remaining xp
(remaining_xp <- max_xp - spent_xp)

# Update set of available creatures
available_df %<>%
  # XP value less than (or equal to) remaining XP
  dplyr::filter(creature_xp <= remaining_xp &
                  creature_xp < max(picked$creature_xp))

# Identify XP levels of available creatures
xp_levels <- unique(available_df$creature_xp)

# While there is XP to spend and creatures to spend it on, do so
while(spent_xp < max_xp & nrow(available_df) >= 1){

  # Pick a random XP value
  xp_value <- sample(x = xp_levels, size = 1)

  # Progress message
  message("Evaluating creatures worth ", xp_value, " XP")

  # See if including a creature of that XP is still below the threshold
  (possible_cost <- xp_cost(monster_xp = sum(c(picked$creature_xp, xp_value)),
                            monster_count = nrow(picked) + 1,
                            party_size = party_size))

  # If this would be below the maximum allowed XP...
  if(possible_cost < max_xp){

    # Choose one candidate creature
    candidate <- available_df %>%
      dplyr::filter(creature_xp == xp_value) %>%
      dplyr::slice_sample(.data = ., n = 1)

    # Add this to the picked set of creatures
    picked <- dplyr::bind_rows(candidate)

    # If this would be *over* the allowed XP...
  } else {

    # Remove all creatures of this value from the set of available creatures
    available_df %<>%
      dplyr::filter(creature_xp != xp_value)

    }

} # Close while loop

picked


# End ----
