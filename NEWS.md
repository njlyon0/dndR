## dndR Version 3.0.0.900

This is the development version. The following changes were made from the preceding version:

- New function behavior: `npc_creator` now also returns first and last names for NPCs (in addition to race/species and a job)

## dndR Version 3.0.0

The following changes were made from the preceding version:

- Updates for 2024 version of fifth edition Dungeons & Dragons:
    - With the 2024 release of an updated fifth edition, many functions needed to be updated so users could specify which version they were using. In all cases this was added as a `ver` argument
    - Note that the creature and spell query functions (`spell_text`, `spell_list`, `creature_text`, and `creature_list`) use 2014 information and will return a warning if 2024 is specified as the desired version
    - Similarly, encounter balancing rules have changed so `xp_cost` will likewise return a warning if the `ver = "2024"`
    - All other functions with a `ver` argument will behave as appropriate for the specified version
- New function behavior: `encounter_creator` now supports a `try` argument that defines how many attempts are made to maximize encounter XP while remaining beneath the allowable XP threshold
- New function behavior: `encounter_creator` now supports a `max_creatures` argument that allows users to specify the maximum number of creatures they want to include in a given encounter (regardless of available XP)
- Namespaced all function examples--should allow users to run example code without loading `dndR` explicitly with `library` (though they will still need to have installed it at least once)
- Removed all non-ASCII characters from spell and creature information data tables. Should not affect user experience but silences a CRAN check note in Linux environments
- Adding unit tests to most functions in the package. Some small changes have resulted (e.g., new warnings for edge cases, more informative messages, etc.) but this shouldn't change function behavior where they are currently in use. Hopefully future debugging will be made easier though!

## dndR Version 2.0.0

The following changes were made from the preceding version:

- New function: `encounter_creator` -- picks a set of creature experience point (XP) values that constitute a balanced encounter of specified difficulty and given party composition information
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
