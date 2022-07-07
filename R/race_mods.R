#' @title Identify Race-Based Ability Modifiers
#'
#' @description Identify the race-based ability modifiers identified in the Player's Handbook (PHB).
#'
#' @param race character string of race (supported classes returned by `dnd_races()`)
#'
#' @return a dataframe of two columns and as many rows as there are abilities modified by the race.
#'
#' @importFrom magrittr %>%
#' @export
#'
#' @examples
#' # Identifies race modifiers of provided race
#' race_mods(race = "mountain dwarf")
#'
race_mods <- function(race = NULL){
  # If scores have been rolled but dataframe hasn't been provided, error out
  if(is.null(race) | !base::tolower(race) %in% dnd_races())
    stop("Race not in supported set. See `dnd_races()` for list of supported entries. Submit an issue on the GitHub repository (github.com/njlyon0/dndR) if you want a race added.")

  # Create an empty dataframe to hold modifiers
  empty_block <- data.frame('ability' = base::as.factor(c("STR", "DEX", "CON",
                                                          "INT", "WIS", "CHA")),
                            'modifier' = base::rep(x = 0, times = 6))

  # Depending on race, modify the dataframe as needed
  ## A
  if(base::tolower(race) == "aarakocra"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "DEX" ~ 2, ability == "WIS" ~ 1, TRUE ~ modifier)) }
  ## D
  if(base::tolower(race) == "dark elf" |
     base::tolower(race) == "drow"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "DEX" ~ 2, ability == "CHA" ~ 1, TRUE ~ modifier)) }
  if(base::tolower(race) == "dragonborn"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "STR" ~ 2, ability == "CHA" ~ 1, TRUE ~ modifier)) }
  ## F
  if(base::tolower(race) == "forest gnome"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "INT" ~ 2, ability == "DEX" ~ 1, TRUE ~ modifier)) }
  ## H
  if(base::tolower(race) == "half elf" |
     base::tolower(race) == "half-elf"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "CHA" ~ 2, TRUE ~ modifier))
  base::message("Half elves get +1 to two (non-CHA) abilities. You'll need to do that manually.") }
  if(base::tolower(race) == "half orc" |
     base::tolower(race) == "half-orc"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "STR" ~ 2, ability == "CON" ~ 1, TRUE ~ modifier)) }
  if(base::tolower(race) == "high elf"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "DEX" ~ 2, ability == "INT" ~ 1, TRUE ~ modifier)) }
  if(base::tolower(race) == "hill dwarf"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "CON" ~ 2, ability == "WIS" ~ 1, TRUE ~ modifier)) }
  if(base::tolower(race) == "human"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "STR" ~ 1, ability == "CON" ~ 1,
      ability == "DEX" ~ 1, ability == "INT" ~ 1,
      ability == "WIS" ~ 1, ability == "CHA" ~ 1)) }
  ## L
  if(base::tolower(race) == "lightfoot halfling"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "DEX" ~ 2, ability == "CHA" ~ 1, TRUE ~ modifier)) }
  ## M
  if(base::tolower(race) == "mountain dwarf"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "CON" ~ 2, ability == "STR" ~ 2, TRUE ~ modifier)) }
  ## P
  if(base::tolower(race) == "plasmoid"){ block <- empty_block
  message("Plasmoids get +2 to one ability and +1 to another OR +1 to three abilities. You'll need to do that manually.") }
  ## R
  if(base::tolower(race) == "rock gnome"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "INT" ~ 2, ability == "CON" ~ 1, TRUE ~ modifier)) }
  ## S
  if(base::tolower(race) == "stout halfling"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "DEX" ~ 2, ability == "CON" ~ 1, TRUE ~ modifier)) }
  ## T
  if(base::tolower(race) == "tiefling"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "CHA" ~ 2, ability == "INT" ~ 1, TRUE ~ modifier)) }
  ## W
  if(base::tolower(race) == "wood elf"){ block <- empty_block %>%
    dplyr::mutate(modifier = dplyr::case_when(
      ability == "DEX" ~ 2, ability == "WIS" ~ 1, TRUE ~ modifier)) }
  # if(base::tolower(race) == ""){ block <- empty_block %>%
  #   dplyr::mutate(modifier = dplyr::case_when(
  #     ability == "" ~ 0, ability == "" ~ 0, TRUE ~ modifier)) }

  # Return filled block
  return(block)
}

