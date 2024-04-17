## ---------------------------------------------------------- ##
              # List Creatures Based on Criteria
## ---------------------------------------------------------- ##
# Script author(s): Nick J Lyon

# PURPOSE
# Create creature equivalent of existing creature function
?dndR::spell_list

## ------------------------------ ##
        # Housekeeping ----
## ------------------------------ ##

# Load libraries
librarian::shelf(tidyverse, supportR, dndR)

# Clear environment
rm(list = ls())

## ------------------------------ ##
# Function Var.
## ------------------------------ ##
# Clear environment
rm(list = ls())

# Define function
creature_list <- function(name = NULL, size = NULL, type = NULL,
                         source = NULL, xp = NULL, cr = NULL){
  # Squelch visible bindings note


  # Read in creature data
  creature_v0 <- dndR::creatures

  # Filter by name if names are provided
  if(is.null(name) != TRUE){

    # More than one name given? Collapse into one string match pattern
    name_query <- ifelse(test = length(name) > 1,
                         yes = paste(name, collapse = "|"),
                         no = name)

    # Filter to just those that match (case in-sensitive)
    creature_v1 <- creature_v0 %>%
      dplyr::filter(grepl(pattern = name_query, x = creature_name, ignore.case = TRUE))

    # If not provided, just pass to next object name
  } else { creature_v1 <- creature_v0 }

  # Filter by size if sizes are provided
  if(is.null(size) != TRUE){
    size_query <- ifelse(test = length(size) > 1,
                         yes = paste(size, collapse = "|"),
                         no = size)
    creature_v2 <- creature_v1 %>%
      dplyr::filter(grepl(pattern = size_query, x = creature_size, ignore.case = TRUE))
  } else { creature_v2 <- creature_v1 }

  # Filter by type if types are provided
  if(is.null(type) != TRUE){
    type_query <- ifelse(test = length(type) > 1,
                         yes = paste(type, collapse = "|"),
                         no = type)
    creature_v3 <- creature_v2 %>%
      dplyr::filter(grepl(pattern = type_query, x = creature_type, ignore.case = TRUE))
  } else { creature_v3 <- creature_v2 }

  # Filter by CR if CRs are provided
  if(is.null(cr) != TRUE){
    # Handle fraction CRs
    cr <- gsub(pattern = "1/8", replacement = 1/8, x = cr)
    cr <- gsub(pattern = "1/4", replacement = 1/4, x = cr)
    cr <- gsub(pattern = "1/2", replacement = 1/2, x = cr)

    # Query the creature table
    creature_v4 <- dplyr::filter(.data = creature_v3, creature_cr %in% cr)
  } else { creature_v4 <- creature_v3 }

  # Filter by XP if XPs are provided
  if(is.null(xp) != TRUE){
    # Query the creature table
    creature_v5 <- dplyr::filter(.data = creature_v4, creature_xp %in% xp)
  } else { creature_v5 <- creature_v4 }

  # Filter by source if sources are provided
  if(is.null(source) != TRUE){
    # Remove apostrophes from source entry
    source <- gsub(pattern = "'", replacement = "", x = source)

    # Collapse multiple entries
    source_query <- ifelse(test = length(source) > 1,
                           yes = paste(source, collapse = "|"),
                           no = source)

    # Query
    creature_v6 <- creature_v5 %>%
      dplyr::filter(grepl(pattern = source_query, x = creature_source, ignore.case = TRUE))
  } else { creature_v6 <- creature_v5 }

  # If no creatures meet these criteria...
  if(nrow(creature_v6) == 0){

    # Return a message
    message("No creatures match these criteria; consider revising search")

    # Otherwise...
  } else {

    # Do some final processing
    creature_actual <- creature_v6 %>%
      # Drop all action/ability information
      dplyr::select(-dplyr::starts_with("ability_"), -dplyr::starts_with("action_")) %>%
      # Drop any empty columns in this query
      dplyr::select(dplyr::where(fn = ~ !( base::all(is.na(.)) | base::all(. == "")) )) %>%
      # Make it a dataframe
      as.data.frame()

    # Return that
    return(creature_actual) } }

# Invoke function
creature_list(name = c("giant", "goblin")) %>% nrow()
creature_list(size = c("tiny", "gargantuan")) %>% nrow()
creature_list(type = c("elemental", "undead")) %>% nrow()
unique(creature_list(source = c("creature manual", "v'o'l'o's guide", "strahd"))$creature_source)
creature_list(xp = c("100", "10000")) %>% nrow()
creature_list(cr = c("0.125", "5")) %>% nrow()



creature_list(name = "giant", size = "tiny")





# End ----
