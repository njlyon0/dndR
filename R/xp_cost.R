#' @title Adjust the XP Total by Number of Monsters and Party Size
#'
#' @description Encounters are more difficult than the total of the monsters' experience points (XP). Both the number of monsters making attacks and the number of players attacking those creatures can affect the difficulty of an encounter. The Dungeon Master's Guide (DMG) accounts for this by providing an XP multiplier for given party sizes and numbers of monsters. This function accepts the unmodified total of the monsters' XP and adjusts this as specified in the DMG without the pain of the tables in that book.
#'
#' @param monster_xp numeric XP total for the monsters
#' @param monster_count numeric count for the number of monsters in the encounter
#' @param party_size  numeric value for the number of PCs in the party
#'
#' @return a numeric value for the output XP
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' # Calculate the realized XP from the raw XP, number of monsters, and number of PCs
#' xp_cost(monster_xp = 100, monster_count = 3, party_size = 2)
#'
xp_cost <- function(monster_xp = NULL, monster_count = NULL, party_size = NULL){
  # Squelch visible bindings note
  monster_number <- party_category <- NULL

  # Error out if any parameter is null
  if(base::is.null(monster_xp) | base::is.null(monster_count) | base::is.null(party_size)) stop("At least one parameter is unspecified. See `?dndR::xp_cost()` for details.")

  # Error out if any parameter is not numeric
  if(base::is.numeric(monster_xp) != TRUE | base::is.numeric(monster_count) != TRUE |
     base::is.numeric(party_size) != TRUE) stop("All parameters must be numeric.")

  # Assemble multiplier table (see p. 82 in DMG)
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
  if(party_size < 3){ multiplier_table_sub <- dplyr::filter(multiplier_table_raw,
                                                            party_category == "small") }
  if(party_size >= 3 & party_size <= 5){ multiplier_table_sub <- dplyr::filter(multiplier_table_raw, party_category == "typical") }
  if(party_size > 6){ multiplier_table_sub <- dplyr::filter(multiplier_table_raw,
                                                            party_category == "large") }

  # If the monster count is greater than 16, cap it there
  if(monster_count > 16){monster_count <- 16}

  # Subset further based on number of monsters
  multiplier_actual <- dplyr::filter(multiplier_table_sub,
                                     monster_number == monster_count)$multiplier

  # Multiply the provided XP by the identified multiplier
  xp_mult <- (monster_xp * multiplier_actual)

  # Round it to the nearest integer
  xp_actual <- base::trunc(x = xp_mult)

  # Return the multiplied XP
  return(xp_actual)
}
