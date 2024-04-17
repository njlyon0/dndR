## ---------------------------------------------------------- ##
      # Retrieve Full Creature Text by Creature Name
## ---------------------------------------------------------- ##
# Script author(s): Nick J Lyon

# PURPOSE
# Create creature equivalent of existing spell function
?dndR::spell_text

## ------------------------------ ##
        # Housekeeping ----
## ------------------------------ ##
# Load libraries
librarian::shelf(tidyverse, supportR)

# Clear environment
rm(list = ls())

# Load creature info
creature_info <- dndR::creatures

## ------------------------------ ##
# Function Var.
## ------------------------------ ##

# Define function
creature_text <- function(name = NULL){
  # Silence visible bindings note
  creature_name <- NULL

  # Read in spell dataframe
  all_creatures <- dndR::creatures

  # Perform the desired query
  focal_creature <- all_creatures %>%
    # Subset to only creatures where the name is an exact match
    dplyr::filter(tolower(creature_name) %in% tolower(name))

  # If there is not a creature of that name print a message
  if(nrow(focal_creature) == 0){
    message("No creature(s) found matching that name; consider checking spelling")

    # Otherwise...
  } else {

    # Do some tidying to make the output neater
    tidy_creature <- focal_creature %>%
      # Make all columns characters
      dplyr::mutate(dplyr::across(.cols = dplyr::everything(),
                                  .fns = as.character)) %>%
      # Flip it to long format
      tidyr::pivot_longer(cols = dplyr::everything(.),
                          names_to = "category", values_to = "info") %>%
      # Remove all empty rows that creates
      dplyr::filter(!is.na(info) & nchar(info) > 0) %>%
      # Make some entries more self-explanatory
      dplyr::mutate(info = dplyr::case_when(
        # Combine 'category' with 'info' for some entries
        category %in% c("STR", "DEX", "CON",
                        "INT", "WIS", "CHA") ~ paste0(category, ": ", info),
        # For others, do more customization
        category %in% c("speed", "skills", "languages"
        ) ~ paste0(stringr::str_to_title(string = category), ": ", info),
        category == "armor_class" ~ paste0("AC: ", info),
        category == "hit_points" ~ paste0("HP: ", info),
        category == "creature_cr" ~ paste0("CR: ", info),
        category == "creature_xp" ~ paste0("XP: ", info),
        category == "creature_source" ~ paste0("Source: ", info),
        category == "creature_size" ~ paste0("Size: ", info),
        category == "creature_type" ~ paste0("Type: ", info),
        category == "creature_alignment" ~ paste0("Alignment: ", info),
        category == "damage_immunities" ~ paste0("Damage Immunities:", info),
        category == "damage_resistances" ~ paste0("Damage Resistances:", info),
        category == "damage_vulnerabilities" ~ paste0("Damage Vulnerabilities:", info),
        category == "condition_immunities" ~ paste0("Condition Immunities: ", info),
        category == "saving_throws" ~ paste0("Saving Throws: ", info),
        # Otherwise just information is fine
        T ~ info)) %>%
      # Ditch category column altogether (now unneeded)
      dplyr::select(-category) %>%
      # Make it a dataframe
      as.data.frame()

    # Return that information
    return(tidy_creature) } }


# Invoke function
test <- creature_text(name = "hill giant")

test$info

# End ----
