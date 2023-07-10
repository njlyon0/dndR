#' @title
#'
#' @description
#'
#' @param
#'
#' @return
#'
#' @export
#'
#' @examples
#' spell_text(name = "chill touch")
#'
spell_text <- function(name = NULL){

  # Read in spell dataframe
  all_spells <- dndR::spells

  # Pare down to just this spell
  focal_spell <- as.data.frame(dplyr::filter(.data = all_spells,
                                             tolower(spell_name) %in% tolower(name)))

  # If there is not a spell of that name print a message
  if(nrow(focal_spell) == 0){
    message("No spell(s) found matching that name; consider checking spelling")
    # Otherwise, return the spell's info
  } else { return(focal_spell) } }
