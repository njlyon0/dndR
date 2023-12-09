# Working on a re-roll function

# Start by loading needed libraries
library(dndR); library(tidyverse)

# Clear environment
rm(list = ls())

# Make a vector of dice rolls
(vals <- c(1, 5, 3, 7, 1))

# Define dice type
dice_type <- "d8"

# Identify number of sides (without "d")
dice_faces <- as.numeric(gsub(pattern = "d", replacement = "", x = dice_type))

# If any are 1s...
if(1 %in% vals){

  # Message
  message("Re-rolling 1s")

  # Count number of dice to re-roll
  reroll_ct <- sum(vals == 1, na.rm = F)

  # Re-roll with the specified dice type
  new_vals <- base::sample(x = 1:dice_faces, size = reroll_ct)

  # Drop 1s in original result
  no_1s <- setdiff(x = vals, y = 1)

  # Attach the new rolls to the old rolls without 1s
  full_vals <- c(no_1s, new_vals)

}




