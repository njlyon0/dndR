
<!-- README.md is generated from README.Rmd. Please edit that file -->

<img src="man/figures/dndR_hex.png" align = "right" width = "15%" />

# `dndR`: Dungeons & Dragons Functions for Players and Dungeon Masters

<!-- badges: start -->

[![R-CMD-check](https://github.com/njlyon0/dndR/workflows/R-CMD-check/badge.svg)](https://github.com/njlyon0/dndR/actions)
[![](https://cranlogs.r-pkg.org/badges/dndR)](https://cran.r-project.org/package=dndR)
![GitHub issues](https://img.shields.io/github/issues-raw/njlyon0/dndR)
![GitHub pull
requests](https://img.shields.io/github/issues-pr/njlyon0/dndR)
<!-- badges: end -->

The goal of `dndR` is to provide a suite of Dungeons & Dragons (Fifth
Edition a.k.a. “5e”) related functions to help both players and Dungeon
Masters (DMs). Below are short descriptions of the functions currently
included in `dndR`. I am always willing to expand that list though so if
you have a DnD-related task that could be cool as a function, please
[post it as an Issue](https://github.com/njlyon0/dndR/issues) on this
package’s GitHub repository!

## Installation

You can install the development version of `dndR` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("njlyon0/dndR")
```

## For Players and DMs

- **`roll`** – Roll specified number of dice and sums their outcomes.
  Supports returning the individual die results as a message and/or
  re-rolling 1s via optional arguments.

- **`ability_scores`** – Roll for six ability scores using specified
  method (e.g., 4d6 drop lowest, 3d6, or 1d20)

- **`mod_calc`** – Calculate roll modifier for given ability score(s)

- **`pc_creator`** – Stat out a character of specified race and class
  using your preferred method of rolling ability scores

  - Run `dnd_races()` or `dnd_classes()` to see which races/classes are
    currently supported by `pc_creator`

- **`spell_list`** – Identify all spells that fit certain criteria
  (e.g., spell level, school of magic, character class list, etc.)

- **`spell_text`** – Retrieve full information and description text for
  specified spell(s)

- **`creature_list`** – Identify all creatures that fit certain criteria
  (e.g., experience point value, creature type, size, etc.)

- **`creature_text`** – Retrieve full information and ability/action
  information text for specified creature(s)

- **`probability_plot`** – Generate a `ggplot2` plot of the frequency of
  roll outcomes for the specified type and number of dice. You can also
  specify the number of times to roll those dice to inform the plot

- **`pc_level_calc`** – Identify the current level of a player character
  based on earned experience points (XP). Also returns the proficiency
  modifier to be used at that level

  - Thank you to Humberto Nappo for contributing this function!

## For DMs

- **`xp_pool`** – Identify XP total for desired encounter difficulty at
  a specified player level and party size

- **`xp_cost`** – Find “realized” XP amount by applying appropriate
  multiplier for “raw” XP based on number of creatures and party size

- **`monster_stats`** – Return monster stat block of specified XP value
  or challenge rating (CR)

- **`monster_creator`** – Generate a homebrew monster with additional
  immunities and vulnerabilities of specified difficulty (adjustment for
  these is performed automatically)

  - This function is inspired by [Zee Bashew’s video on creating
    *Witcher*-esque homebrew
    monsters](https://www.youtube.com/watch?v=GhjkPv4qo5w)

- **`party_diagram`** – Create a `ggplot2` diagram of party ability
  scores separated either by player or by score. This plot can be useful
  in identifying the strengths and weaknesses of the party as a whole to
  help you (the DM) create encounters with that in mind

  - Thank you to [Tim Schatto-Eckrodt](https://kudusch.de/) for
    contributing this function!

- **`npc_creator`** – Pick a job and race for any number of non-player
  characters (NPCs). Hopefully this provides a useful starting point
  when describing the patrons of a tavern or the travelers players
  glimpse on the edge of the flickering light cast by their campfire

## Contributing Functions

If you’d like to contribute function scripts or ideas, that is more than
welcome! For specific instructions check out `CONTRIBUTING.md` but at a
glance:

- For function ideas, [open a Github
  issue](https://github.com/njlyon0/dndR/issues)

- For function scripts, either [open a Github
  issue](https://github.com/njlyon0/dndR/issues) *or* fork the
  repository and add your content to the `dev` folder

## Looking Ahead

I know that there are rumblings of a change to statistic modifiers
becoming based on background rather than race so once those details are
finalized I plan on creating a suite of functions that follow those
guidelines. The extant functions follow “5e” rules as detailed in the
Player’s Handbook (PHB) and Dungeon Master’s Guide (DMG).
