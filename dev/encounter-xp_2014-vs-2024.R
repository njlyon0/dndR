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

## ----------------------------- ##
# `xp_cost` Update ----
## ----------------------------- ##

# Clear environment (again)
rm(list = ls()); gc()

# Define new function
xp_cost <- function(monster_xp = NULL, monster_count = NULL, party_size = NULL, ver = "2014"){
  # Squelch visible bindings note
  monster_number <- party_category <- NULL
  
  # Monster XP has to be a single numeric value
  if(is.null(monster_xp) || is.numeric(monster_xp) != TRUE || length(monster_xp) != 1)
    stop("'monster_xp' must be specified as a single number")
  
  # Same error for number of monsters
  if(is.null(monster_count) || is.numeric(monster_count) != TRUE || length(monster_count) != 1)
    stop("'monster_count' must be specified as a single number")
  
  # Same error check for party size
  if(is.null(party_size) || is.numeric(party_size) != TRUE || length(party_size) != 1)
    stop("'party_size' must be defined as a single number")
  
  # Similar error check for version
  if(is.null(ver) || is.character(ver) != TRUE || length(ver) != 1 || ver %in% c("2014", "2024") != TRUE)
    stop("'ver' must be one of either '2014' or '2024'")
  
  # Warning for non-2014 version
  if(ver == "2024")
    warning("The 2024 version of fifth edition D&D does not modify monster XP based on either number of monsters or party size")
  
  # Assemble multiplier table (see p. 82 in 2014 DMG)
  multiplier_table_raw <- base::data.frame(
    'party_category' = c('small', 'typical', 'large'),
    'monster_1' = c(1.5, 1, 0.5), 'monster_2' = c(2, 1.5, 1),
    'monster_3' = c(2.5, 2, 1.5), 'monster_4' = c(2.5, 2, 1.5),
    'monster_5' = c(2.5, 2, 1.5), 'monster_6' = c(2.5, 2, 1.5),
    'monster_7' = c(3, 2.5, 2), 'monster_8' = c(3, 2.5, 2),
    'monster_9' = c(3, 2.5, 2), 'monster_10' = c(3, 2.5, 2),
    'monster_11' = c(4, 3, 2.5), 'monster_12' = c(4, 3, 2.5),
    'monster_13' = c(4, 3, 2.5), 'monster_14' = c(4, 3, 2.5),
    'monster_15' = c(5, 4, 3), 'monster_16' = c(6, 5, 4)) %>%
    tidyr::pivot_longer(cols = dplyr::starts_with('monster_'),
                        names_to = "monster_number",
                        values_to = "multiplier") %>%
    dplyr::mutate(monster_number = base::as.numeric(
      base::gsub(pattern = "monster_", replacement = "", monster_number)))
  
  # Subset based on party size
  if(party_size < 3){
    multiplier_table_sub <- dplyr::filter(multiplier_table_raw, party_category == "small") }
  
  if(party_size >= 3 & party_size <= 5){
    multiplier_table_sub <- dplyr::filter(multiplier_table_raw, party_category == "typical") }
  
  if(party_size > 5){
    multiplier_table_sub <- dplyr::filter(multiplier_table_raw, party_category == "large") }
  
  # If the monster count is greater than 16, cap it there
  if(monster_count > 16){
    warning("DMG table only provides information on up to 16 monsters. Setting monster count to 16")
    monster_count <- 16
  }
  
  # Subset further based on number of monsters
  multiplier_actual <- dplyr::filter(multiplier_table_sub,
                                     monster_number == monster_count)$multiplier
  
  # Multiply the provided XP by the identified multiplier
  xp_mult <- (monster_xp * multiplier_actual)
  
  # Round it to the nearest integer
  xp_actual <- round(x = xp_mult, digits = 0)
  
  # Return the relevant value of XP for the specified version
  if(ver == "2014"){
    return(xp_actual)
  } else { return(monster_xp) } }

# Invoke function
xp_cost(monster_xp = 400, monster_count = 2,  party_size = 4, ver = "2014")
xp_cost(monster_xp = 400, monster_count = 2,  party_size = 4, ver = "2024")

## ----------------------------- ##
# `encounter_creator` Update ----
## ----------------------------- ##

# Clear environment (again)
rm(list = ls()); gc()

# Load new XP pool / cost functions
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
xp_cost <- function(monster_xp = NULL, monster_count = NULL, party_size = NULL, ver = "2014"){
  # Squelch visible bindings note
  monster_number <- party_category <- NULL
  
  # Monster XP has to be a single numeric value
  if(is.null(monster_xp) || is.numeric(monster_xp) != TRUE || length(monster_xp) != 1)
    stop("'monster_xp' must be specified as a single number")
  
  # Same error for number of monsters
  if(is.null(monster_count) || is.numeric(monster_count) != TRUE || length(monster_count) != 1)
    stop("'monster_count' must be specified as a single number")
  
  # Same error check for party size
  if(is.null(party_size) || is.numeric(party_size) != TRUE || length(party_size) != 1)
    stop("'party_size' must be defined as a single number")
  
  # Similar error check for version
  if(is.null(ver) || is.character(ver) != TRUE || length(ver) != 1 || ver %in% c("2014", "2024") != TRUE)
    stop("'ver' must be one of either '2014' or '2024'")
  
  # Warning for non-2014 version
  if(ver == "2024")
    warning("The 2024 version of fifth edition D&D does not modify monster XP based on either number of monsters or party size")
  
  # Assemble multiplier table (see p. 82 in 2014 DMG)
  multiplier_table_raw <- base::data.frame(
    'party_category' = c('small', 'typical', 'large'),
    'monster_1' = c(1.5, 1, 0.5), 'monster_2' = c(2, 1.5, 1),
    'monster_3' = c(2.5, 2, 1.5), 'monster_4' = c(2.5, 2, 1.5),
    'monster_5' = c(2.5, 2, 1.5), 'monster_6' = c(2.5, 2, 1.5),
    'monster_7' = c(3, 2.5, 2), 'monster_8' = c(3, 2.5, 2),
    'monster_9' = c(3, 2.5, 2), 'monster_10' = c(3, 2.5, 2),
    'monster_11' = c(4, 3, 2.5), 'monster_12' = c(4, 3, 2.5),
    'monster_13' = c(4, 3, 2.5), 'monster_14' = c(4, 3, 2.5),
    'monster_15' = c(5, 4, 3), 'monster_16' = c(6, 5, 4)) %>%
    tidyr::pivot_longer(cols = dplyr::starts_with('monster_'),
                        names_to = "monster_number",
                        values_to = "multiplier") %>%
    dplyr::mutate(monster_number = base::as.numeric(
      base::gsub(pattern = "monster_", replacement = "", monster_number)))
  
  # Subset based on party size
  if(party_size < 3){
    multiplier_table_sub <- dplyr::filter(multiplier_table_raw, party_category == "small") }
  
  if(party_size >= 3 & party_size <= 5){
    multiplier_table_sub <- dplyr::filter(multiplier_table_raw, party_category == "typical") }
  
  if(party_size > 5){
    multiplier_table_sub <- dplyr::filter(multiplier_table_raw, party_category == "large") }
  
  # If the monster count is greater than 16, cap it there
  if(monster_count > 16){
    warning("DMG table only provides information on up to 16 monsters. Setting monster count to 16")
    monster_count <- 16
  }
  
  # Subset further based on number of monsters
  multiplier_actual <- dplyr::filter(multiplier_table_sub,
                                     monster_number == monster_count)$multiplier
  
  # Multiply the provided XP by the identified multiplier
  xp_mult <- (monster_xp * multiplier_actual)
  
  # Round it to the nearest integer
  xp_actual <- round(x = xp_mult, digits = 0)
  
  # Return the relevant value of XP for the specified version
  if(ver == "2014"){
    return(xp_actual)
  } else { return(monster_xp) } }

# Define new function
encounter_creator <- function(party_level = NULL, party_size = NULL,
                              difficulty = NULL, max_creatures = NULL,
                              ver = NULL, try = 5){
  
  
  # party_level = 5
  # party_size = 4
  # try = 5
  # difficulty = "low"
  # ver = "2024"
  # max_creatures = 6
  
  # Silence visible bindings note
  creature_xp <- attempt_num <- NULL
  
  # Maximum number of monsters error check (if it is provided)
  if(is.null(max_creatures) != TRUE){
    if(is.numeric(max_creatures) != TRUE || length(max_creatures) != 1)
      stop("'max_creatures' must be defined as a single number or left blank")
    ## If no max is given, define the object with a placeholder value (so no creatures are removed from the output)
  } else { max_creatures <- Inf }
  
  # Number of tries must be a single number
  if(is.null(try)|| is.numeric(try) != TRUE || length(try) != 1) {
    warning("'try' must be provided as a single number. Defaulting to 5")
    try <- 5 }
  
  # Calculate maximum allowed XP for this encounter
  max_xp <- xp_pool(party_level = party_level, party_size = party_size, 
                    difficulty = difficulty, ver = ver)
  
  # Put a version-dependent ceiling on that to be able to include more creatures
  if(ver == "2014"){
    capped_xp <- ceiling(x = max_xp - (max_xp * 0.65))
  } else {
    capped_xp <- ceiling(x = max_xp - (max_xp * 0.1)) }
  
  # Make an empty list
  attempt_list <- list()
  
  # Loop across specified number of attempts
  for(k in 1:try){
    
    # Re-set the random seed
    set.seed(seed = sample(x = 10^3, size = 1))
    
    # Identify all possible XP values for creatures
    available <- data.frame("creature_xp" = c(10, 25, 50, 100, 200, 450,
                                              700, 1100, 1800, 2300, 2900,
                                              3900, 5000, 5900, 7200, 8400,
                                              8900, 10000, 11500, 13000,
                                              15000, 18000, 20000, 22000, 25000,
                                              33000, 41000, 50000, 62000, 62500,
                                              75000, 90000, 105000, 155000, 330000))
    
    # Pick the difficulty of the first (hardest) creature in the encounter
    picked <- available %>%
      # Choose highest possible XP that is still less than the capped XP
      dplyr::filter(creature_xp == max(creature_xp[creature_xp < capped_xp]))
    
    # Calculate spent XP for this creature
    if(ver == "2014"){
      spent_xp <- xp_cost(monster_xp = sum(picked$creature_xp),
                          monster_count = nrow(picked),
                          party_size = party_size,
                          ver = "2014")
    } else { spent_xp <- sum(picked$creature_xp) }
    
    # Update set of available creatures
    available %<>%
      # XP value less than (or equal to) remaining XP
      dplyr::filter(creature_xp <= (max_xp - spent_xp) &
                      # And not as tough as the first chosen creature
                      creature_xp < max(picked$creature_xp))
    
    # While there is XP to spend and creatures to spend it on, do so
    while(spent_xp < max_xp & nrow(available) >= 1){
      
      # Identify XP levels of remaining available creatures
      xp_levels <- unique(available$creature_xp)
      
      # Pick the next XP value in a version-dependent way
      ## For 2014, pick a random value
      if(ver == "2014" & length(xp_levels) > 1){
        xp_value <- sample(x = xp_levels, size = 1)
        ## For 2024, pick the maximum remaining value
      } else if(ver == "2024" & length(xp_levels) > 1){
        xp_value <- max(xp_levels)
        ## Regardless of version, if only one level exists, pick it
        ### Need to do this as a conditional because `sample` is unreliable for numbers when length is 1
      } else { xp_value <- xp_levels }
        
      # See if including a creature of that XP is still below the threshold
      if(ver == "2014"){
        possible_cost <- xp_cost(monster_xp = sum(c(picked$creature_xp, xp_value)),
                                        monster_count = nrow(picked) + 1,
                                        party_size = party_size,
                                        ver = "2014")
      } else { possible_cost <- sum(c(picked$creature_xp, xp_value)) }
      
      # If this would be below the maximum allowed XP...
      if(possible_cost < max_xp){
        
        # Choose one candidate creature
        candidate <- available %>%
          dplyr::filter(creature_xp == xp_value)
        
        # Add this to the picked set of creatures
        picked %<>%
          dplyr::bind_rows(candidate)
        
        # Update the 'spent XP' object
        spent_xp <- possible_cost
        
        # If this would be *over* the allowed XP...
      } else {
        
        # Remove all creatures of this value from the set of available creatures
        available %<>%
          dplyr::filter(creature_xp != xp_value)
        
      } # Close `else`
    } # Close while loop
    
    # Process the picked dataframe slightly
    picked_actual <- picked %>% 
      # Count number of creatures per XP value
      dplyr::group_by(creature_xp) %>%
      dplyr::summarize(creature_count = dplyr::n()) %>%
      dplyr::ungroup() %>%
      # Arrange by XP
      dplyr::arrange(dplyr::desc(creature_xp)) %>% 
      # Cumulative sum the creatures
      dplyr::mutate(count_cumsum = cumsum(creature_count)) %>% 
      # Subset to maximum number of allowed creatures
      dplyr::filter(count_cumsum <= max_creatures) %>% 
      # Drop cumulative sum column
      dplyr::select(-count_cumsum)
    
    # Processing attempt information and storing in list
    attempt_list[[paste0("attempt_", k)]] <- picked_actual %>%
      # Add some nice diagnostics to the picked dataframe
      dplyr::mutate(max_xp = max_xp,
                    spent_xp = spent_xp,
                    attempt_num = k)
    
  } # Close attempt loop
  
  # Wrangle attempt information, beginning with unlisting the attempt list
  best_attempt <- purrr::list_rbind(x = attempt_list) %>%
    # Keep only the attempt(s) closest to the maximum
    dplyr::filter(spent_xp == max(spent_xp)) %>%
    # Filter to only the first attempt that worked this way
    dplyr::filter(attempt_num == min(attempt_num))
  
  # Clean the resulting dataframe up a bit
  encounter_info <- best_attempt %>% 
    ## Rename columns more informatively
    dplyr::rename(encounter_xp_pool = max_xp,
                  encounter_xp_cost = spent_xp) %>%
    ## Drop attempt number column
    dplyr::select(-attempt_num)
  
  # Return encounter information
  return(encounter_info) }

# Invoke it
encounter_creator(party_level = 5, party_size = 4, try = 5, max_creatures = 6,
                  difficulty = "easy", ver = "2014")
encounter_creator(party_level = 5, party_size = 4, try = 5, max_creatures = 6,
                  difficulty = "low", ver = "2024")

# Invoke function (for 2024) without max creatures specified
encounter_creator(party_level = 5, party_size = 4, try = 5, 
                  difficulty = "low", ver = "2024")

# End ----
