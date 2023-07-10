#' @title Dungeons and Dragons Quick Table for Creature Statistics
#'
#' @description On pages 274 and 275 in the Dungeon Master's Guide (Fifth Edition) there are two tables that relate creature Challenge Rating (CR) to various vital statistics (armor, hit points, etc.) and to Experience Points (XP). These tables have been transcribed into this data object for ease of reference.
#'
#' @format Dataframe with 7 columns and 34 rows
#' \describe{
#'     \item{Challenge}{Challenge Rating (CR) expressed as a number}
#'     \item{DMG_XP}{Experience Points (XP) for that CR as dictated by the DMG}
#'     \item{Prof_Bonus}{Modifier to add to rolls where the creature is proficient}
#'     \item{Armor_Class}{Armor class of the creature}
#'     \item{HP_Range}{Range of hit points (HP) for the creature}
#'     \item{HP_Average}{Average of minimum and maximum HP of range for the creature}
#'     \item{Attack_Bonus}{Modifier to add to the creature's attack rolls}
#'     \item{Save_DC}{Save Difficulty Class (DC) for rolls against the creature's spells / certain abilities}
#' }
#'
#' @source {Mearls, M., Crawford, J., Perkins, C., Wyatt, J. et al. Dungeon Master's Guide (Fifth Edition). 2014.}
#'
"monsters"
