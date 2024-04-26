#' @title Choose Creatures for a Combat Encounter of Given Party Composition and Difficulty
#'
#' @description Creates a balanced encounter of specified difficulty and user-specified party composition information (i.e., average player character level and number of party members). Users may optionally specify a particular type of creature (e.g., humanoid, construct, etc.) and potential creatures will be narrowed to only those of that type. Creature selection is semi-random so re-running this function will return similar but non-exact results. It is not always possible to exactly spend all available XP so the true maximum XP and the realized XP (see `?dndR::xp_cost`) are both returned in the output for context. This function _will not_ exceed the allowed XP so you may need to alter the party information and/or difficulty arguments in order to return the desired set of antagonists.
#'
#' @param party_level (numeric) integer indicating the average party level. If all players are the same level, that level is the average party level
#' @param party_size (numeric) integer indicating how many player characters (PCs) are in the party
#' @param difficulty (character) one of "easy", "medium", "hard", or "deadly" for the desired difficulty of the encounter
#' @param enemy_type (character) optional argument to choose only creatures of a particular type (e.g., undead, elemental, etc.). If the provided type is not found in the available set of creatures (see `?dndR::creatures`) then the argument is disregarded with a warning
#'
#' @return (dataframe) creature types, names, and experience point (XP) values as well as the maximum XP for an encounter of the specified difficulty and the XP cost of the returned creatures
#' @importFrom magrittr %>%
#' @importFrom magrittr %<>%
#'
#' @export
#'
#' @examples
#' # Create a hard encounter against humanoids for a 2-person, 9th level party
#' encounter_creator(party_level = 9, party_size = 2, difficulty = "hard", enemy_type = "humanoid")
#'
encounter_creator <- function(party_level = NULL, party_size = NULL,
                              difficulty = NULL, enemy_type = NULL){
  # Silence visible bindings note
  . <- creature_xp <- creature_type <- creature_name <- NULL

  # `xp_pool` function will handle argument errors (except 'enemy_type'; see below)

  # Load creature information
  creatures <- dndR::creatures

  # Define the minimum allowed XP value of a creature
  weakest_xp <- 10

  # If enemy type is null
  if(is.null(enemy_type) == TRUE){

    # Just simplify the creature data
    available <- creatures %>%
      dplyr::filter(creature_xp > weakest_xp & !is.na(creature_xp)) %>%
      dplyr::select(creature_type, creature_name, creature_xp)

    # If enemy type is not null & is in the data
  } else if(is.null(enemy_type) != TRUE &
            any(stringr::str_detect(string = unique(creatures$creature_type),
                                    pattern = enemy_type)) == TRUE){

    # Simplify **and filter** the creature data
    available <- creatures %>%
      dplyr::filter(creature_xp > weakest_xp & !is.na(creature_xp)) %>%
      dplyr::select(creature_type, creature_name, creature_xp) %>%
      dplyr::filter(stringr::str_detect(string = creature_type, pattern = enemy_type))

    # If enemy type is not null but isn't in the data
  } else if(is.null(enemy_type) != TRUE &
            any(stringr::str_detect(string = unique(creatures$creature_type),
                                    pattern = enemy_type)) == FALSE){

    # Warning message
    rlang::warn("Enemy type not found in data. Including all enemy types as possibilities")

    # Do same processing as when it isn't supplied
    available <- creatures %>%
      dplyr::filter(creature_xp > weakest_xp & !is.na(creature_xp)) %>%
      dplyr::select(creature_type, creature_name, creature_xp)

  } # Close conditional

  # Calculate maximum allowed XP for this encounter
  max_xp <- dndR::xp_pool(party_level = party_level, party_size = party_size,
                          difficulty = difficulty)

  # Put a ceiling on that to be able to include more creatures
  capped_xp <- ceiling(x = max_xp - (max_xp * 0.65))

  # Pick the first creature of the encounter
  picked <- available %>%
    # Choose highest possible XP that is still less than the capped XP
    dplyr::filter(creature_xp == max(creature_xp[creature_xp < capped_xp])) %>%
    # Pick one row of the result (if more than one)
    dplyr::slice_sample(.data = ., n = 1)

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
        dplyr::filter(creature_xp == xp_value) %>%
        dplyr::slice_sample(.data = ., n = 1)

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

  # Add some nice diagnostics to the picked dataframe
  encounter_info <- picked %>%
    dplyr::mutate(encounter_xp_pool = max_xp,
                  encounter_xp_cost = spent_xp)

  # Return encounter information
  return(encounter_info) }
