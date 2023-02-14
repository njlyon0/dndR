
<!-- README.md is generated from README.Rmd. Please edit that file -->

<img src="man/figures/dndR_hex.png" align = "right" width = "15%" />

# `dndR`: Dungeons & Dragons Functions for Players and Dungeon Masters

<!-- badges: start -->

[![R-CMD-check](https://github.com/njlyon0/dndR/workflows/R-CMD-check/badge.svg)](https://github.com/njlyon0/dndR/actions)
![GitHub last
commit](https://img.shields.io/github/last-commit/njlyon0/dndR) ![GitHub
issues](https://img.shields.io/github/issues-raw/njlyon0/dndR) ![GitHub
pull requests](https://img.shields.io/github/issues-pr/njlyon0/dndR)
<!-- badges: end -->

The goal of `dndR` is to provide a suite of Dungeons & Dragons (Fifth
Edition a.k.a. “5e”) related functions to help both players and Dungeon
Masters (DMs).

## Installation

You can install the development version of dndR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("njlyon0/dndR")
```

Below are short descriptions of the functions currently included in
`dndR`. I am always willing to expand that list though so if you have a
DnD-related task that could be cool as a function, please [post it as an
Issue](https://github.com/njlyon0/dndR/issues) on this package’s GitHub
repository!

You can also check out the `pkgdown` style website for this package
[here](https://njlyon0.github.io/dndR/) or a more–in my opinion–visually
appealing vignette-style website I’ve created
[here](https://njlyon0.github.io/dndR-website/). The latter website was
created using [Quarto](https://quarto.org/).

## For Players and DMs

- **`roll`** – Roll specified number of standard dice and sum their
  outcomes. “Standard” dice have the following number of sides: 100, 20,
  12, 10, 8, 6, 4, and 2

- **`ability_scores`** – Roll for six ability scores using specified
  method (e.g., 4d6 drop lowest, 3d6, etc.)

- **`pc_creator`** – Stat out a character of specified race and class
  using your preferred method of rolling ability scores

  - Run `dnd_races()` or `dnd_classes()` to see which races/classes are
    currently supported by `pc_creator`

## For DMs

- **`xp_pool`** – Identify experience point (XP) total for desired
  encounter difficulty at a specified player level and party size

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

  - *Huge* thank you to [Tim Schatto-Eckrodt](https://kudusch.de/) for
    contributing this function!

## Looking Ahead

I know that there are rumblings of a change to statistic modifiers
becoming based on background rather than race so once those details are
finalized I will create a suite of “5.5e” functions that follow those
guidelines. The extant functions follow “5e” rules as detailed in the
Player’s Handbook (PHB) and Dungeon Master’s Guide (DMG).

If you have other function ideas, [post them as
Issues](https://github.com/njlyon0/dndR/issues) on this repository!
