#' @title Create a Player Character (PC)
#'
#' @description Stat out a player character of specified race and class using your preferred method for rolling ability scores.
#'
#' @param class character string of class (supported classes returned by `accepted_classes()`)
#' @param race character string of race (supported classes returned by `dnd_races()`)
#' @param score_method character string of "4d6", "3d6", or "1d20" ("d20" also accepted). Only values accepted by `ability_scores()` are accepted here
#' @param scores_rolled logical indicating whether ability scores have previously been rolled (via `ability_scores()`). Defaults to FALSE
#' @param scores_df if 'scores_rolled' is TRUE, the name of the dataframe returned by `ability_scores()`
#'
#' @return a dataframe of five columns and six rows
#' @export
#'
#' @examples
#' # Create a PC's base statistics from scratch
#' pc_creator(class = 'barbarian', race = 'half orc', score_method = "4d6")
#'
#' # Or you can roll separately and then create a character with that dataframe
#' my_scores <- ability_scores(method = "4d6")
#' pc_creator(class = 'sorcerer', race = 'dragonborn', scores_rolled = TRUE, scores_df = my_scores)
#'
pc_creator <- function(class = NULL, race = NULL, score_method = "4d6",
                       scores_rolled = FALSE, scores_df = NULL){
  # Squelch no visible bindings note
  score <- modifier <- raw_score <- race_modifier <- NULL

  # Create class block
  class_df <- class_block(class = class, score_method = score_method,
                    scores_rolled = scores_rolled, scores_df = scores_df)

  # Now identify racial modifers
  race_df <- race_mods(race = race)

  # Combine both tables
  full_stats <- class_df %>%
    dplyr::left_join(y = race_df, by = "ability") %>%
    # Rename the columns more descriptively
    dplyr::rename(raw_score = score, race_modifier = modifier) %>%
    # Calculate the total scores
    dplyr::mutate(score = (raw_score + race_modifier)) %>%
    # Identify the roll modifier from scores between 1 and 30
    dplyr::mutate(roll_modifier = dplyr::case_when(
      score %in% c(1) ~ '-5',
      score %in% c(2, 3) ~ '-4',
      score %in% c(4, 5) ~ '-3',
      score %in% c(6, 7) ~ '-2',
      score %in% c(8, 9) ~ '-1',
      score %in% c(10, 11) ~ '0',
      score %in% c(12, 13) ~ '+1',
      score %in% c(14, 15) ~ '+2',
      score %in% c(16, 17) ~ '+3',
      score %in% c(18, 19) ~ '+4',
      score %in% c(20, 21) ~ '+5',
      score %in% c(22, 23) ~ '+6',
      score %in% c(24, 25) ~ '+7',
      score %in% c(26, 27) ~ '+8',
      score %in% c(28, 29) ~ '+9',
      score %in% c(30) ~ '+10'))

  # Return that table
  return(full_stats)
}
