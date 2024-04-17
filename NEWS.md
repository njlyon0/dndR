## dndR Version 1.3.1.900

Development version of `dndR`. The following changes were made from the preceding version:

- New function: `creature_list` -- identifies Dungeons & Dragons creatures based on user specifications of various criteria (e.g., creature type, experience point value, size, etc.)
- New function: `creature_text` -- retrieves full description text of creature(s) specified by user
- Adding support for re-rolling of 1s in `roll` result
- Streamlined internal mechanics of `roll` such that dice with any number (integer) of faces can be rolled (e.g., "2d57", "d13", etc.)
- Adding 5 spells to `spell_list` and `spell_text` (Antagonize, Gate Seal, Spirit of Death, Spray of Cards, and Warp Sense)
- Vignettes restructured! Now categories of functions are housed in separate vignettes for--hopefully--easier navigation of the bits of this package that are most relevant to you

## dndR Version 1.3.1

The following changes were made from the preceding version:

- Fixed curly apostrophes in spell names (causes failure to find spell with `spell_text` and `spell_list`)

## dndR Version 1.3.0

The following changes were made from the preceding version:

- New function: `spell_list` -- identifies official Dungeons & Dragons spells based on user specifications of various criteria (e.g., school of magic, which character class list has the spell, casting time, etc.)
- New function: `spell_text` -- retrieves full description text of spell(s) specified by user
- New function: `probability_plot` -- makes plot of frequency of dice outcome for specified dice number/type and number of rolls
- New function: `mod_calc` -- identifies roll modifier for a specified ability score
- `roll` description is more detailed/useful now (rather than simple recapitulation of the function title)
- Added specific contributing instructions (see `CONTRIBUTING.md`)
- Added function contributor names to the description fields of existing contributed functions (`pc_level_calc` and `party_diagram`) per `CONTRIBUTING.md` guidelines

There are no ERRORs, WARNINGs, or NOTEs returned by `devtools::check()`

## dndR Version 1.1.0

The following changes were made from the preceding version:

- New supported class: Artificer (Source: "Eberron")
- New supported races: Bugbear, Changeling, Goblin, Hobgoblin, Kalashtar, Orc, Shifter, and Warforged (Source: "Eberron")
- New function: `npc_creator` -- picks race and job of some number of non-player characters
- New function: `pc_level_calc` -- identifies player level based on earned XP
- `roll` now supports three-sided dice (i.e., "d3")
- `roll` now includes a `show_dice` argument that accepts either `TRUE` or `FALSE` (the default). If `show_dice = T` (and more than one die is rolled), the individual die results will be returned as a message in addition to the sum of their results. Note that the behavior of "2d20" is unchanged and both values are returned as a two-column, one-row dataframe

There are no ERRORs, WARNINGs, or NOTEs returned by `devtools::check()`

## dndR Version 1.0.0

First fully functioning version of the package. There are currently no ERRORs, WARNINGs, or NOTEs returned by `devtools::check()`
