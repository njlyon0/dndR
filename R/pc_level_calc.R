#' @title Calculate Player Character (PC) Level from Current Experience Points (XP)
#'
#' @description Uses total player experience points (XP) to identify player character (PC) level and proficiency modifier. Only works for a single PC at a time (though this is unlikely to be an issue if all party members have the same amount of XP)
#'
#' @param player_xp (numeric) total value of experience points earned by one player
#'
#' @return (dataframe) current player level, XP threshold for that level, and the proficiency modifier used at that level
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' # Calculate player level from XP earned
#' pc_level_calc(player_xp = 950)
#'
pc_level_calc <- function(player_xp = NULL){

  # Error out if `player_xp` isn't provided
  if(is.null(player_xp))
    stop("`player_xp` must be provided as a number")

  # Also error out if it's not numeric
  if(is.numeric(player_xp) != TRUE)
    stop("`player_xp` must be numeric")

  # Error out if too many XP values are provided
  if(length(player_xp) != 1)
    stop("`player_xp` must be only one number")

  # If no errors, build a quick reference table
  xp_reftable <- data.frame(player_level = seq(1:20),
                            xp_threshold = c(0, 300, 900, 2700, 6500,
                                                 14000, 23000, 34000, 48000, 64000,
                                                 85000, 100000, 120000, 140000, 165000,
                                                 195000, 225000, 265000, 305000, 355000),
                            proficiency = rep(x = c("+2", "+3", "+4", "+5", "+6"), each = 4))

  # Filter to only levels equal to or below current player XP
  level_out <- xp_reftable %>%
    dplyr::filter(xp_threshold <= player_xp) %>%
    # Keep only last row (i.e., highest possible level for that amount of player XP)
    utils::tail(x = ., n = 1)

  # Return that object
  return(level_out) }
