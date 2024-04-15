## ---------------------------------------------------------- ##
              # List Creatures Based on Criteria
## ---------------------------------------------------------- ##
# Script author(s): Nick J Lyon

# PURPOSE
# Create monster equivalent of existing spell function
?dndR::spell_list

## ------------------------------ ##
        # Housekeeping ----
## ------------------------------ ##

# Load libraries
librarian::shelf(tidyverse, supportR)

# Clear environment
rm(list = ls())

# Load monster info
monster_info <- read.csv(file.path("dev", "tidy_data", "menagerie.csv"))

# Check structure
dplyr::glimpse(monster_info)

## ------------------------------ ##
# Script Var.
## ------------------------------ ##

# Want to search by:
## name
## size
## type
## XP / CR






## ------------------------------ ##
# Function Var.
## ------------------------------ ##




# End ----
