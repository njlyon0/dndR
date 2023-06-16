#' @title Generate a Plot of the Frequency of Roll Outcomes
#'
#' @description Input the number and type of dice to roll and the number of times to roll the dice. This is used to generate a plot of the real distribution of dice outcomes and create a ggplot2 plot of that result. A vertical dashed line is included at the median roll result. Note that low numbers of rolls may not generate realistic frequencies of outcomes
#'
#' @param dice (character) specifying the number of dice and which type (e.g., "2d4" for two, four-sided dice). Defaults to two, six-sided dice
#' @param roll_num (integer) number of times to roll the specified dice to generate the data fro the probability plot. Defaults to 999
#'
#' @return (ggplot object) roll outcome frequency as a ggplot2 object
#' @import ggplot2
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' # Generate a probability plot of 3d8
#' probability_plot(dice = "3d8", roll_num = 99)
#'
probability_plot <- function(dice = "2d20", roll_num = 999){

  # Error out if roll number is not an integer
  if(!is.numeric(x = roll_num))
    stop("`roll_num` must be an integer")

  # Roll an initial set of the specified dice
  first_roll <- suppressMessages(dndR::roll(dice = dice, show_dice = F))

  # Handle case if someone is using 2d20
  ## `dndR::roll` returns a differently-formatted object in this case
  if(dice == "2d20"){
    roll_results <- data.frame("outcome" = sum(first_roll[1], first_roll[2]))
    # If not 2d20, just grab the roll outcome
  } else { roll_results <- data.frame("outcome" = first_roll) }

  # Roll dice the user-specified number of times and store results
  for(k in 1:roll_num){

    # Roll the next set of dice and store the result
    next_roll_raw <- suppressMessages(dndR::roll(dice = dice, show_dice = F))

    # Remember 2d20 still need to be handled differently every time
    if(dice == "2d20"){
      next_roll <- data.frame("outcome" = sum(next_roll_raw[1], next_roll_raw[2]))
      # If not 2d20, just grab the roll outcome
    } else { next_roll <- data.frame("outcome" = next_roll_raw) }

    # Attach to the object that includes all previous rolls
    roll_results <- dplyr::bind_rows(x = roll_results, y = next_roll) }

  # Identify dice type
  dice_type <- stringr::str_extract(string = dice,
                                    pattern = "d[:digit:]{1,3}")

  # Assemble color palette per dice type (colors roughly match `dndR` hex logo)
  dice_palette <- c("d2" = "#000000", "d3" = "#3c096c", "d4" = "#7209b7",
                    "d6" = "#168aad", "d8" = "#008000", "d10" = "#fca311",
                    "d12" = "#e85d04", "d20" = "#9d0208", "d100" = "#6a040f")

  # Count frequency of each result
  result_freq <- roll_results %>%
    dplyr::group_by(outcome) %>%
    dplyr::summarize(ct = dplyr::n()) %>%
    dplyr::ungroup() %>%
    # Make outcome column a factor
    dplyr::mutate(outcome_fact = as.factor(outcome),
                  .before = outcome)

  # Identify median outcome
  med_roll <- stats::median(x = roll_results$outcome, na.rm = TRUE)

  # Create plot
  prob_plot <- ggplot2::ggplot(data = result_freq,
                               mapping = ggplot2::aes(x = outcome_fact, y = ct,
                                                      fill = dice_type)) +
    # Add line for median
    ggplot2::geom_vline(xintercept = factor(med_roll), linetype = 2, linewidth = 1.2,
               color = dice_palette[names(dice_palette) == dice_type]) +
    # Add outcome frequency bars
    ggplot2::geom_bar(stat = 'identity', alpha = 0.8) +
    # Add custom X/Y axis titles
    ggplot2::labs(x = "Roll Result", y = paste0("Frequency (", roll_num, " Rolls)")) +
    # Handle plot formatting (consistent with other plotting functions in the package)
    ggplot2::scale_fill_manual(values = dice_palette) +
    ggplot2::theme_classic() +
    ggplot2::theme(legend.position = "none",
          axis.title.x = ggplot2::element_text(size = 16),
          axis.title.y = ggplot2::element_text(size = 15),
          axis.text = ggplot2::element_text(size = 13))

  # Return the plot object
  return(prob_plot) }
