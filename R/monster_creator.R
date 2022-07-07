#' @title Creates a Monster for Given Party Level and Size
#'
#' @description Returns the vital statistics of a randomized monster based on a the average player level and number of players in the party. This function follows the advice of [Zee Bashew](https://twitter.com/Zeebashew) on how to build interesting, challenging monsters for your party. These monsters are built somewhat according to the Dungeon Master's Guide for creating monsters, partly Zee's [YouTube video on homebrewing monsters based on The Witcher videogame](https://www.youtube.com/watch?v=GhjkPv4qo5w), and partly on my own sensibilities about scaling the difficulty of a creature. Creatures are spawned randomly so you may need to re-run the function several times (or mentally modify one or more parts of the output) to get a monster that fits your campaign and players, but the vulernabilities and resistances should allow for cool quest building around what this function provides. Happy DMing!
#'
#' @param party_level a number indicating the average party level. If all players are the same level, that level is the average party level
#' @param party_size a number indicating how many player characters (PCs) are in the party
#'
#' @importFrom magrittr %>%
#'
#' @examples
#' # Creates a monster from the specified average party level
#' monster_creator(party_level = 4, party_size = 3)
#'
#' @export
monster_creator <- function(party_level = NULL, party_size = NULL){
  # Squelch 'visible bindings' note
  HP_Average <- Hit_Points <- Armor_Class <- Prof_Bonus <- Attack_Bonus <- NULL
  Save_DC <- score <- ability_actual <- modifier <- NULL

  # Provide errors for missing / improper argument specifications
  if(base::is.null(party_level) | base::is.null(party_size))
    stop("Party level and party size must be provided")
  if(base::is.numeric(party_level) != TRUE | base::is.numeric(party_size) != TRUE)
    stop("Party level and party size must be numeric.")

  # Identify challenge rating based on party size / level
  ## Roughly modify party level based on party size
  if(party_size <= 3){ party_lvl_mod <- party_level - 1}
  if(party_size > 3 & party_size <= 5){ party_lvl_mod <- party_level}
  if(party_size > 5){ party_lvl_mod <- party_level + 2}
  ## Account for parties of <3 at level 1 (above step sets 'party_lvl_mod' to 0)
  if(party_lvl_mod == 0){ party_lvl_actual <- 1 } else { party_lvl_actual <- party_lvl_mod }
  ## Calculate CR
  cr_actual <- party_lvl_actual + 3

  # Identify the DMG's recommendation for that monster
  monster_raw <- dndR::monster_stats(cr = cr_actual)

  # Wrangle that dataframe
  monster_slim <- monster_raw %>%
    dplyr::mutate(Hit_Points = base::ceiling(HP_Average / 2)) %>%
    dplyr::select(Hit_Points, Armor_Class, Prof_Bonus, Attack_Bonus, Save_DC)

  # Calculate other needed metrics ----
  ## Which saving throws does it have proficiency in?
  saving_throws <- base::sample(x = c("STR", "DEX", "CON",  "INT", "WIS", "CHA"),
                                size = 2, replace = FALSE)
  ## Identify vulnerabilities, resistances, and immunities
  vulnerable <- base::sample(x = base::setdiff(dnd_damage_types(), "non-magical damage"),
                                 size = 1, replace = FALSE)
  resistant <- base::sample(x = base::setdiff(dnd_damage_types(), vulnerable),
                            size = base::ifelse(test = (cr_actual > 5), yes = 5,
                                                no = cr_actual), replace = FALSE)
  immune <- base::sample(x = base::setdiff(dnd_damage_types(), c(vulnerable, resistant, "non-magical damage")),
                            size = base::ifelse(test = (cr_actual > 6), yes = 2,
                                                no = base::floor(cr_actual / 3)), replace = FALSE)

  # Identify ability scores and modifiers ----
  ## Roll for scores
  monster_scores <- base::suppressMessages(dndR::ability_scores(method = "4d6")) %>%
    # Put a minimum value on scores
    dplyr::mutate(score = base::ifelse(test = (score < 10), yes = 10, no = score)) %>%
    dplyr::mutate(
      # Add ability abbreviations
      ability_actual = c("STR", "DEX", "CON", "INT", "WIS", "CHA"),
      # Modify the raw scores based on CR
      score = dplyr::case_when(
        cr_actual > 20 ~ (score + 10),
        cr_actual > 10 & score <= 20 ~ (score + 5),
        cr_actual > 5 & score <= 10 ~ (score + 2),
        TRUE ~ score) ) %>%
    # Identify roll modifiers
    dplyr::mutate(
      ability_actual = paste0(ability_actual, "_Modifier"),
      modifier = dplyr::case_when(
        score %in% c(10, 11) ~ '0',
        score %in% c(12, 13) ~ '+1',
        score %in% c(14, 15) ~ '+2',
        score %in% c(16, 17) ~ '+3',
        score %in% c(18, 19) ~ '+4',
        score %in% c(20, 21) ~ '+5',
        score %in% c(22, 23) ~ '+6',
        score %in% c(24, 25) ~ '+7',
        score %in% c(26, 27) ~ '+8',
        score %in% c(28, 29) ~ '+9',
        score %in% c(30) ~ '+10') ) %>%
    # Pare down to needed columns
    dplyr::select(ability_actual, modifier) %>%
    # Reshape to wide format
    tidyr::pivot_wider(names_from = ability_actual, values_from = modifier) %>%
    as.data.frame()

  # Combine everything into a coherent stat block ----
  monster_expanded <- monster_slim %>%
    dplyr::mutate(
      ## Proficient saving throws
      Prof_Saving_Throws = paste(saving_throws, collapse = "; "),
      ## vulnerability, resistance, and immunity
      Immune_to = base::ifelse(test = base::length(immune > 0),
                               yes = paste(immune, collapse = "; "),
                               no = "-"),
      Resistant_to = paste(resistant, collapse = "; "),
      Vulnerable_to = paste(vulnerable, collapse = "; ")
    ) %>%
    # Bind on score modifiers
    base::cbind(monster_scores)

  # Pivot to long format to make it easier to scan through quickly
  monster_block <- monster_expanded %>%
    # Turn all columns to characters
    dplyr::mutate(dplyr::across(dplyr::everything(), base::as.character)) %>%
    # Reshape the data
    tidyr::pivot_longer(cols = dplyr::everything(),
                        names_to = "statistic",
                        values_to = "value") %>%
    # Make it a dataframe
    base::as.data.frame()

  # Return the finished product
  return(monster_block)
}
