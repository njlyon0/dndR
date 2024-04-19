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



# End ----
