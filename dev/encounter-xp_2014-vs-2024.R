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

## ---------------------------- ##
# `xp_pool` Update ----
## ---------------------------- ##

# Clear environment (again)
rm(list = ls()); gc()

# Define new function
xp_pool <- function(party_level = NULL, party_size = NULL, ver = NULL, difficulty = NULL){
    
  # Party level must be specified as a single number
  if(is.null(party_level) || is.numeric(party_level) != TRUE || length(party_level) != 1)
    stop("'party_level' must be defined as a single number")
  
  # Same error check for party size
  if(is.null(party_size) || is.numeric(party_size) != TRUE || length(party_size) != 1)
    stop("'party_size' must be defined as a single number")
  
  # Similar error check for version
  if(is.null(ver) || is.character(ver) != TRUE || length(ver) != 1 || ver %in% c("2014", "2024") != TRUE)
    stop("'ver' must be one of either '2014' or '2024'")
  
  # Make sure difficulty is lowercase
  diff_lcase <- tolower(x = difficulty)
  
  # Regardless of version, difficulty must be provided as a single value
  if(is.null(diff_lcase) || length(diff_lcase) != 1 || is.character(diff_lcase) != TRUE)
    stop("'difficulty' must be provided as a single character value")
  
  # 5e 2014 version ----
  # Calculate XP pool for the 2014 version of 5e
  if(ver == "2014") {
    
    # Error out if difficulty is not a supported level for this version of D&D
    if(diff_lcase %in% c("easy", "medium", "hard", "deadly") != TRUE)
      stop("For the 2014 version, 'difficulty' must be one of 'easy', 'medium', 'hard', 'deadly'")
    
    # Define XP-player level table from 2014 DMG
    xp14_df <- data.frame("pc_level" = 1:20,
                          "xp" = c(25, 50, 75, 125, 250, # 1-5
                                   300, 350, 450, 550, 600, # 6-10
                                   800, 1000, 1100, 1250, 1400, # 11-15
                                   1600, 2000, 2100, 2400, 2800)) # 16-20
    
    # Grab the highest XP value without exceeding the player's average level
    easy_xp <- xp14_df %>% 
      dplyr::filter(pc_level <= party_level) %>% 
      utils::tail(n = 1) %>% 
      dplyr::pull(xp)
      
    # Now multiply as needed for the desired difficulty
    ## Straight from a table in the DMG
    if(diff_lcase == "easy"){ pc_xp <- easy_xp }
    if(diff_lcase == "medium"){ pc_xp <- (easy_xp * 2) }
    if(diff_lcase == "hard"){ pc_xp <- (easy_xp * 3) }
    if(diff_lcase == "deadly"){ pc_xp <- (easy_xp * 4) }
    
  } # Close 2014 version conditional
  
  # 5e 2024 version ----
  if(ver == "2024"){
    
    # Error out if difficulty is not a supported level for this version of D&D
    if(diff_lcase %in% c("low", "moderate", "high") != TRUE)
      stop("For the 2024 version, 'difficulty' must be one of 'low', 'moderate', 'high'")
    
    # Define XP-player level table from 2024 DMG
    xp24_df <- data.frame("pc_level" = 1:20,
                          "low" = c(50, 100, 150, 250, 500, # 1-5
                                       600, 750, 1000, 1300, 1600, # 6-10
                                       1900, 2200, 2600, 2900, 3300, # 11-15
                                       3800, 4500, 5000, 5500, 6400), # 16-20
                          "moderate" = c(75, 150, 225, 375, 750, # 1-5
                                         1000, 1300, 1700, 2000, 2300, # 6-10
                                         2900, 3700, 4200, 4900, 5400, # 11-15
                                         6100, 7200, 8700, 10700, 13200), # 16-20
                          "high" = c(100, 200, 400, 500, 1100, # 1-5
                                     1400, 1700, 2100, 2600, 3100, # 6-10
                                     4100, 4700, 5400, 6200, 7800, # 11-15
                                     9800, 11700, 14200, 17200, 22000)) # 16-20
    
    # Process that table
    xp_row <- xp24_df %>%
      # Grab the single highest player level without exceeding the party's average level
      dplyr::filter(pc_level <= party_level) %>% 
      utils::tail(n = 1)

    # Grab the XP column corresponding to the desired difficulty
    pc_xp <- xp_row[[diff_lcase]]

  } # Close 2024 version conditional
  
  # Regardless of version, multiply per-player XP by the number of PCs in the party
  party_xp <- (pc_xp * party_size)
  
  # And round that to the nearest integer
  xp_actual <- round(party_xp, digits = 0)
  
  # Return the calculated party-level XP
  return(xp_actual) }

# Invoke it
xp_pool(party_level = 7, party_size = 4, ver = "2014", difficulty = "DEADLY")
xp_pool(party_level = 7, party_size = 4, ver = "2024", difficulty = "HiGh")

# End ----
