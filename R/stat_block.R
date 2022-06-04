#' @title Rolls for a Single Ability Score
#'
#' @description Rolls 4d6.
#'
#' @return a numeric vector
#'
#' @export
#'
ability_score <- function(){
  # Create empty list
  blank <- list()

  # Populate list with rolled values
  for(i in 1:4){
    blank[i]<- dndR::d6()
  }

  # Unbind list into a numeric vector
  score <- base::as.numeric(base::do.call(what = rbind, args = blank))

  # Return that vector
  return(score)
}


#' @title Create Full Stat Block
#'
#' @description Rolls 4d6 and drops the lowest value for six abilities. Doesn't assign abilities to facilitate player selection of which score should be each ability for a given character. Prints a warning if the total of all abilities is less than 70 or if any one ability is less than 8.
#'
#' @return a dataframe of two columns and six rows
#'
#' @importFrom magrittr %>%
#' @export
#'
stat_block <- function(){
  # Squelch 'no visible bindings' note
  name <- value <- total <- NULL

  # Make placeholder matrix
  empty_block <- matrix(nrow = 4, ncol = 6)

  # Fill it column by column
  for(k in 1:6){
    empty_block[,k] <- dndR::ability_score()
    }

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
    base::as.data.frame()

  # Print a warning if its too low
  if(base::sum(block$score, na.rm = TRUE) < 70){
    base::message("Total score very low. Consider re-rolling?") }

  if(base::min(block$score, na.rm = TRUE) < 8){
    base::message("At least one ability very low. Consider re-rolling?") }

  # Return filled block
  return(block) }
