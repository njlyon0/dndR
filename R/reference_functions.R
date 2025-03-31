#' @title Return Vector of Accepted Classes
#'
#' @description Simply returns a vector of classes that `class_block()` accepts currently. Submit an issue on the GitHub repository if you want a class added.
#'
#' @return (character) vector of accepted class names
#'
#' @export
#'
#' @examples
#' # Want to check which classes this package supports?
#' dndR::dnd_classes()
#'
dnd_classes <- function(){

  # Assemble vector of currently supported classes
  current_classes <- c("artificer", "barbarian", "bard", "cleric", "druid",
                       "fighter", "monk", "paladin", "ranger",
                       "rogue", "sorcerer", "warlock", "wizard")

  # Return that vector
  return(current_classes)
}


#' @title Return Vector of Supported DnD Races
#'
#' @description Simply returns a vector of races that `race_mods()` accepts currently. Submit an issue on the GitHub repository if you want a race added.
#'
#' @return (character) vector of supported race designations
#'
#' @export
#'
#' @examples
#' # Want to check which races this package supports?
#' dndR::dnd_races()
#'
dnd_races <- function(){

  # Assemble vector of currently supported classes
  current_races <- c(
    "aarakocra", "bugbear", "changeling", "dark elf", "dragonborn", "drow",
    "forest gnome", "goblin", "half elf", "half-elf", "half orc", "half-orc", "high elf",
    "hill dwarf", "hobgoblin", "human", "kalashtar", "lightfoot halfling",
    "mountain dwarf", "orc", "plasmoid", "shifter", "rock gnome", "stout halfling",
    "tiefling", "warforged", "wood elf"
  )

  # Return that vector
  return(current_races)
}


#' @title Return Vector of Supported DnD Damage Types
#'
#' @description Simply returns a vector of damage types in DnD
#'
#' @return character vector of damage types
#'
#' @export
#'
#' @examples
#' # Full set of damage types included in DnD Fifth Edition (5e)
#' dndR::dnd_damage_types()
#'
dnd_damage_types <- function(){

  # Assemble vector of currently supported classes
  damages <- c(
    "acid", "bludgeoning", "cold", "fire", "force",
    "lightning", "necrotic", "piercing", "poison",
    "psychic", "radiant", "slashing", "thunder",
    "non-magical damage"
  )

  # Return that vector
  return(damages)
}
