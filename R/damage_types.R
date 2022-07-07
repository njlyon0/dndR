#' @title Return Vector of Supported DnD Damage Types
#'
#' @description Simply returns a vector of damage types in DnD
#'
#' @return character vector of damage types
#'
#' @export
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

