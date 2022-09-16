#' @title Rolls for a Single Ability Score
#'
#' @description Rolls for a single ability score using the specified method of dice rolling.
#'
#' @param method (character) string of "4d6", "3d6", or "1d20" ("d20" also accepted). Enter your preferred method of rolling for each ability score ("4d6" drops lowest before summing)
#'
#' @return (numeric) vector of roll outcomes (not summed)
#'
#' @export
#'
#'
ability_singular <- function(method = "4d6"){
  # Create empty list
  blank <- list()

  # Increase specificity of "d20" if someone enters that
  if(method == "d20"){method <- "1d20"}

  # Error out if method isn't specified
  if(!method %in% c("4d6", "3d6", "1d20")) stop("`method` not recognized. Select one of '4d6', '3d6', '1d20', or 'd20'")

  # Roll appropriate number of dice
  if(method == "4d6"){ for(i in 1:4){ blank[i]<- d6() } }
  if(method == "3d6"){ for(i in 1:3){ blank[i]<- d6() } }
  if(method == "1d20"){ blank[1] <- d20() }

  # Unbind list into a numeric vector
  score <- base::as.numeric(base::do.call(what = rbind, args = blank))

  # Return that vector
  return(score) }

#' @title Roll for All Ability Scores
#'
#' @description Rolls for six ability scores using the desired method of rolling (4d6 drop lowest, 3d6, or 1d20). Doesn't assign abilities to facilitate player selection of which score should be each ability for a given character. Prints a warning if the total of all abilities is less than 70 or if any one ability is less than 8.
#'
#' @param method (character) string of "4d6", "3d6", or "1d20" ("d20" also accepted). Enter your preferred method of rolling for each ability score ("4d6" drops lowest before summing)
#' @param quiet (logical) whether to print warnings if the total score is very low or one ability score is very low
#'
#' @return a dataframe of two columns and six rows
#'
#' @importFrom magrittr %>%
#' @export
#'
#' @examples
#' # Roll ability scores using four d6 and dropping the lowest
#' ability_scores(method = "4d6")
#'
#' # Roll using 3d6 and dropping nothing
#' ability_scores("3d6")
#'
#' # Or if you're truly wild, just roll a d20 for each ability
#' ability_scores('d20')
#'
ability_scores <- function(method = "4d6", quiet = FALSE){
  # Squelch 'no visible bindings' note
  name <- value <- total <- NULL

  # Error out if method is not part of accepted list
  if(!method %in% c("4d6", "3d6", "1d20", "d20"))
    stop("`method` not recognized, must be one of '4d6', '3d6', '1d20', or  'd20'")
  
  # Warn if quiet isn't logical
  if(class(quiet) != "logical"){
    message("`quiet` must be a logical. Defaulting to FALSE")
    quiet <- FALSE }
    
  
  # Increase specificity of "d20" if someone enters that
  if(method == "d20"){method <- "1d20"}

  # Identify number of rows of placeholder matrix
  if(method == "4d6"){ row_num <- 4 }
  if(method == "3d6"){ row_num <- 3 }
  if(method == "1d20"){ row_num <- 1 }

  # Make placeholder matrix
  empty_block <- matrix(nrow = row_num, ncol = 6)

  # Fill it column by column
  for(k in 1:6){ empty_block[,k] <- ability_singular(method = method) }

  # Method == "4d6" (and drop lowest) ----
  if(method == "4d6") {
  # Assemble the stat block
  block <- base::as.data.frame(empty_block) %>%
    # Pivot to long format
    tidyr::pivot_longer(cols = dplyr::everything()) %>%
    # Group by column
    dplyr::group_by(name) %>%
    # Arrange in ascending order of dice outcome
    dplyr::arrange(value, .by_group = TRUE) %>%
    # Sequence (within group) to increasing dice outcomes
    dplyr::mutate(sequence = base::seq_along(along.with = name)) %>%
    # Drop the lowest value (within group)
    dplyr::filter(sequence != 1) %>%
    # Sum through remaining values and drop all but sum and group name
    dplyr::summarise(total = base::sum(value, na.rm = TRUE)) %>%
    # Return better names
    dplyr::rename(ability = name, score = total) %>%
    # Return as a dataframe
    base::as.data.frame() }

  # Method == "3d6" ----
  if(method == "3d6") {
    # Assemble the stat block
    block <- base::as.data.frame(empty_block) %>%
      # Same as "4d6" but no subsetting
      tidyr::pivot_longer(cols = dplyr::everything()) %>%
      dplyr::group_by(name) %>%
      dplyr::summarise(total = base::sum(value, na.rm = TRUE)) %>%
      dplyr::rename(ability = name, score = total) %>%
      base::as.data.frame() }

  # Method == "1d20" ----
  if(method == "1d20"){
    block <- base::as.data.frame(empty_block) %>%
      # Just clean up the data and return it
      tidyr::pivot_longer(cols = dplyr::everything()) %>%
      dplyr::rename(ability = name, score = value) %>%
      base::as.data.frame() }

  # If the user desires, we can warn them for low totals or low abilities
  ## 1d20 very consistently trips these but I'll let the user handle that
  if(quiet == FALSE) {
  # Print a warning if the sum of all scores is too low
  if(base::sum(block$score, na.rm = TRUE) < 70){
    base::message("Total score low. Consider re-rolling?") }

  # Print a warning if one or more abilities is very low
  if(base::min(block$score, na.rm = TRUE) < 8){
    base::message("At least one ability very low. Consider re-rolling?") }
    }

  # Return filled block
  return(block) }
