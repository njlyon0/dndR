#' @title Retrieve Full Creature Description Text by Creature Name
#'
#' @description Accepts user-provided Dungeons & Dragons creature name(s) and returns the full set of fifth edition creature information and the complete description text (for the 2014 version). Unlike `dndR::creature_list`, this function requires an exact match between the user-provided creature name(s) and how they appear in the main creature data object. The argument in this function is not case-sensitive.
#'
#' @param name (character) exact creature name(s) for which to gather description information
#' @param ver (character) which version of fifth edition to use ("2014" or "2024"). Note that only 2014 is supported and entering "2024" will print a warning to that effect
#'
#' @return (dataframe) one column per creature specified by the user. Creature name is stored as the column name for that creature's information. Returns all fields for which there are data for at least one of the specified creatures so row number will vary with query (maximum 26 rows if all fields have information).
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' dndR::creature_text(name = c("hill giant", "goblin"))
#'
creature_text <- function(name = NULL, ver = "2014"){
  # Silence visible bindings note
  creature_name <- info <- category <- NULL

  # Coerce version parameter to proper format
  ver_char <- as.character(ver)
  
  # Return warning if edition is not 2014
  if(ver_char != "2014")
    warning("This function only supports content from the 2014 edition")
  
  # Read in creature dataframe
  all_creatures <- dndR::creatures

  # Perform the desired query
  focal_creature <- all_creatures %>%
    # Subset to only creatures where the name is an exact match
    dplyr::filter(tolower(creature_name) %in% tolower(name))

  # If there is not a creature of that name print a message
  if(nrow(focal_creature) == 0){
    warning("No creature(s) found matching that name; consider checking spelling")

    # Otherwise...
  } else {

    # Do some tidying to make the output neater
    tidy_creature <- focal_creature %>%
      # Make all columns characters
      dplyr::mutate(dplyr::across(.cols = dplyr::everything(),
                                  .fns = as.character)) %>%
      # Flip it to long format
      tidyr::pivot_longer(cols = -creature_name,
                          names_to = "category", values_to = "info") %>%
      # Remove all empty rows that creates
      dplyr::filter(!is.na(info) & nchar(info) > 0) %>%
      # Make some entries more self-explanatory
      dplyr::mutate(info = dplyr::case_when(
        # Combine 'category' with 'info' for some entries
        category %in% c("STR", "DEX", "CON",
                        "INT", "WIS", "CHA") ~ paste0(category, ": ", info),
        # For others, do more customization
        category %in% c("speed", "skills", "languages"
        ) ~ paste0(stringr::str_to_title(string = category), ": ", info),
        category == "armor_class" ~ paste0("AC: ", info),
        category == "hit_points" ~ paste0("HP: ", info),
        category == "creature_cr" ~ paste0("CR: ", info),
        category == "creature_xp" ~ paste0("XP: ", info),
        category == "creature_source" ~ paste0("Source: ", info),
        category == "creature_size" ~ paste0("Size: ", info),
        category == "creature_type" ~ paste0("Type: ", info),
        category == "creature_alignment" ~ paste0("Alignment: ", info),
        category == "damage_immunities" ~ paste0("Damage Immunities:", info),
        category == "damage_resistances" ~ paste0("Damage Resistances:", info),
        category == "damage_vulnerabilities" ~ paste0("Damage Vulnerabilities:", info),
        category == "condition_immunities" ~ paste0("Condition Immunities: ", info),
        category == "saving_throws" ~ paste0("Saving Throws: ", info),
        # Otherwise just information is fine
        T ~ info)) %>%
      # Pivot to wide format to get creature name in column name
      tidyr::pivot_wider(names_from = creature_name, values_from = info) %>%
      # Ditch category column altogether (now unneeded)
      dplyr::select(-category) %>%
      # Make it a dataframe
      as.data.frame()

    # Return that information
    return(tidy_creature) } }
