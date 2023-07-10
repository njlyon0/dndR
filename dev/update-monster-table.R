## ---------------------------------------- ##
          # Update Monster Table
## ---------------------------------------- ##
# Author(s): Nick Lyon

# PURPOSE:
## Update monster statistics table from DMG

## ---------------------------------------- ##
              # Housekeeping ----
## ---------------------------------------- ##

# Load libraries
librarian::shelf(tidyverse)

# Clear environment
rm(list = ls())

## ---------------------------------------- ##
                # Tidying ----
## ---------------------------------------- ##

# Read in data
monster_table_v1 <- read.csv(file = file.path("dev", "quick_monster_dmg.csv"))

# Check structure
dplyr::glimpse(monster_table_v1)

# Re-name more simply / wrangle if needed
monster_table <- monster_table_v1

## ---------------------------------------- ##
                # Export ----
## ---------------------------------------- ##

# Export locally to dev folder for experimental purposes
## Already ignored by package (because `dev` folder) and added to `.gitignore`
write.csv(x = monster_table, file = file.path("dev", "monster_table.csv"),
          row.names = F, na = '')

## If desired, export into package as a .rda object
# save(monster_table, file = file.path("data", "monster_table.rda"))


# End ----
