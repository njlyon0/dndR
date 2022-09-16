#' @title Assign Ability Scores Based on Class
#'
#' @description Assign rolled ability scores based on the recommendations for quick class building given in the Player's Handbook (PHB).
#'
#' @param class (character) name of character class (supported classes returned by `dnd_classes()`)
#' @param score_method (character) preferred method of rolling for ability scores "4d6", "3d6", or "1d20" ("d20" also accepted synonym of "1d20"). Only values accepted by `ability_scores()` are accepted here
#' @param scores_rolled (logical) whether ability scores have previously been rolled (via `ability_scores()`). Defaults to FALSE
#' @param scores_df (dataframe) if 'scores_rolled' is TRUE, the name of the dataframe object returned by `ability_scores()`
#'
#' @return a dataframe of two columns and six rows
#'
#' @importFrom magrittr %>%
#' @export
#'
#' @examples
#' # Can roll up a new character of the desired class from scratch
#' class_block(class = "wizard", score_method = "4d6")
#'
#' # Or you can roll separately and then create a character with that dataframe
#' my_scores <- ability_scores(method = "4d6")
#' class_block(class = "fighter", scores_rolled = TRUE, scores_df = my_scores)
#'
class_block <- function(class = NULL, score_method = "4d6",
                       scores_rolled = FALSE, scores_df = NULL){
  # Squelch visible bindings note
  score <- ability <- NULL

  # If scores have been rolled but dataframe hasn't been provided, error out
  if(scores_rolled == TRUE & base::is.null(scores_df))
    stop("No scores dataframe provided but 'scores_rolled' is set to TRUE. Please provide name of dataframe returned by `ability_scores()` to 'scores_df' argument.")

  # If scores have been rolled and a dataframe has been provided, change its name
  if(scores_rolled == TRUE & !base::is.null(scores_df)){ scores <- scores_df }

  # If scores haven't been rolled, roll them here
  if(scores_rolled == FALSE){ scores <- ability_scores(method = score_method) }

  # Error out if class isn't one of supported vector
  if(base::is.null(class) | !base::tolower(class) %in% dnd_classes())
    stop("Class either not provided or not one of accepted classes. Run `dnd_classes()` for the classes this function currently supports")

  # Determine top two abilities based on class
  if(base::tolower(class) == "barbarian"){ top_two <- c("STR", "CON") }
  if(base::tolower(class) == "bard"){ top_two <- c("CHA", "DEX") }
  if(base::tolower(class) == "cleric"){ top_two <- c("WIS", "STR") }
  if(base::tolower(class) == "druid"){ top_two <- c("WIS", "CON") }
  if(base::tolower(class) == "fighter"){ top_two <- c("STR", "DEX") }
  if(base::tolower(class) == "monk"){ top_two <- c("DEX", "WIS") }
  if(base::tolower(class) == "paladin"){ top_two <- c("STR", "CHA") }
  if(base::tolower(class) == "ranger"){ top_two <- c("DEX", "WIS") }
  if(base::tolower(class) == "rogue"){ top_two <- c("DEX", "INT") }
  if(base::tolower(class) == "sorcerer"){ top_two <- c("CHA", "CON") }
  if(base::tolower(class) == "warlock"){ top_two <- c("CHA", "CON") }
  if(base::tolower(class) == "wizard"){ top_two <- c("INT", "CON") }
  # If we need to add classes we can use the next line
  # if(base::tolower(class) == ""){ top_two <- c("", "") }

  # Identify remaining
  remaining <- sample(x = base::setdiff(x = c("STR", "DEX", "CON",
                                              "INT", "WIS", "CHA"),
                                        y = top_two),
                      size = 4, replace = FALSE)

  # Sort ability scores and assign abilities to those scores based on class
  stat_block <- scores %>%
    # Keep only scores
    dplyr::select(score) %>%
    # Sort by value
    dplyr::arrange(dplyr::desc(score)) %>%
    # Attach the scores previously ordered
    dplyr::mutate(ability = base::factor(x = c(top_two, remaining),
                                         levels = c("STR", "DEX", "CON",
                                                    "INT", "WIS", "CHA")) ) %>%
    # Reorder columns
    dplyr::select(ability, score) %>%
    # Reorder rows
    dplyr::arrange(ability) %>%
    # Return dataframe
    as.data.frame()

  # Return the stat block
  return(stat_block) }
