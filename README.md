
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dndR

<!-- badges: start -->

[![R-CMD-check](https://github.com/njlyon0/dndR/workflows/R-CMD-check/badge.svg)](https://github.com/njlyon0/dndR/actions)
<!-- badges: end -->

The goal of `dndR` is to provide a suite of Dungeons & Dragons (Fifth
Edition) related functions.

## Installation

You can install the development version of dndR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("NJLyon-Projects/dndR")
```

## Current Functions

There are several functions currently in `dndR` and I am working on more
as we speak!

### Dice Rolling

At its simplest, DnD involves significant amounts of dice rolling so
I’ve scripted dice functions! These functions support dice with the
following numbers of sides: 100, 20, 12, 10, 8, 6, 4, and 2 (2 is
essentially a coin so `coin()` is also a function).

``` r
# Twenty-sided dice
dndR::d20()
#> [1] 2

# Eight-sided dice
dndR::d8()
#> [1] 7

# Flip a coin
dndR::coin()
#> [1] 2
```

That said, this is somewhat cumbersome given that DnD mostly involves
rolling *multiple* dice and summing their outcomes so the `roll()`
function is built to handle these more general cases

``` r
dndR::roll(what = '2d8')
#> [1] 10
```

### Character Creation

You can also roll for your character’s six ability scores by summing
four d6 and dropping the lowest value, rolling three d6, or (for the
truly wild) rolling only a d20.

``` r
dndR::ability_scores(method = "4d6")
#> At least one ability very low. Consider re-rolling?
#>   ability score
#> 1      V1    13
#> 2      V2     7
#> 3      V3    11
#> 4      V4    17
#> 5      V5    16
#> 6      V6     6
```

That method allows for manual specification of which ability scores
should go to each roll but you could also assign them based on the
Player’s Handbook’s (PHB’s) recommendations for various classes.

``` r
dndR::class_block(class = 'wizard', score_method = "4d6")
#> Total score very low. Consider re-rolling?
#>   ability score
#> 1     INT    13
#> 2     CON    12
#> 3     WIS     9
#> 4     CHA     9
#> 5     DEX     8
#> 6     STR     8
```

DnD races (e.g., dwarves, dragonborn, etc.) confer additional points to
specific abilities and there’s a function for that as well!

``` r
dndR::race_mods(race = 'wood elf')
#>   ability modifier
#> 1     STR        0
#> 2     DEX        2
#> 3     CON        0
#> 4     INT        0
#> 5     WIS        1
#> 6     CHA        0
```

Finally, you could create a character of specified race and class in one
fell swoop!

``` r
dndR::pc_creator(class = 'barbarian', race = 'half orc', score_method = "4d6")
#>   ability raw_score race_modifier score roll_modifier
#> 1     STR        15             2    17            +3
#> 2     CON        15             1    16            +3
#> 3     WIS        14             0    14            +2
#> 4     DEX        12             0    12            +1
#> 5     CHA        11             0    11             0
#> 6     INT        10             0    10             0
```

## Looking Ahead

I’m working on a function to help stat out monsters/creatures for
various challenge ratings (“CR”) and will update this README when
it/they are ready!

If you have other function ideas, post them as Issues on this
repository!
