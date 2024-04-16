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


monster_list <- function(name = NULL, size = NULL, type = NULL,
                         xp = NULL, cr = NULL){


  name <- c("giant", "goblin")
  size <- c("tiny", "gargantuan")
  type <- c("elemental", "undead")
  xp <- "10000"
  cr = c("0.125", "5")

  # Squelch visible bindings note


  # Read in monster data
  monster_v0 <- read.csv(file.path("dev", "tidy_data", "menagerie.csv")) %>%
    # Do some minor renaming to avoid overlap with arguments
    dplyr::rename(monster_size = size,
                  monster_type = type,
                  monster_xp = xp,
                  monster_cr = cr)

  # Filter by name if names are provided
  if(is.null(name) != TRUE){
    monster_v1 <- dplyr::filter(.data = monster_v0,
                                # More than one name given? Collapse into one string match pattern
                                grepl(pattern = ifelse(test = length(name) > 1,
                                                       yes = paste(name, collapse = "|"),
                                                       no = name),
                                      # Compare string(s) against monster names (case insensitive)
                                      x = monster_name, ignore.case = TRUE))
  } else { monster_v1 <- monster_v0 }

  # Filter by size if sizes are provided
  if(is.null(size) != TRUE){
    monster_v2 <- dplyr::filter(.data = monster_v1,
                                grepl(pattern = ifelse(test = length(size) > 1,
                                                       yes = paste(size, collapse = "|"),
                                                       no = size),
                                      x = size, ignore.case = TRUE))
  } else { monster_v2 <- monster_v1 }

  # Filter by level if levels are provided
  if(is.null(level) != TRUE){

    # If level isn't a character, make it so
    if(is.character(level) != TRUE) { level <- as.character(level) }

    # Do actual subsetting
    monster_v3 <- dplyr::filter(.data = monster_v2,
                                grepl(pattern = ifelse(test = length(level) > 1,
                                                       yes = paste(level, collapse = "|"),
                                                       no = level),
                                      x = monster_level, ignore.case = TRUE))
  } else { monster_v3 <- monster_v2 }

  # Filter by school if schools are provided
  if(is.null(school) != TRUE){
    monster_v4 <- dplyr::filter(.data = monster_v3,
                                grepl(pattern = ifelse(test = length(school) > 1,
                                                       yes = paste(school, collapse = "|"),
                                                       no = school),
                                      x = monster_school, ignore.case = TRUE))
  } else { monster_v4 <- monster_v3 }

  # Filter for/against ritual monsters if specified
  if(is.null(ritual) != TRUE){

    # Error out if ritual isn't logical
    if(is.logical(ritual) != TRUE)
      stop("`ritual` argument must be a `TRUE`, `FALSE`, or `NULL`")

    # Otherwise, use it to filter by
    monster_v5 <- dplyr::filter(.data = monster_v4, ritual_cast == ritual)
  } else { monster_v5 <- monster_v4 }

  # Filter by casting time
  if(is.null(cast_time) != TRUE){

    # Actually do initial filtering
    monster_v6a <- dplyr::filter(.data = monster_v5,
                                 grepl(pattern = ifelse(test = length(cast_time) > 1,
                                                        yes = paste(cast_time, collapse = "|"),
                                                        no = cast_time),
                                       x = casting_time, ignore.case = TRUE))

    # If reaction isn't specified by user, drop it
    ## Necessary because of partial string match of "action" with "reaction"
    if(!"reaction" %in% cast_time){
      monster_v6b <- dplyr::filter(.data = monster_v6a, grepl(pattern = "reaction", x = casting_time,
                                                              ignore.case = TRUE) == FALSE)
    } else { monster_v6b <- monster_v6a }

    # Ditto for bonus action
    ## Necessary because of partial string match of "action" with "bonus action"
    if(!"bonus action" %in% cast_time){
      monster_v6c <- dplyr::filter(.data = monster_v6b, grepl(pattern = "bonus action", x = casting_time,
                                                              ignore.case = TRUE) == FALSE)
    } else { monster_v6c <- monster_v6b }

  } else { monster_v6c <- monster_v5 } # Skip this mess if the argument isn't specified to begin with

  # If there are no monsters identified by those arguments...
  if(nrow(monster_v6c) == 0){
    # Return a message
    message("No monsters match these criteria; consider revising search")

    # Otherwise do some final wrangling
  } else {

    # Wrangle that object as needed before returning
    monster_actual <- monster_v6c %>%
      # Drop the description and higher_levels columns
      dplyr::select(-description, -higher_levels) %>%
      # Drop empty columns (none should exist but better safe than sorry)
      dplyr::select(dplyr::where(fn = ~ !( base::all(is.na(.)) | base::all(. == "")) ))

    # Return that object
    return(as.data.frame(monster_actual)) } }




# End ----
