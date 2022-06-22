#' @title Convert Challenge Rating to Experience Points
#'
#' @description Converts challenge rating (CR) into experience points (XP) using two formulas for a parabola (one for less than/equal to 20 and one for greater than 20). The relationship between CR and XP in the Dungeon Master's Guide (DMG) is disjointed in this way so this is a reasonable move.
#'
#' @param cr (numeric) Challenge rating that you want to calculate experience points for
#'
#' @importFrom magrittr %>%
#'
#' @export
#'
cr_convert <- function(cr = NULL){

  # Error out if its not filled
  if(base::is.null(cr) | !base::is.numeric(cr))
    stop("`cr` must be non-null and numeric")

  # Calculate XP depending on XP > / < than 20
  ## CR less than or equal to 20
  if(cr <= 20){ xp <- ((56.8889 * cr^2) + (31.111 * cr) + 112.0001) }

  ## CR greater than 20
  if(cr > 20){ xp <- ((642.8571 * cr^2) + (-19071.43 * cr) + 150000) }

  # Return XP
  return(xp)
}
