#' @title Retrieve Full Spell Description Text by Spell Name
#'
#' @description Accepts user-provided fifth edition Dungeons & Dragons spell name(s) and returns the full set of spell information (for the 2014 version) and the complete description text. Unlike `dndR::spell_list`, this function requires an exact match between the user-provided spell name(s) and how they appear in the main spell data object. The argument in this function is not sensitive. This function's output differs from `dndR::spell_list` only in that it returns the additional spell description text.
#'
#' @param name (character) exact spell name(s) for which to gather description information
#' @param ver (character) which version of fifth edition to use ("2014" or "2024"). Note that only 2014 is supported and entering "2024" will print a warning to that effect
#'
#' @return (dataframe) 11 columns of spell information with one row per spell specified by the user. Returns 12 columns if the spell is a damage-dealing cantrip that deals increased damage as player level increases or if spell can be cast with a higher level spell slot (i.e., "upcast") for an increased effect.
#'
#' @export
#'
#' @examples
#' spell_text(name = "chill touch")
#'
spell_text <- function(name = NULL, ver = "2014"){
  # Silence visible bindings note
  spell_name <- NULL

  # Return warning if edition is not 2014
  if(as.character(ver) %in% c("2014", "14") != TRUE){
    warning("This function only supports content from the 2014 edition")
  }
  
  # Read in spell dataframe
  all_spells <- dndR::spells

  # Pare down to just this spell
  focal_spell <- as.data.frame(dplyr::filter(.data = all_spells,
                                             tolower(spell_name) %in% tolower(name)))

  # If there is not a spell of that name print a message
  if(nrow(focal_spell) == 0){
    warning("No spell(s) found matching that name; consider checking spelling")
    # Otherwise, return the spell's info
  } else { return(focal_spell) } }
