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

# Needed helper functions
?dndR::xp_pool
?dndR::xp_cost
?dndR::creature_list
?dndR::creatures

## --------------------------- ##
# Scripted Exploration ----
## --------------------------- ##

# Define relevant objects
enc_type <- "undead"
pc_level <- 5
pc_size <- 4
enc_diff <- "medium"

# Subset available creatures to only those of desired 'type'
creature_sub <- dndR::creatures %>%
  # Drop all but needed columns
  dplyr::select(creature_type, creature_name, creature_xp) %>%
  dplyr::filter(stringr::str_detect(string = creature_type, pattern = enc_type))

# Check available XP manually
(max_xp <- xp_pool(party_level = pc_level, party_size = pc_size, difficulty = enc_diff) )

# Identify relevant creature(s)



# End ----
