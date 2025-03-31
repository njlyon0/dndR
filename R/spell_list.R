#' @title List Spells Based on Criteria
#'
#' @description Query list of all fifth edition Dungeons & Dragons spells (2014 version) based on partial string matches between user inputs and the relevant column of the spell information data table. Currently supports users querying the spell list by spell name, which class lists allow the spell, spell's level, the school of magic the spell belongs in, whether or not the spell can be cast as a ritual, and the time it takes to cast the spell. All character arguments are case-insensitive (note that the ritual argument expects a logical). Any argument set to `NULL` (the default) will not be used to include/exclude spells from the returned set of spells
#'
#' @param name (character) text to look for in spell names
#' @param class (character) character class(es) with the spell(s) on their list
#' @param level (character) "cantrip" and/or the minimum required spell slot level
#' @param school (character) school(s) of magic within which the spell belongs (e.g., 'evocation', 'necromancy', etc.)
#' @param ritual (logical) whether the spell can be cast as a ritual
#' @param cast_time (character) either the phase of a turn needed to cast the spell or the in-game time required (e.g., "reaction", "1 minute", etc.)
#' @param ver (character) which version of fifth edition to use ("2014" or "2024"). Note that only 2014 is supported and entering "2024" will print a warning to that effect
#'
#' @return (dataframe) 10 columns of information with one row per spell(s) that fit(s) the user-specified criteria. If no spells fit the criteria, returns a message to that effect instead of a data object
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' # Search for evocation spells with 'fire' in the name that a wizard can cast
#' dndR::spell_list(name = "fire", class = "wizard", school = "evocation")
#'
spell_list <- function(name = NULL, class = NULL, level = NULL,
                       school = NULL, ritual = NULL, cast_time = NULL,
                       ver = "2014"){
  # Squelch visible bindings note
  spell_name <- pc_class <- spell_level <- spell_school <- NULL
  ritual_cast <- casting_time <- description <- higher_levels <- NULL

  # Return warning if version is not 2014
  if(as.character(ver) %in% c("2014", "14") != TRUE){
    warning("This function only supports content from the 2014 edition")
  }
  
  # Read in spell data
  spell_v0 <- dndR::spells

  # Filter by name if names are provided
  if(is.null(name) != TRUE){
    spell_v1 <- dplyr::filter(.data = spell_v0,
                              # More than one name given? Collapse into one string match pattern
                              grepl(pattern = ifelse(test = length(name) > 1,
                                                     yes = paste(name, collapse = "|"),
                                                     no = name),
                                    # Compare string(s) against spell names (case insensitive)
                                    x = spell_name, ignore.case = TRUE))
  } else { spell_v1 <- spell_v0 }

  # Filter by class if classes are provided
  if(is.null(class) != TRUE){
    spell_v2 <- dplyr::filter(.data = spell_v1,
                              grepl(pattern = ifelse(test = length(class) > 1,
                                                     yes = paste(class, collapse = "|"),
                                                     no = class),
                                    x = pc_class, ignore.case = TRUE))
  } else { spell_v2 <- spell_v1 }

  # Filter by level if levels are provided
  if(is.null(level) != TRUE){

    # If level isn't a character, make it so
    if(is.character(level) != TRUE) { level <- as.character(level) }

    # Do actual subsetting
    spell_v3 <- dplyr::filter(.data = spell_v2,
                              grepl(pattern = ifelse(test = length(level) > 1,
                                                     yes = paste(level, collapse = "|"),
                                                     no = level),
                                    x = spell_level, ignore.case = TRUE))
  } else { spell_v3 <- spell_v2 }

  # Filter by school if schools are provided
  if(is.null(school) != TRUE){
    spell_v4 <- dplyr::filter(.data = spell_v3,
                              grepl(pattern = ifelse(test = length(school) > 1,
                                                     yes = paste(school, collapse = "|"),
                                                     no = school),
                                    x = spell_school, ignore.case = TRUE))
  } else { spell_v4 <- spell_v3 }

  # Filter for/against ritual spells if specified
  if(is.null(ritual) != TRUE){

    # Error out if ritual isn't logical
    if(is.logical(ritual) != TRUE)
      stop("`ritual` argument must be a `TRUE`, `FALSE`, or `NULL`")

    # Otherwise, use it to filter by
    spell_v5 <- dplyr::filter(.data = spell_v4, ritual_cast == ritual)
  } else { spell_v5 <- spell_v4 }

  # Filter by casting time
  if(is.null(cast_time) != TRUE){

    # Actually do initial filtering
    spell_v6a <- dplyr::filter(.data = spell_v5,
                               grepl(pattern = ifelse(test = length(cast_time) > 1,
                                                      yes = paste(cast_time, collapse = "|"),
                                                      no = cast_time),
                                     x = casting_time, ignore.case = TRUE))

    # If reaction isn't specified by user, drop it
    ## Necessary because of partial string match of "action" with "reaction"
    if(!"reaction" %in% cast_time){
      spell_v6b <- dplyr::filter(.data = spell_v6a, grepl(pattern = "reaction", x = casting_time,
                                                          ignore.case = TRUE) == FALSE)
    } else { spell_v6b <- spell_v6a }

    # Ditto for bonus action
    ## Necessary because of partial string match of "action" with "bonus action"
    if(!"bonus action" %in% cast_time){
      spell_v6c <- dplyr::filter(.data = spell_v6b, grepl(pattern = "bonus action", x = casting_time,
                                                          ignore.case = TRUE) == FALSE)
    } else { spell_v6c <- spell_v6b }

  } else { spell_v6c <- spell_v5 } # Skip this mess if the argument isn't specified to begin with

  # If there are no spells identified by those arguments...
  if(nrow(spell_v6c) == 0){
    # Return a warning
    warning("No spells match these criteria; consider revising search")

    # Otherwise do some final wrangling
  } else {

    # Wrangle that object as needed before returning
    spell_actual <- spell_v6c %>%
      # Drop the description and higher_levels columns
      dplyr::select(-description, -higher_levels) %>%
      # Drop empty columns (none should exist but better safe than sorry)
      dplyr::select(dplyr::where(fn = ~ !( base::all(is.na(.)) | base::all(. == "")) ))

    # Return that object
    return(as.data.frame(spell_actual)) } }
