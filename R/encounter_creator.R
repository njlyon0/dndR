#' @title Balance a Combat Encounter for Given Party Composition and Difficulty
#'
#' @description Identifies set of creature XP values that constitute a balanced encounter of specified difficulty for given party composition information (i.e., average player character level and number of party members). Creature selection is semi-random so re-running this function will return similar but not necessarily identical results. It is not always possible to exactly spend all available XP so the true maximum XP and the realized XP (see `?dndR::xp_pool` and `?dndR::xp_cost`) are both returned in the output for context. This function _will not_ exceed the allowed XP so you may need to alter the party information and/or difficulty arguments in order to return an encounter that meets your needs.
#'
#' @param party_level (numeric) integer indicating the average party level. If all players are the same level, that level is the average party level
#' @param party_size (numeric) integer indicating how many player characters (PCs) are in the party
#' @param difficulty (character) one of "easy", "medium", "hard", or "deadly" for the desired difficulty of the encounter
#'
#' @return (dataframe) creature experience point (XP) values as well as the maximum XP for an encounter of the specified difficulty and the realized XP cost of the returned creatures
#' @importFrom magrittr %>%
#' @importFrom magrittr %<>%
#'
#' @export
#'
#' @examples
#' # Create a hard encounter for a 2-person, 9th level party
#' encounter_creator(party_level = 9, party_size = 2, difficulty = "hard")
#'
encounter_creator <- function(party_level = NULL, party_size = NULL, difficulty = NULL){
  # Silence visible bindings note
  creature_xp <- NULL

  # Identify all possible XP values for creatures
  available <- data.frame("creature_xp" = c(10, 25, 50, 100, 200, 450,
                                            700, 1100, 1800, 2300, 2900,
                                            3900, 5000, 5900, 7200, 8400,
                                            8900, 10000, 11500, 13000,
                                            15000, 18000, 20000, 22000, 25000,
                                            33000, 41000, 50000, 62000, 62500,
                                            75000, 90000, 105000, 155000, 330000))

  # Calculate maximum allowed XP for this encounter
  max_xp <- dndR::xp_pool(party_level = party_level, party_size = party_size, difficulty = difficulty)

  # Put a ceiling on that to be able to include more creatures
  capped_xp <- ceiling(x = max_xp - (max_xp * 0.65))

  # Pick the difficulty of the first (hardest) creature in the encounter
  picked <- available %>%
    # Choose highest possible XP that is still less than the capped XP
    dplyr::filter(creature_xp == max(creature_xp[creature_xp < capped_xp]))

  # Calculate spent XP for this creature
  spent_xp <- xp_cost(monster_xp = sum(picked$creature_xp),
                      monster_count = nrow(picked),
                      party_size = party_size)

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

    # Pick a random XP value
    ## Need to do this as a conditional because `sample` is unreliable when length is < 1
    if(length(xp_levels) > 1){
      xp_value <- sample(x = xp_levels, size = 1)
    } else { xp_value <- xp_levels }

    # See if including a creature of that XP is still below the threshold
    (possible_cost <- xp_cost(monster_xp = sum(c(picked$creature_xp, xp_value)),
                              monster_count = nrow(picked) + 1,
                              party_size = party_size))

    # If this would be below the maximum allowed XP...
    if(possible_cost < max_xp){

      # Choose one candidate creature
      candidate <- available %>%
        dplyr::filter(creature_xp == xp_value)

      # Add this to the picked set of creatures
      picked <- picked %>%
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

  # Final processing
  encounter_info <- picked %>%
    # Count number of creatures per XP value
    dplyr::group_by(creature_xp) %>%
    dplyr::summarize(creature_count = dplyr::n()) %>%
    dplyr::ungroup() %>%
    # Arrange by XP
    dplyr::arrange(dplyr::desc(creature_xp)) %>%
    # Add some nice diagnostics to the picked dataframe
    dplyr::mutate(encounter_xp_pool = max_xp,
                  encounter_xp_cost = spent_xp)

  # Return encounter information
  return(encounter_info) }
