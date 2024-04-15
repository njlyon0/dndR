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
# Function Var.
## ------------------------------ ##

# Define function
monster_text <- function(name = NULL){
  # Silence visible bindings note
  monster_name <- NULL

  # Read in spell dataframe
  all_monsters <- read.csv(file.path("dev", "tidy_data", "menagerie.csv"))

  # Perform the desired query
  focal_monster <- all_monsters %>%
    # Subset to only creatures where the name is an exact match
    dplyr::filter(tolower(monster_name) %in% tolower(name)) %>%
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
      category %in% c("STR", "DEX", "CON", "INT", "WIS", "CHA",
                      "cr", "xp") ~ paste0(toupper(category), ": ", info),
      # For others, do more customization
      category %in% c("speed", "size", "type", "skills",
                      "alignment", "languages"
                      ) ~ paste0(stringr::str_to_title(string = category), ": ", info),
      category == "armor_class" ~ paste0("AC: ", info),
      category == "hit_points" ~ paste0("HP: ", info),
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

  # If there is not a spell of that name print a message
  if(nrow(focal_monster) == 0){
    message("No monster(s) found matching that name; consider checking spelling")
    # Otherwise, return the spell's info
  } else { return(focal_monster) } }


# Invoke function
test <- monster_text(name = "hill giant")

test$info

# End ----
