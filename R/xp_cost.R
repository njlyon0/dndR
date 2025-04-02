#' @title Adjust the XP Total by Number of Monsters and Party Size
#'
#' @description In the 2014 version of fifth edition Dungeons and Dragons, encounters are more difficult than the total of the monsters' experience points (XP). Both the number of monsters making attacks and the number of players attacking those creatures can affect the difficulty of an encounter. The 2014 Dungeon Master's Guide (DMG) accounts for this by providing an XP multiplier for given party sizes and numbers of monsters. This function accepts the unmodified total of the monsters' XP and adjusts this as specified in the DMG without the pain of the tables in that book. For the 2024 version, the XP cost is exactly equal to the total monster XP so this function will return a warning and whatever value is passed to the `monster_xp` argument if the 2024 version is specified.
#'
#' @param monster_xp (numeric) XP total across all monsters
#' @param monster_count (numeric) count for the number of monsters in the encounter
#' @param party_size (numeric) value for the number of PCs in the party
#' @param ver (character) which version of fifth edition to use ("2014" or "2024")
#' 
#' @return (numeric) value for "realized" XP
#' 
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' # Calculate the realized XP from the raw XP, number of monsters, and number of PCs
#' dndR::xp_cost(monster_xp = 100, monster_count = 3, party_size = 2, ver = "2014")
#'
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
