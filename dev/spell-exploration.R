## ---------------------------------------- ##
            # Spell Exploration
## ---------------------------------------- ##
# Author(s): Nick Lyon

# PURPOSE:
## Develop a function that allows users to query extant D&D spells based on various criteria
## `wizaRd` (github.com/oganm/wizaRd) has something similar but it is very list-y
## Ideally this will create something that is structurally similar to other `dndR` functions
### E.g., vectors / dataframes (I feel those are a little more accessible to R novices)

## ---------------------------------------- ##
            # Housekeeping ----
## ---------------------------------------- ##

# Load libraries
librarian::shelf(tidyverse, supportR, dndR)

# Clear environment
rm(list = ls())

# Identify spells in Grimoire (GitHub repo with markdown files of _ D&D spells)
spell_repo <- supportR::github_ls(repo = 'https://github.com/Traneptora/grimoire',
                                 folder = "_posts", recursive = F, quiet = F)

# Check structure
dplyr::glimpse(spell_repo)

# Strip out just markdown file names
spell_mds <- spell_repo$name

# Check that out
dplyr::glimpse(spell_mds)

## ---------------------------------------- ##
# Extract Spell Information ----
## ---------------------------------------- ##

# Read lines of the first spell's Markdown as a test
base::readLines(con = url(paste0("https://raw.githubusercontent.com/Traneptora/grimoire/master/_posts/", spell_mds[1])))

# Assign spell number as an object
k <- 1

# Wrangle the markdown information into something more manageable
spell_df <- base::readLines(con = url(paste0("https://raw.githubusercontent.com/Traneptora/grimoire/master/_posts/", spell_mds[k])))



# Check structure of that
dplyr::glimpse(spell_df)





# End ----

