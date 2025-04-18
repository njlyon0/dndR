#' @title Dungeons and Dragons Creature Information
#'
#' @description Creatures in fifth edition Dungeons and Dragons all fall into certain, well-documented categories. This table summarizes all of that information (for the 2014 version of the rules) into a long format dataframe for easy navigation. Unless otherwise noted, all creature querying functions in `dndR` use this table as their starting point.
#'
#' @format Dataframe with 26 columns and 1721 rows
#' \describe{
#'     \item{creature_name}{Name of the creature}
#'     \item{creature_source}{Source book for the creature}
#'     \item{STR}{Strength ability score of creature with roll modifier indicated parenthetically}
#'     \item{DEX}{Dexterity ability score of creature with roll modifier indicated parenthetically}
#'     \item{CON}{Constitution ability score of creature with roll modifier indicated parenthetically}
#'     \item{INT}{Intelligence ability score of creature with roll modifier indicated parenthetically}
#'     \item{WIS}{Wisdom ability score of creature with roll modifier indicated parenthetically}
#'     \item{CHA}{Charisma ability score of creature with roll modifier indicated parenthetically}
#'     \item{creature_size}{Size category of the creature (one of 'tiny', 'small', 'medium', 'large', 'huge', or 'gargantuan')}
#'     \item{creature_type}{Type of the creature (e.g., undead, elemental, etc.)}
#'     \item{creature_alignment}{The creature's alignment (e.g., chaotic evil, etc.)}
#'     \item{creature_xp}{Experience point (XP) value of the creature}
#'     \item{creature_cr}{Challenge rating (CR) of the creature}
#'     \item{languages}{Any languages understood or spoken by the creature}
#'     \item{skills}{Any skills in which the creature is proficient and the roll modifiers for each}
#'     \item{speed}{Movement speed of the creature}
#'     \item{hit_points}{Number of hit points (HP) of the creature (and the dice to roll if rolling for HP is desired)}
#'     \item{armor_class}{Armor class of the creature}
#'     \item{senses}{Any special senses of the creature}
#'     \item{saving_throws}{Any saving throws in which the creature is proficient and the roll modifiers for each}
#'     \item{damage_immunities}{Damage types to which the creature is immune (i.e., no damage)}
#'     \item{damage_resistances}{Damage types to which the creature is resistant (i.e., half damage)}
#'     \item{damage_vulnerabilities}{Damage types to which the creature is vulnerable (i.e., double damage)}
#'     \item{condition_immunities}{Conditions to which the creature is immune}
#'     \item{abilities}{Description of all abilities the creature has as well as any bonus actions or reactions it can take. Each item name is surrounded by triple asterisks}
#'     \item{actions}{Description of all actions the creature can take. Each item name is surrounded by triple asterisks}
#' }
#'
#' @source {Crawford, J., Hickman, L., Hickman, T., Lee, A., Perkins, C., Whitters, R. Curse of Strahd. Wizards of the Coast 2015.}
#' @source {Waterdeep: Dungeon of the Mad Mage. Wizards of the Coast 2018.}
#' @source {Elemental Evil. Wizards of the Coast 2015.}
#' @source {Explorer's Guide to Wildemount. Wizards of the Coast 2020.}
#' @source {Guildmasters' Guide to Ravnica. Wizards of the Coast 2018.}
#' @source {Lost Mine of Phandelver. Wizards of the Coast 2014.}
#' @source {Mearls, M. and Crawford, J. Dungeons & Dragons Monster Manual (Fifth Edition). Wizards of the Coast 2014}
#' @source {Morenkainen's Tome of Foes. Wizards of the Coast 2018.}
#' @source {Out of the Abyss. Wizards of the Coast 2015.}
#' @source {Storm King's Thunder. Wizards of the Coast 2016.}
#' @source {Tales from the Yawning Portal. Wizards of the Coast 2017.}
#' @source {Tomb of Annihilation. Wizards of the Coast 2017.}
#' @source {Baur, W. Tome of Beasts. Paizo Inc. 2016.}
#' @source {Tome of Horrors. Frog God Games 2019.}
#' @source {Tyranny of Dragons. Wizards of the Coast 2015.}
#' @source {Volo's Guide to Monsters. Wizards of the Coast 2016.}
"creatures"
