#' @title Dungeons and Dragons Spell Information
#'
#' @description Spells in fifth edition Dungeons and Dragons fit within several categories and their effects are well-documented. This table summarizes all of that information (for the 2014 version) into a long format dataframe for easy navigation. Unless otherwise noted, all spell querying functions in `dndR` use this table as their starting point.
#'
#' @format Dataframe with 12 columns and 513 rows
#' \describe{
#'     \item{spell_name}{Name of the spell}
#'     \item{spell_source}{Source book(s) for that spell with page numbers}
#'     \item{pc_class}{Player Character (PC) class(es) that have access to this spell. If multiple classes, each is separated by commas. If a class has a colon and another word next to it (e.g., "cleric: grave") that indicates that only a specific sub-class of that class has access to the spell}
#'     \item{spell_level}{Either "cantrip" or the level of spell slot required to cast the spell}
#'     \item{spell_school}{School of the spell (e.g., "necromancy", "divination", etc.)}
#'     \item{ritual_cast}{Whether the spell can be cast as a ritual expressed as a logical}
#'     \item{casting_time}{Time required to cast the spell. Expressed as either the phase of a turn in which the spell can be cast (e.g., "1 action", "bonus action", etc.) or the actual in-game time required}
#'     \item{range}{Range at which the spell can be cast}
#'     \item{components}{Whether the spell has verbal ("V"), somatic ("S"), and/or material ("M") components required for casting. If material components are required they are described parenthetically}
#'     \item{duration}{How long the spell lasts once cast}
#'     \item{description}{Full description of the spell. Spells that require the player or Dungeon Master (DM) to roll on a table for an effect have those tables excluded for brevity. Similarly, spells that summon creatures have those creatures' statistics excluded.}
#'     \item{higher_levels}{Some spells can be cast using a higher level spell slot for an increased effect. Similarly, damage-dealing cantrips tend to deal more damage as PCs gain levels. This text describes how a spell's effects change with higher spell slot levels or PC levels or is NA for spells that remain constant}
#' }
#'
#' @source {Mearls, M. and Crawford, J. Dungeons & Dragons Player's Handbook (Fifth Edition). Wizards of the Coast 2014}
#' @source {System Reference Document (Fifth Edition). Wizards of the Coast 2014}
#' @source {Elemental Evil. Wizards of the Coast 2015}
#' @source {Sword Coast Adventurer’s Guide. Wizards of the Coast 2015}
#' @source {Xanathar’s Guide to Everything. Wizards of the Coast 2017}
#' @source {Guildmasters’ Guide to Ravnica. Wizards of the Coast 2018}
#' @source {Lost Laboratory of Kwalish. Wizards of the Coast 2018}
#' @source {Explorer's Guide to Wildemount. Wizards of the Coast 2020}
#' @source {Icewind Dale: Rime of the Frostmaiden. Wizards of the Coast 2020}
#' @source {Tasha’s Cauldron of Everything. Wizards of the Coast 2020}
#' @source {Fizban's Treasury of Dragons. Wizards of the Coast 2021}
#' @source {From Cyan Depths. Wizards of the Coast 2021}
#' @source {Strixhaven: A Curriculum of Chaos. Wizards of the Coast 2021}
#' @source {A Verdant Tomb. Wizards of the Coast 2021}
#' @source {Astral Adventurer's Guide. Wizards of the Coast 2022}
"spells"
