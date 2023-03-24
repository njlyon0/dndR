#' @title Convert Challenge Rating to Experience Points
#'
#' @description Converts challenge rating (CR) into experience points (XP) using two formulas for a parabola (one for CR less than/equal to 20 and one for greater than 20). The relationship between CR and XP in the Dungeon Master's Guide (DMG) is disjointed in this way so this is a reasonable move. Accepts '1/8', '1/4, and '1/2' in addition to numbers between 1 and 30.
#'
#' @param cr (numeric) Challenge rating for which you want to calculate experience points
#'
#' @return (numeric) value of XP equivalent to the user-supplied challenge rating
#' @importFrom magrittr %>%
#'
#' @export
#'
cr_convert <- function(cr = NULL){

  # Error out if its not filled
  if(base::is.null(cr))
    stop("`cr` must be provided")

  # Error out for unrecognized challenge rating entries
  if(!cr %in% c(0, "1/8", "1/4", "1/2", 0.125, 0.25, 0.5, 1:30))
    stop("Unrecognized `cr` entry. Must be one of '0', '1/8', '1/4', '1/2' or any number between 1 and 30")

  # Handle fraction CRs
  if(cr == "1/8"){cr <- 0.125}
  if(cr == "1/4"){cr <- 0.25}
  if(cr == "1/2"){cr <- 0.5}

  # Calculate XP depending on XP > / < than 20
  ## CR less than or equal to 20
  if(cr <= 20){ xp_raw <- ((56.8889 * cr^2) + (31.111 * cr) + 112.0001) }

  ## CR greater than 20
  if(cr > 20){ xp_raw <- ((642.8571 * cr^2) + (-19071.43 * cr) + 150000) }

  # Round this (up) to an integer
  xp <- base::ceiling(x = xp_raw)

  # Return XP
  return(xp) }
