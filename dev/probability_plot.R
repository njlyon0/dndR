
# Testing ground for a plot that takes the input dice and creates a plot their possible outcomes

# Load dndR
library(dndR)

# Specify the dice to roll
dice_arg <- "2d6"

# Make a starter dataframe
( roll_results <- data.frame("outcome" = dndR::roll(dice = dice_arg, show_dice = F)) )

# Roll several times and store results
for(k in 1:999){

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


# Load ggplot2
library(ggplot2)

# Create a plot of this
ggplot(data = roll_results, mapping = aes(x = outcome)) +
  geom_violin(stat = "ydensity")


