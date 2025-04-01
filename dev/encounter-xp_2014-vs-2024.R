## ----------------------------------------------------- ##
# Encounter XP Thresholds 2014 vs 2024
## ----------------------------------------------------- ##
# With the new rules changes in the 2024 version of D&D 5e, encounter balancing has shifted

# 2014 versus 2024 encounter balancing differs in the following ways:
## - Different difficulty levels
## - No algebraic accounting for party size / monster count
## - Different relationship of XP-to-party level (maybe?? Need to check)

## ---------------------------- ##
# Housekeeping ----
## ---------------------------- ##

# Load libraries
librarian::shelf(tidyverse, dndR, supportR)

# Clear environment
rm(list = ls()); gc()

## ---------------------------- ##
# Demo Plotting ----
## ---------------------------- ##
# Grab 2014 ref table for XP for easy encounters at different party levels
xp14 <- data.frame('ver' = 2014,
                   'pc_level' = 1:20,
                   'easy_xp' = c(25, 50, 75, 125, 250, 300, 350, 450,
                                 550, 600, 800, 1000, 1100, 1250, 1400,
                                 1600, 2000, 2100, 2400, 2800))

# Grab the same table for 2024
xp24 <- data.frame('ver' = 2024,
                   'pc_level' = 1:20,
                   'easy_xp' = c(50, 100, 150, 250, 500, 600, 750, 1000, 1300, 1600, 1900, 2200, 2600, 2900, 3300, 3800, 4500, 5000, 5500, 6400))

# Combine
xp_df <- dplyr::bind_rows(xp14, xp24)

# Make a simple graph
ggplot(xp_df, aes(x = pc_level, y = easy_xp, color = as.factor(ver))) +
  geom_point() + 
  supportR::theme_lyon()

## ---------------------------- ##
# 2024 Difficulty Levels ----
## ---------------------------- ##

# Want to make sure the slope of the line is the same across difficulty levels

# Generate dataframe
xp24_v2 <- data.frame('ver' = 2024,
                    'pc_level' = 1:20,
                   'low_xp' = c(50, 100, 150, 250, 500, 600, 750, 1000, 1300, 1600, 1900, 2200, 2600, 2900, 3300, 3800, 4500, 5000, 5500, 6400),
                   'moderate_xp' = c(75, 150, 225, 375, 750, 1000, 1300, 1700, 2000, 2300, 2900, 3700, 4200, 4900, 5400, 6100, 7200, 8700, 10700, 13200),
                   'high_xp' = c(100, 200, 400, 500, 1100, 1400, 1700, 2100, 2600, 3100, 4100, 4700, 5400, 6200, 7800, 9800, 11700, 14200, 17200, 22000)) %>% 
  tidyr::pivot_longer(cols = dplyr::ends_with("_xp"),
                      names_to = "difficulty",
                      values_to = "xp") %>% 
  dplyr::mutate(difficulty = gsub("_xp", "", x = difficulty))

# Graph it
ggplot(xp24_v2, aes(x = pc_level, y = xp, color = difficulty)) +
  geom_point() + 
  supportR::theme_lyon()


# End ----
