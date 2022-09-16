#' @title Create a Player Character (PC)
#'
#' @description Stat out a player character (PC) of specified race and class using your preferred method for rolling ability scores.
#'
#' @param class (character) name of character class (supported classes returned by `dnd_classes()`)
#' @param race (character) name of character race (supported classes returned by `dnd_races()`)
#' @param score_method (character) preferred method of rolling for ability scores "4d6", "3d6", or "1d20" ("d20" also accepted synonym of "1d20"). Only values accepted by `ability_scores()` are accepted here
#' @param scores_rolled (logical) whether ability scores have previously been rolled (via `ability_scores()`). Defaults to FALSE
#' @param scores_df (dataframe) if 'scores_rolled' is TRUE, the name of the dataframe object returned by `ability_scores()`
#'
#' @return (dataframe) raw ability score, race modifier, total ability score, and the roll modifier for each of the six abilities
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
  score <- modifier <- raw_score <- race_modifier <- modifier_calc <- NULL
  
  # No errors/warnings required because this is a wrapper for other custom functions that themselves have good error messages built in!
  
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
    dplyr::mutate(modifier_calc = base::floor(x = ((score - 10) / 2))) %>%
    # Paste a plus if its positive
    dplyr::mutate(roll_modifier = ifelse(test = modifier_calc > 0,
                                         yes = paste0("+", modifier_calc),
                                         no = modifier_calc)) %>%
    # Drop calculated modifier
    dplyr::select(-modifier_calc) %>%
    # Return as a dataframe
    as.data.frame()
  
  # Return that table
  return(full_stats) }
