#' @title Assign Ability Scores Based on Class
#'
#' @description Assign rolled ability scores based on the recommendations for quick class building given in the Player's Handbook (PHB).
#'
#' @param class (character) name of character class (supported classes returned by `dnd_classes()`). Also supports "random" and will randomly select a supported class
#' @param score_method (character) preferred method of rolling for ability scores "4d6", "3d6", or "1d20" ("d20" also accepted synonym of "1d20"). Only values accepted by `ability_scores()` are accepted here
#' @param scores_rolled (logical) whether ability scores have previously been rolled (via `ability_scores()`). Defaults to FALSE
#' @param scores_df (dataframe) if 'scores_rolled' is TRUE, the name of the dataframe object returned by `ability_scores()`
#' @param quiet (logical) whether to print warnings if the total score is very low or one ability score is very low
#'
#' @return (dataframe) two columns and six rows
#' @importFrom magrittr %>%
#'
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
                        scores_rolled = FALSE, scores_df = NULL, quiet = FALSE){
  # Squelch visible bindings note
  score <- ability <- NULL

  # Warn for malformed 'scores_rolled' parameter
  if(is.logical(scores_rolled) != TRUE){
    warning("'scores_rolled' must be a logical. Defaulting to FALSE")
    scores_rolled <- FALSE }

  # Error for saying scores have been rolled but not providing them
  if(scores_rolled == TRUE & is.null(scores_df))
    stop("No scores dataframe provided but 'scores_rolled' is set to TRUE. Please provide name of dataframe returned by 'ability_scores()' to 'scores_df' argument.")

  # Error for providing scores as anything other than a dataframe
  if(scores_rolled == TRUE & is.data.frame(scores_df) != TRUE)
    stop("Pre-rolled scores must be provided as a dataframe")

  # Error for too many/few scores
  if(scores_rolled == TRUE & is.data.frame(scores_df) == TRUE){
    if(nrow(scores_df) != 6)
      stop("Too few or too many pre-rolled ability scores provided") }

  # If scores have been rolled and a dataframe has been provided, change the object name
  if(scores_rolled == TRUE & !base::is.null(scores_df)){
    scores <- scores_df }

  # If scores haven't been rolled, roll them here
  if(scores_rolled == FALSE){
    scores <- ability_scores(method = score_method, quiet = quiet) }

  # Error out if class isn't supplied
  if(is.null(class) == TRUE)
    stop("Class must be specified")

  # Error out if class is supplied but isn't in the set of allowed classes
  if(!tolower(class) %in% c(dnd_classes(), "random"))
    stop("Chosen class not currently supported by this function. Run 'dnd_classes()' for accepted classes")

  # If class is set to random, pick one
  if(tolower(class) == "random"){
    class <- sample(x = dnd_classes(), size = 1)
    message("Random class selected: ", class) }

  # Determine top two abilities based on class
  if(base::tolower(class) == "artificer"){ top_two <- c("INT", "DEX") }
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
