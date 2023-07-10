## dndR Version 1.3.0.900

Development version of `dndR`. The following changes were made from the preceding version:

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
