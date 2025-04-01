#' @title Create a Player Character (PC)
#'
#' @description Assign ability scores for a fifth edition Dungeons and Dragons player character (PC) of specified race and class using your preferred method for rolling ability scores. Note that in the 2024 version of fifth edition, race has no effect on ability scores so that part of this function is ignored if the 2024 rules are indicated.
#'
#' @param class (character) name of character class (supported classes returned by `dndR::dnd_classes()`). Also supports "random" and will randomly select a supported class. Random class returned as message
#' @param race (character) name of character race (supported classes returned by `dndR::dnd_races()`). Also supports "random" and will randomly select a supported race. Random race returned as message. Note that if `ver` is set to "2024", this argument is ignored
#' @param score_method (character) preferred method of rolling for ability scores "4d6", "3d6", or "1d20" ("d20" also accepted synonym of "1d20"). Only values accepted by `dndR::ability_scores()` are accepted here
#' @param scores_rolled (logical) whether ability scores have previously been rolled (via `dndR::ability_scores()`). Defaults to FALSE
#' @param scores_df (dataframe) if 'scores_rolled' is TRUE, the name of the dataframe object returned by `dndR::ability_scores()`
#' @param quiet (logical) whether to print warnings if the total score is very low or one ability score is very low
#' @param ver (character) which version of fifth edition to use ("2014" or "2024")
#'
#' @return (dataframe) raw ability score, race modifier, total ability score, and the roll modifier for each of the six abilities
#' 
#' @importFrom magrittr %>%
#' @importFrom magrittr %<>%
#'
#' @export
#'
#' @examples
#' # Create a PC's base statistics from scratch
#' dndR::pc_creator(class = 'barbarian', race = 'warforged', score_method = "4d6", quiet = TRUE)
#'
#' # Or you can roll separately and then create a character with that dataframe
#' my_scores <- dndR::ability_scores(method = "4d6", quiet = TRUE)
#' dndR::pc_creator(class = 'sorcerer', race = 'orc', scores_rolled = TRUE, scores_df = my_scores)
#'
pc_creator <- function(class = NULL, race = NULL, score_method = "4d6",
                       scores_rolled = FALSE, scores_df = NULL, quiet = FALSE,
                       ver = "2014"){
  # Squelch no visible bindings note
  score <- modifier <- raw_score <- race_modifier <- modifier_calc <- NULL
  
  # Coerce version to proper form
  ver_char <- as.character(ver)
  
  # Malformed 'ver' values
  if(is.null(ver_char) || length(ver_char) != 1 || ver_char %in% c("2014", "2024") != TRUE)
    stop("'ver' must be one of '2014' or '2024'")
  
  # No other errors/warnings required because this is a wrapper for other custom functions that themselves have good error messages built in!
  
  # Create class block
  class_df <- dndR::class_block(class = class, score_method = score_method,
                                scores_rolled = scores_rolled, scores_df = scores_df, 
                                quiet = quiet, ver = ver)
  
  # 2014 uses racial ability score modifiers but 2024 doesn't
  if(ver_char == "2014"){ 
    race_df <- dndR::race_mods(race = race)
  } else { 
    race_df <- data.frame("ability" = c("STR", "DEX", "CON",
                                        "INT", "WIS", "CHA"),
                          "modifier" = 0)
  }
  
  # Combine both tables
  full_stats <- class_df %>%
    dplyr::left_join(y = race_df, by = "ability") %>%
    # Rename the columns more descriptively
    dplyr::rename(raw_score = score, race_modifier = modifier) %>%
    # Calculate the total scores & roll modifiers
    dplyr::mutate(score = (raw_score + race_modifier),
                  roll_modifier = dndR::mod_calc(score = score)) %>%
    # Return as a dataframe
    as.data.frame()
  
  # If 2024 is the specified version remove irrelevant racial columns
  if(ver_char == "2024"){
    full_stats %<>%
      dplyr::select(-raw_score, -race_modifier)
  }
  
  # Return that table
  return(full_stats) }
