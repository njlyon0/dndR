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

# Make an empty list to store individually-wrangled spells within
list_o_spells <- list()

# Loop across spell markdown files
for(k in 1:length(spell_mds)){

  # Define that spell's markdown URL
  spell_con <- base::url(paste0("https://raw.githubusercontent.com/Traneptora/grimoire/master/_posts/", spell_mds[k]))

  # Strip out spell information as a vector
  spell_info <- base::readLines(con = spell_con)

  # Close the connection
  base::close(spell_con)

  # Wrangle the markdown information into something more manageable & add to spell list
  list_o_spells[[k]] <- as.data.frame(spell_info) %>%
    # Drop irrelevant lines
    dplyr::filter(nchar(spell_info) != 0 & spell_info != "---") %>%
    # Add a column of what the true column names should be
    dplyr::mutate(names = c("layout", "title", "date", "sources", "tags", "type",
                            "casting_time", "range", "components", "duration",
                            paste0("description_", 1:(nrow(.)-10)))) %>%
    # Pivot wider
    tidyr::pivot_wider(names_from = names, values_from = spell_info) %>%
    # Wrangle spell name
    dplyr::mutate(name = gsub(pattern = "title:  |title: |\"", replacement = "", x = title),
                  .before = title) %>%
    # Drop title column
    dplyr::select(-title)

  # Message successful wrangling
  message("Finished wrangling spell ", k, " '", list_o_spells[[k]]$name, "'") }

# Perform further wrangling
spell_df <- list_o_spells %>%
  # Unlist that list into a dataframe
  purrr::list_rbind() %>%
  # Remove unwanted columns
  dplyr::select(-layout, -date)

# Check structure of that
dplyr::glimpse(spell_df)
## view(spell_df)



# End ----

