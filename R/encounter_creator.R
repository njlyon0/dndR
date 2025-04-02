#' @title Balance a Combat Encounter for Given Party Composition and Difficulty
#'
#' @description Identifies set of creature XP values that constitute a balanced encounter of specified difficulty for given party composition information (i.e., average player character level and number of party members). Creature selection is semi-random so re-running this function will return similar but not necessarily identical results. It is not always possible to exactly spend all available XP so the true maximum XP and the realized XP (see `?dndR::xp_pool` and `?dndR::xp_cost`) are both returned in the output for context. This function _will not_ exceed the allowed XP so you may need to alter the party information and/or difficulty arguments in order to return an encounter that meets your needs.
#'
#' @param party_level (numeric) integer indicating the average party level. If all players are the same level, that level is the average party level
#' @param party_size (numeric) integer indicating how many player characters (PCs) are in the party
#' @param ver (character) which version of fifth edition to use ("2014" or "2024")
#' @param difficulty (character) one of a specific set of encounter difficulty level names. If `ver = "2014"`, this must be one of "easy", "medium", "hard", or "deadly" while for `ver = "2024"` it must instead be one of "low", "moderate", or "high"
#' @param max_creatures (numeric) _optional_ maximum number of allowed creatures. The 2024 version especially skews towards including more creatures (especially at higher difficulty levels) so this argument allows specifying a maximum number of creatures beyond whatever mathematically-appropriate number this function identifies. This is hopefully a convenience for GMs to not have to run dozens of enemies for higher-level parties. If not specified, then there is no maximum number of creatures in the returned random encounter's XP dataframe
#' @param try (numeric) integer indicating the number of attempts to make to maximize encounter XP while remaining beneath the threshold defined by the other parameters
#'
#' @return (dataframe) creature experience point (XP) values as well as the maximum XP for an encounter of the specified difficulty and the realized XP cost of the returned creatures
#' 
#' @importFrom magrittr %>%
#' @importFrom magrittr %<>%
#'
#' @export
#'
#' @examples
#' # Create a hard encounter for a 2-person, 9th level party under the 2014 rules
#' dndR::encounter_creator(party_level = 9, party_size = 2, ver = "2014", difficulty = "hard")
#'
#' # Create a moderate encounter for a 4-person, 5th level party in the 2024 version
#' ## And allow no more than 6 creatures
#' encounter_creator(party_level = 5, party_size = 4, ver = "2024", 
#'                   difficulty = "moderate", max_creatures = 6)
#'
encounter_creator <- function(party_level = NULL, party_size = NULL,
                              ver = NULL, difficulty = NULL,
                              max_creatures = NULL, try = 5){
  # Silence visible bindings note
  creature_xp <- attempt_num <- creature_count <- count_cumsum <- NULL
  
  # Maximum number of monsters error check (if it is provided)
  if(is.null(max_creatures) != TRUE){
    if(is.numeric(max_creatures) != TRUE || length(max_creatures) != 1 || max_creatures < 1)
      stop("'max_creatures' must be defined as a single, positive number or left blank")
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
