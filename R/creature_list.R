#' @title List Creatures Based on Criteria
#'
#' @description Query list of fifth edition Dungeons & Dragons creatures (2014 version) based on partial string matches between user inputs and the relevant column of the creature information data table. Currently supports users querying the creature list by creature name, size, type, source document, experience point (XP), and challenge rating (CR). All characters arguments are case-insensitive. XP and CR may be specified as either characters or numbers but match to creature must be exact in either case (rather than partial). Any argument set to `NULL` (the default) will not be used to include/exclude creatures from the returned set of creatures
#'
#' @param name (character) text to look for in creature names
#' @param size (character) size(s) of creature
#' @param type (character) creature 'type' (e.g., "undead", "elemental", etc.)
#' @param source (character) source book/document of creature
#' @param xp (character/numeric) experience point (XP) value of creature (note this must be an exact match as opposed to partial matches tolerated by other arguments)
#' @param cr (character/numeric) challenge rating (CR) value of creature (note this must be an exact match as opposed to partial matches tolerated by other arguments)
#' @param ver (character) which version of fifth edition to use ("2014" or "2024"). Note that only 2014 is supported and entering "2024" will print a warning to that effect
#'
#' @return (dataframe) Up to 23 columns of information with one row per creature(s) that fit(s) the user-specified criteria. Fewer columns are returned when no creatures that fit the criteria have information for a particular category (e.g., if no queried creatures have damage vulnerabilities, that column will be excluded from the results). If no creatures fit the criteria, returns a message to that effect instead of a data object
#' 
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' # Identify medium undead creatures from the Monster Manual worth 450 XP
#' dndR::creature_list(type = "undead", size = "medium", source = "monster manual", xp = 450)
#' 
creature_list <- function(name = NULL, size = NULL, type = NULL,
                          source = NULL, xp = NULL, cr = NULL,
                          ver = "2014"){
  # Squelch visible bindings note
  creature_name <- creature_size <- creature_type <- NULL
  creature_source <- creature_xp <- creature_cr <- NULL
  
  # Return warning if version is not 2014
  if(as.character(ver) %in% c("2014", "14") != TRUE){
    warning("This function only supports content from the 2014 edition")
  }
  
  # Read in creature data
  creature_v0 <- dndR::creatures
  
  # Filter by name if names are provided
  if(is.null(name) != TRUE){
    
    # More than one name given? Collapse into one string match pattern
    name_query <- base::ifelse(test = length(name) > 1,
                               yes = paste(name, collapse = "|"),
                               no = name)
    
    # Filter to just those that match (case in-sensitive)
    creature_v1 <- creature_v0 %>%
      dplyr::filter(grepl(pattern = name_query, x = creature_name, ignore.case = TRUE))
    
    # If not provided, just pass to next object name
  } else { creature_v1 <- creature_v0 }
  
  # Filter by size if sizes are provided
  if(is.null(size) != TRUE){
    size_query <- base::ifelse(test = length(size) > 1,
                               yes = paste(size, collapse = "|"),
                               no = size)
    creature_v2 <- creature_v1 %>%
      dplyr::filter(grepl(pattern = size_query, x = creature_size, ignore.case = TRUE))
  } else { creature_v2 <- creature_v1 }
  
  # Filter by type if types are provided
  if(is.null(type) != TRUE){
    type_query <- base::ifelse(test = length(type) > 1,
                               yes = paste(type, collapse = "|"),
                               no = type)
    creature_v3 <- creature_v2 %>%
      dplyr::filter(grepl(pattern = type_query, x = creature_type, ignore.case = TRUE))
  } else { creature_v3 <- creature_v2 }
  
  # Filter by CR if CRs are provided
  if(is.null(cr) != TRUE){
    # Handle fraction CRs
    cr <- base::gsub(pattern = "1/8", replacement = 1/8, x = cr)
    cr <- base::gsub(pattern = "1/4", replacement = 1/4, x = cr)
    cr <- base::gsub(pattern = "1/2", replacement = 1/2, x = cr)
    
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
    source <- base::gsub(pattern = "'", replacement = "", x = source)
    
    # Collapse multiple entries
    source_query <- base::ifelse(test = length(source) > 1,
                                 yes = paste(source, collapse = "|"),
                                 no = source)
    
    # Query
    creature_v6 <- creature_v5 %>%
      dplyr::filter(grepl(pattern = source_query, x = creature_source, ignore.case = TRUE))
  } else { creature_v6 <- creature_v5 }
  
  # If no creatures meet these criteria...
  if(nrow(creature_v6) == 0){
    
    # Return a warning
    warning("No creatures match these criteria; consider revising search")
    
    # Otherwise...
  } else {
    
    # Do some final processing
    creature_actual <- creature_v6 %>%
      # Drop all action/ability information
      dplyr::select(-dplyr::contains("abili"), -dplyr::contains("action")) %>%
      # Drop any empty columns in this query
      dplyr::select(dplyr::where(fn = ~ !( base::all(is.na(.)) | base::all(. == "")) )) %>%
      # Make it a dataframe
      as.data.frame()
    
    # Return that
    return(creature_actual) } }
