## ---------------------------------------------------------- ##
      # Retrieve Full Creature Text by Creature Name
## ---------------------------------------------------------- ##
# Script author(s): Nick J Lyon

# PURPOSE
# Create monster equivalent of existing spell function
?dndR::spell_text

## ------------------------------ ##
        # Housekeeping ----
## ------------------------------ ##
# Load libraries
librarian::shelf(tidyverse, supportR)

# Clear environment
rm(list = ls())

# Load monster info
monster_info <- read.csv(file.path("dev", "tidy_data", "menagerie.csv"))

## ------------------------------ ##
# Script Var.
## ------------------------------ ##




## ------------------------------ ##
# Function Var.
## ------------------------------ ##




# End ----
