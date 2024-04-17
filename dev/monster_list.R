## ---------------------------------------------------------- ##
              # List Creatures Based on Criteria
## ---------------------------------------------------------- ##
# Script author(s): Nick J Lyon

# PURPOSE
# Create monster equivalent of existing monster function
?dndR::spell_list

## ------------------------------ ##
        # Housekeeping ----
## ------------------------------ ##

# Load libraries
librarian::shelf(tidyverse, supportR, dndR)

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
name <- c("giant", "goblin")
size <- c("tiny", "gargantuan")
type <- c("elemental", "undead")
source <- c("monster manual", "volos guide", "strahd")
xp <- "10000"
cr = c("0.125", "5")


# Search for just one
monster_test <- monster_info %>%
  # More than one name given? Collapse into one string match pattern
  dplyr::filter(grepl(pattern = ifelse(test = length(name) > 1,
                                       yes = paste(name, collapse = "|"),
                                       no = name),
                      # Compare string(s) against monster names (case insensitive)
                      x = monster_name, ignore.case = TRUE))


monster_test$monster_name






## ------------------------------ ##
# Function Var.
## ------------------------------ ##
# Clear environment
rm(list = ls())

# Define function
monster_list <- function(name = NULL, size = NULL, type = NULL,
                         source = NULL, xp = NULL, cr = NULL){
  # Squelch visible bindings note


  # Read in monster data
  monster_v0 <- read.csv(file.path("dev", "tidy_data", "menagerie.csv"))

  # Filter by name if names are provided
  if(is.null(name) != TRUE){

    # More than one name given? Collapse into one string match pattern
    name_query <- ifelse(test = length(name) > 1,
                         yes = paste(name, collapse = "|"),
                         no = name)

    # Filter to just those that match (case in-sensitive)
    monster_v1 <- monster_v0 %>%
      dplyr::filter(grepl(pattern = name_query, x = monster_name, ignore.case = TRUE))

    # If not provided, just pass to next object name
  } else { monster_v1 <- monster_v0 }

  # Filter by size if sizes are provided
  if(is.null(size) != TRUE){
    size_query <- ifelse(test = length(size) > 1,
                         yes = paste(size, collapse = "|"),
                         no = size)
    monster_v2 <- monster_v1 %>%
      dplyr::filter(grepl(pattern = size_query, x = monster_size, ignore.case = TRUE))
  } else { monster_v2 <- monster_v1 }

  # Filter by type if types are provided
  if(is.null(type) != TRUE){
    type_query <- ifelse(test = length(type) > 1,
                         yes = paste(type, collapse = "|"),
                         no = type)
    monster_v3 <- monster_v2 %>%
      dplyr::filter(grepl(pattern = type_query, x = monster_type, ignore.case = TRUE))
  } else { monster_v3 <- monster_v2 }

  # Filter by CR if CRs are provided
  if(is.null(cr) != TRUE){
    # Handle fraction CRs
    cr <- gsub(pattern = "1/8", replacement = 1/8, x = cr)
    cr <- gsub(pattern = "1/4", replacement = 1/4, x = cr)
    cr <- gsub(pattern = "1/2", replacement = 1/2, x = cr)

    # Query the monster table
    monster_v4 <- dplyr::filter(.data = monster_v3, monster_cr %in% cr)
  } else { monster_v4 <- monster_v3 }

  # Filter by XP if XPs are provided
  if(is.null(xp) != TRUE){
    # Query the monster table
    monster_v5 <- dplyr::filter(.data = monster_v4, monster_xp %in% xp)
  } else { monster_v5 <- monster_v4 }

  # Filter by source if sources are provided
  if(is.null(source) != TRUE){
    # Remove apostrophes from source entry
    source <- gsub(pattern = "'", replacement = "", x = source)

    # Collapse multiple entries
    source_query <- ifelse(test = length(source) > 1,
                           yes = paste(source, collapse = "|"),
                           no = source)

    # Query
    monster_v6 <- monster_v5 %>%
      dplyr::filter(grepl(pattern = source_query, x = monster_source, ignore.case = TRUE))
  } else { monster_v6 <- monster_v5 }

  # If no monsters meet these criteria...
  if(nrow(monster_v6) == 0){

    # Return a message
    message("No monsters match these criteria; consider revising search")

    # Otherwise...
  } else {

    # Do some final processing
    monster_actual <- monster_v6 %>%
      # Drop all action/ability information
      dplyr::select(-dplyr::starts_with("ability_"), -dplyr::starts_with("action_")) %>%
      # Drop any empty columns in this query
      dplyr::select(dplyr::where(fn = ~ !( base::all(is.na(.)) | base::all(. == "")) )) %>%
      # Make it a dataframe
      as.data.frame()

    # Return that
    return(monster_actual) } }

# Invoke function
monster_list(name = c("giant", "goblin")) %>% nrow()
monster_list(size = c("tiny", "gargantuan")) %>% nrow()
monster_list(type = c("elemental", "undead")) %>% nrow()
unique(monster_list(source = c("monster manual", "v'o'l'o's guide", "strahd"))$monster_source)
monster_list(xp = c("100", "10000")) %>% nrow()
monster_list(cr = c("0.125", "5")) %>% nrow()



monster_list(name = "giant", size = "tiny")





# End ----
