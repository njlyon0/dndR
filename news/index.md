# Changelog

## dndR Version 3.1.1

- Update maintainer email.

## dndR Version 3.1.0

CRAN release: 2025-06-11

- [`npc_creator()`](https://njlyon0.github.io/dndR/reference/npc_creator.md)
  also returns first and last names for NPCs (in addition to
  race/species and a job).
- Unit test update for `ggplot2` version `4.0.0`.

## dndR Version 3.0.0

CRAN release: 2025-04-02

- Updates for 2024 version of fifth edition Dungeons & Dragons:
  - With the 2024 release of an updated fifth edition, many functions
    needed to be updated so users could specify which version they were
    using. In all cases this was added as a `ver` argument.
  - Note that the creature and spell query functions
    ([`spell_text()`](https://njlyon0.github.io/dndR/reference/spell_text.md),
    [`spell_list()`](https://njlyon0.github.io/dndR/reference/spell_list.md),
    [`creature_text()`](https://njlyon0.github.io/dndR/reference/creature_text.md),
    and
    [`creature_list()`](https://njlyon0.github.io/dndR/reference/creature_list.md))
    use 2014 information and will return a warning if 2024 is specified
    as the desired version.
  - Similarly, encounter balancing rules have changed so
    [`xp_cost()`](https://njlyon0.github.io/dndR/reference/xp_cost.md)
    will likewise return a warning if the `ver = "2024"`.
  - All other functions with a `ver` argument will behave as appropriate
    for the specified version.
- [`encounter_creator()`](https://njlyon0.github.io/dndR/reference/encounter_creator.md)
  supports a `try` argument that defines how many attempts are made to
  maximize encounter XP while remaining beneath the allowable XP
  threshold.
- [`encounter_creator()`](https://njlyon0.github.io/dndR/reference/encounter_creator.md)
  supports a `max_creatures` parameter that allows users to specify the
  maximum number of creatures they want to include in a given encounter.
- Namespaced all internal function examples.
- Removed all non-ASCII characters from spell and creature information
  data tables.
- Adding unit tests to most functions in the package. Some small changes
  have resulted (e.g., new warnings for edge cases, more informative
  messages, etc.).

## dndR Version 2.0.0

CRAN release: 2024-04-26

- [`encounter_creator()`](https://njlyon0.github.io/dndR/reference/encounter_creator.md)
  picks a set of creature experience point (XP) values that constitute a
  balanced encounter of specified difficulty and given party composition
  information.
- [`creature_list()`](https://njlyon0.github.io/dndR/reference/creature_list.md)
  identifies Dungeons & Dragons creatures based on user specifications
  of various criteria (e.g., creature type, experience point value,
  size, etc.).
- New function: `creature_text` retrieves full description text of
  creature(s) specified by user.
- Adding support for re-rolling of 1s in
  [`roll()`](https://njlyon0.github.io/dndR/reference/roll.md) result.
- Streamlined internal mechanics of
  [`roll()`](https://njlyon0.github.io/dndR/reference/roll.md) such that
  dice with any number (integer) of faces can be rolled (e.g., “2d57”,
  “d13”, etc.).
- Adding 5 spells to
  [`spell_list()`](https://njlyon0.github.io/dndR/reference/spell_list.md)
  and
  [`spell_text()`](https://njlyon0.github.io/dndR/reference/spell_text.md)
  (Antagonize, Gate Seal, Spirit of Death, Spray of Cards, and Warp
  Sense).
- Vignettes restructured into thematic categories.

## dndR Version 1.3.1

CRAN release: 2023-08-07

- Fixed non-ASCII apostrophes in spell names (causes failure to find
  spell with `spell_text` and `spell_list`).

## dndR Version 1.3.0

CRAN release: 2023-07-12

- [`spell_list()`](https://njlyon0.github.io/dndR/reference/spell_list.md)
  identifies official Dungeons & Dragons spells based on user
  specifications of various criteria (e.g., school of magic, which
  character class list has the spell, casting time, etc.).
- [`spell_text()`](https://njlyon0.github.io/dndR/reference/spell_text.md)
  retrieves full description text of spell(s) specified by user.
- [`probability_plot()`](https://njlyon0.github.io/dndR/reference/probability_plot.md)
  makes plot of frequency of dice outcome for specified dice number/type
  and number of rolls.
- [`mod_calc()`](https://njlyon0.github.io/dndR/reference/mod_calc.md)
  identifies roll modifier for a specified ability score.
- [`roll()`](https://njlyon0.github.io/dndR/reference/roll.md)
  description clarified and expanded.
- Added specific contributing instructions (see `CONTRIBUTING.md`).
- Added function contributor names to the description fields of existing
  contributed functions
  ([`pc_level_calc()`](https://njlyon0.github.io/dndR/reference/pc_level_calc.md)
  and
  [`party_diagram()`](https://njlyon0.github.io/dndR/reference/party_diagram.md))
  per `CONTRIBUTING.md` guidelines.

## dndR Version 1.1.0

CRAN release: 2023-03-30

- New supported class: Artificer (Source: “Eberron”).
- New supported races: Bugbear, Changeling, Goblin, Hobgoblin,
  Kalashtar, Orc, Shifter, and Warforged (Source: “Eberron”).
- [`npc_creator()`](https://njlyon0.github.io/dndR/reference/npc_creator.md)
  picks race and job of some number of non-player characters.
- [`pc_level_calc()`](https://njlyon0.github.io/dndR/reference/pc_level_calc.md)
  identifies player level based on earned XP.
- [`roll()`](https://njlyon0.github.io/dndR/reference/roll.md) supports
  three-sided dice (i.e., “d3”).
- [`roll()`](https://njlyon0.github.io/dndR/reference/roll.md) includes
  a `show_dice` parameter that accepts either `TRUE` or `FALSE` (the
  default). If `show_dice = TRUE` (and more than one die is rolled), the
  individual die results will be returned as a message in addition to
  the sum of their results. Note that the behavior of “2d20” is
  unchanged and both values are returned as a two-column, one-row
  dataframe.

## dndR Version 1.0.0

CRAN release: 2023-02-16

First fully functioning version of the package.
