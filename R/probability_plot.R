
# Testing ground for a plot that takes the input dice and creates a plot their possible outcomes

# Clear environment
rm(list = ls())

# Load dndR
library(dndR)

# Specify the dice to roll
dice_arg <- "1d20"

# Make a starter dataframe
( roll_results <- data.frame("outcome" = dndR::roll(dice = dice_arg, show_dice = F)) )

# Define how many rolls
roll_iter <- 999

# Roll several times and store results
for(k in 1:roll_iter){

# Roll again and store in dataframe
  next_roll <- data.frame("outcome" = dndR::roll(dice = dice_arg, show_dice = F))

  # Attach to starting result object
  roll_results <- dplyr::bind_rows(x = roll_results, y = next_roll)

  # Message success
  message("Roll ", k, " completed")

}

# Check out resulting object
str(roll_results)

# Identify dice type
dice_type <- stringr::str_extract(string = dice_arg,
                                  pattern = "d[:digit:]{1,3}")

# Assemble color palette per dice type
## Colors (roughly) match `dndR` hex logo
dice_palette <- c("d2" = "#000000", "d3" = "#3c096c", "d4" = "#7209b7",
                  "d6" = "#168aad", "d8" = "#008000",
                  "d10" = "#fca311", "d12" = "#e85d04", "d20" = "#9d0208", "d100" = "#6a040f")


# Load ggplot2 and some tidyverse elements
library(ggplot2); library(magrittr); library(dplyr)

# Count frequency of each result
result_freq <- roll_results %>%
  dplyr::group_by(outcome) %>%
  dplyr::summarize(ct = dplyr::n()) %>%
  dplyr::ungroup() %>%
  # Make outcome column a factor
  dplyr::mutate(outcome_fact = as.factor(outcome))

# Check it out
result_freq

# Identify median outcome
med_roll <- median(x = roll_results$outcome, na.rm = TRUE)

# Create plot
ggplot(data = result_freq, aes(x = outcome_fact, y = ct, fill = dice_type)) +
  # Add line for median
  geom_vline(xintercept = factor(med_roll), linetype = 2, linewidth = 1.2,
             color = dice_palette[names(dice_palette) == dice_type]) +
  # Add outcome frequency bars
  geom_bar(stat = 'identity', alpha = 0.8) +
  # Handle plot formatting (consistent with other plotting functions in the package)
  scale_fill_manual(values = dice_palette) +
  theme_classic() +
  theme(legend.position = "none",
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 15),
        axis.text = element_text(size = 13)) +
  labs(x = "Roll Result", y = paste0("Frequency (", roll_iter, " Rolls)"))

