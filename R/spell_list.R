#' @title
#'
#' @description
#'
#' @param
#' @param
#'
#' @return
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' spell_list(name = "fire", class = "wizard", school = "evocation")
#'

spell_list <- function(name = NULL, class = NULL, level = NULL,
                       school = NULL, ritual = NULL, cast_time = NULL){

  # Read in spell data
  spell_v0 <- dndR::spells

  # Filter by name if names are provided
  if(is.null(name) != T){
    spell_v1 <- dplyr::filter(.data = spell_v0,
                              # More than one name given? Collapse into one string match pattern
                              grepl(pattern = ifelse(test = length(name) > 1,
                                                     yes = paste(name, collapse = "|"),
                                                     no = name),
                                    # Compare string(s) against spell names (case insensitive)
                                    x = spell_name, ignore.case = T))
  } else { spell_v1 <- spell_v0 }

  # Filter by class if classes are provided
  if(is.null(class) != T){
    spell_v2 <- dplyr::filter(.data = spell_v1,
                              grepl(pattern = ifelse(test = length(class) > 1,
                                                     yes = paste(class, collapse = "|"),
                                                     no = class),
                                    x = pc_class, ignore.case = T))
  } else { spell_v2 <- spell_v1 }

  # Filter by level if levels are provided
  if(is.null(level) != T){

    # If level isn't a character, make it so
    if(is.character(level) != TRUE) { level <- as.character(level) }

    # Do actual subsetting
    spell_v3 <- dplyr::filter(.data = spell_v2,
                              grepl(pattern = ifelse(test = length(level) > 1,
                                                     yes = paste(level, collapse = "|"),
                                                     no = level),
                                    x = spell_level, ignore.case = T))
  } else { spell_v3 <- spell_v2 }

  # Filter by school if schools are provided
  if(is.null(school) != T){
    spell_v4 <- dplyr::filter(.data = spell_v3,
                              grepl(pattern = ifelse(test = length(school) > 1,
                                                     yes = paste(school, collapse = "|"),
                                                     no = school),
                                    x = spell_school, ignore.case = T))
  } else { spell_v4 <- spell_v3 }

  # Filter for/against ritual spells if specified
  if(is.null(ritual) != T){

    # Error out if ritual isn't logical
    if(is.logical(ritual) != TRUE)
      stop("`ritual` argument must be a `TRUE`, `FALSE`, or `NULL`")

    # Otherwise, use it to filter by
    spell_v5 <- dplyr::filter(.data = spell_v4, ritual_cast == ritual)
  } else { spell_v5 <- spell_v4 }

  # Filter by casting time
  if(is.null(cast_time) != T){

    # Actually do initial filtering
    spell_v6a <- dplyr::filter(.data = spell_v5,
                               grepl(pattern = ifelse(test = length(cast_time) > 1,
                                                      yes = paste(cast_time, collapse = "|"),
                                                      no = cast_time),
                                     x = casting_time, ignore.case = T))

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
    # Return a message
    message("No spells match these criteria; consider revising search")

    # Otherwise do some final wrangling
  } else {

    # Wrangle that object as needed before returning
    spell_actual <- spell_v6c %>%
      # Drop the description and higher_levels columns
      dplyr::select(-description, -higher_levels) %>%
      # Drop empty columns (none should exist but better safe than sorry)
      dplyr::select(dplyr::where(fn = ~ !( base::all(is.na(.)) | base::all(. == "")) ))

    # Return that object
    return(spell_actual) } }
