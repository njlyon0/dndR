#' @title Identify Race-Based Ability Modifiers
#'
#' @description Identify the race-based ability modifiers identified in the Player's Handbook (PHB).
#'
#' @param race (character) string of race (supported classes returned by `dndR::dnd_races()`). Also supports "random" and will randomly select a supported race
#'
#' @return (dataframe) two columns and as many rows as there are abilities modified by the race
#' 
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' # Identifies race modifiers of provided race
#' dndR::race_mods(race = "mountain dwarf")
#'
race_mods <- function(race = NULL){
  # Error out if race is not specified or is not in the supported set
  if(is.null(race) || is.character(race) != TRUE || length(race) != TRUE || tolower(race) %in% c(dndR::dnd_races(), "random") != TRUE)
    stop("Race must be provided as part of the supported set. See `dndR::dnd_races()` for list of supported entries. Submit a GitHub Issue to get support for additional player character races")
  
  # Make race lowercase for ease of later operations
  race_lcase <- tolower(race)
  
  # Pick random race if that is specified
  if(race_lcase == "random"){
    race_lcase <- sample(x = dndR::dnd_races(), size = 1)
    message("Random class selected: ", race_lcase) }
  
  # Create an empty dataframe to hold modifiers
  empty_block <- data.frame('ability' = base::as.factor(c("STR", "DEX", "CON",
                                                          "INT", "WIS", "CHA")),
                            'modifier' = base::rep(x = 0, times = 6))
  
  # Depending on race, modify the dataframe as needed
  ## A
  if(race_lcase == "aarakocra"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "DEX" ~ 2,
        ability == "WIS" ~ 1,
        TRUE ~ modifier)) }
  
  ## B
  if(race_lcase == "bugbear"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "STR" ~ 2,
        ability == "DEX" ~ 1,
        TRUE ~ modifier)) }
  
  ## C
  if(race_lcase == "changeling"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "CHA" ~ 2,
        TRUE ~ modifier))
    
    message("Changelings get +1 to one (non-CHA) ability. You'll need to do that manually.") }
  
  ## D
  if(race_lcase %in% c("dark elf", "drow")){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "DEX" ~ 2,
        ability == "CHA" ~ 1,
        TRUE ~ modifier)) }
  
  if(race_lcase == "dragonborn"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "STR" ~ 2,
        ability == "CHA" ~ 1,
        TRUE ~ modifier)) }
  
  ## F
  if(race_lcase == "forest gnome"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "INT" ~ 2,
        ability == "DEX" ~ 1,
        TRUE ~ modifier)) }
  
  ## G
  if(race_lcase == "goblin"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "DEX" ~ 2,
        ability == "CON" ~ 1,
        TRUE ~ modifier)) }
  ## H
  if(race_lcase %in% c("half elf", "half-elf")){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "CHA" ~ 2,
        TRUE ~ modifier))
    
    message("Half elves get +1 to two (non-CHA) abilities. You'll need to do that manually.") }
  
  if(race_lcase %in% c("half orc", "half-orc")){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "STR" ~ 2,
        ability == "CON" ~ 1,
        TRUE ~ modifier)) }
  
  if(race_lcase == "high elf"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "DEX" ~ 2,
        ability == "INT" ~ 1,
        TRUE ~ modifier)) }
  
  if(race_lcase == "hill dwarf"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "CON" ~ 2,
        ability == "WIS" ~ 1,
        TRUE ~ modifier)) }
  
  if(race_lcase == "hobgoblin"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "CON" ~ 2,
        ability == "INT" ~ 1,
        TRUE ~ modifier)) }
  
  if(race_lcase == "human"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "STR" ~ 1, ability == "CON" ~ 1,
        ability == "DEX" ~ 1, ability == "INT" ~ 1,
        ability == "WIS" ~ 1, ability == "CHA" ~ 1)) }
  
  ## K
  if(race_lcase == "kalashtar"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "WIS" ~ 2,
        ability == "CHA" ~ 1,
        TRUE ~ modifier)) }
  
  ## L
  if(race_lcase == "lightfoot halfling"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "DEX" ~ 2,
        ability == "CHA" ~ 1,
        TRUE ~ modifier)) }
  
  ## M
  if(race_lcase == "mountain dwarf"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "CON" ~ 2,
        ability == "STR" ~ 2,
        TRUE ~ modifier)) }
  
  ## O
  if(race_lcase == "orc"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "STR" ~ 2,
        ability == "CON" ~ 1,
        TRUE ~ modifier)) }
  
  ## P
  if(race_lcase == "plasmoid"){
    block <- empty_block
    message("Plasmoids get +2 to one ability and +1 to another OR +1 to three abilities. You'll need to do that manually.") }
  
  ## R
  if(race_lcase == "rock gnome"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "INT" ~ 2,
        ability == "CON" ~ 1,
        TRUE ~ modifier)) }
  
  ## S
  if(race_lcase == "shifter"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "CON" ~ 2,
        ability == "STR" ~ 1,
        TRUE ~ modifier)) }
  
  if(race_lcase == "stout halfling"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "DEX" ~ 2,
        ability == "CON" ~ 1,
        TRUE ~ modifier)) }
  
  ## T
  if(race_lcase == "tiefling"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "CHA" ~ 2,
        ability == "INT" ~ 1,
        TRUE ~ modifier)) }
  
  ## W
  if(race_lcase == "warforged"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "CON" ~ 2,
        TRUE ~ modifier))
    
    message("Warforged get +1 to one (non-CON) ability. You'll need to do that manually.") }
  
  if(race_lcase == "wood elf"){
    block <- empty_block %>%
      dplyr::mutate(modifier = dplyr::case_when(
        ability == "DEX" ~ 2,
        ability == "WIS" ~ 1,
        TRUE ~ modifier)) }
  
  ### TEMPLATE
  # if(race_lcase == ""){
  # block <- empty_block %>%
  #   dplyr::mutate(modifier = dplyr::case_when(
  #     ability == "" ~ 2, ability == "" ~ 1, TRUE ~ modifier)) }
  
  # Return filled block
  return(block) }
