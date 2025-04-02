#' @title Assign Ability Scores Based on Class
#'
#' @description Assign rolled ability scores based on the recommendations for quick class building given in the Player's Handbook (PHB) in the 2014 version of the rules.
#'
#' @param class (character) name of character class (supported classes returned by `dndR::dnd_classes()`). Also supports "random" and will randomly select a supported class
#' @param score_method (character) preferred method of rolling for ability scores "4d6", "3d6", or "1d20" ("d20" also accepted synonym of "1d20"). Only values accepted by `dndR::ability_scores()` are accepted here
#' @param scores_rolled (logical) whether ability scores have previously been rolled (via `dndR::ability_scores()`). Defaults to FALSE
#' @param scores_df (dataframe) if 'scores_rolled' is TRUE, the name of the dataframe object returned by `dndR::ability_scores()`
#' @param quiet (logical) whether to print warnings if the total score is very low or one ability score is very low
#' @param ver (character) which version of fifth edition to use ("2014" or "2024")
#'
#' @return (dataframe) two columns and six rows
#' 
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' # Can roll up a new character of the desired class from scratch
#' dndR::class_block(class = "wizard", score_method = "4d6")
#'
#' # Or you can roll separately and then create a character with that dataframe
#' my_scores <- ability_scores(method = "4d6")
#' dndR::class_block(class = "fighter", scores_rolled = TRUE, scores_df = my_scores)
#'
class_block <- function(class = NULL, score_method = "4d6",
                        scores_rolled = FALSE, scores_df = NULL, quiet = FALSE,
                        ver = "2014"){
  # Squelch visible bindings note
  score <- ability <- NULL
  
  # Warn for malformed 'scores_rolled' parameter
  if(is.logical(scores_rolled) != TRUE){
    warning("'scores_rolled' must be a logical. Defaulting to FALSE")
    scores_rolled <- FALSE }
  
  # Error for saying scores have been rolled but not providing them
  if(scores_rolled == TRUE & is.null(scores_df))
    stop("No scores dataframe provided but 'scores_rolled' is set to TRUE. Please pass object returned by 'dndR::ability_scores()' to 'scores_df' argument")
  
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
  
  # Make class lowercase
  class_lcase <- tolower(class)
  
  # Class must be specified as a single value in the supported set
  if(is.null(class_lcase) || is.character(class_lcase) != TRUE || length(class_lcase) != 1 || class_lcase %in% c(dndR::dnd_classes(), "random") != TRUE)
    stop("'class' must be one of supported classes. Run 'dndR::dnd_classes()' for supported classes")
  
  # Coerce version to proper form
  ver_char <- as.character(ver)
  
  # Malformed 'ver' values
  if(is.null(ver_char) || length(ver_char) != 1 || ver_char %in% c("2014", "2024") != TRUE)
    stop("'ver' must be one of '2014' or '2024'")
  
  # If class is set to random, pick one
  if(class_lcase == "random"){
    class_lcase <- sample(x = dndR::dnd_classes(), size = 1)
    message("Random class selected: ", class_lcase) }
  
  # Determine top two abilities based on class
  if(class_lcase == "artificer"){ top_two <- c("INT", "DEX") }
  if(class_lcase == "barbarian"){ top_two <- c("STR", "CON") }
  if(class_lcase == "bard"){ top_two <- c("CHA", "DEX") }
  if(class_lcase == "cleric"){ top_two <- c("WIS", "STR") }
  if(class_lcase == "cleric" & ver_char == "2014"){ top_two <- c("WIS", "STR") }
  if(class_lcase == "cleric" & ver_char == "2024"){ top_two <- c("WIS", "CHA") }
  if(class_lcase == "druid" & ver_char == "2014"){ top_two <- c("WIS", "CON") }
  if(class_lcase == "druid" & ver_char == "2024"){ top_two <- c("WIS", "INT") }
  if(class_lcase == "fighter"){ top_two <- c("STR", "DEX") }
  if(class_lcase == "monk"){ top_two <- c("DEX", "WIS") }
  if(class_lcase == "paladin"){ top_two <- c("STR", "CHA") }
  if(class_lcase == "ranger"){ top_two <- c("DEX", "WIS") }
  if(class_lcase == "rogue"){ top_two <- c("DEX", "INT") }
  if(class_lcase == "sorcerer"){ top_two <- c("CHA", "CON") }
  if(class_lcase == "warlock" & ver_char == "2014"){ top_two <- c("CHA", "CON") }
  if(class_lcase == "warlock" & ver_char == "2024"){ top_two <- c("CHA", "WIS") }
  if(class_lcase == "wizard" & ver_char == "2014"){ top_two <- c("INT", "CON") }
  if(class_lcase == "wizard" & ver_char == "2024"){ top_two <- c("INT", "WIS") }
  # If we need to add classes we can use the next line
  # if(class_lcase == ""){ top_two <- c("", "") }
  
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
