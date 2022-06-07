
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
devtools::install_github("njlyon0/dndR")
```

    #> 
    #> * checking for file ‘/private/var/folders/9m/7tv5z0_j2q34mnkv7907vm540000gn/T/RtmpzMcoZX/remotesb8c439d3f771/njlyon0-dndR-9394818/DESCRIPTION’ ... OK
    #> * preparing ‘dndR’:
    #> * checking DESCRIPTION meta-information ... OK
    #> * checking for LF line-endings in source and make files and shell scripts
    #> * checking for empty or unneeded directories
    #> Removed empty directory ‘dndR/utils’
    #> Omitted ‘LazyData’ from DESCRIPTION
    #> * building ‘dndR_0.1.0.tar.gz’

## Current Functions (Players and GMs)

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
#> [1] 19

# Eight-sided dice
dndR::d8()
#> [1] 3

# Flip a coin
dndR::coin()
#> [1] 1
```

That said, this is somewhat cumbersome given that DnD mostly involves
rolling *multiple* dice and summing their outcomes so the `roll()`
function is built to handle these more general cases

``` r
dndR::roll(what = '2d8')
#> [1] 13

dndR::roll('3d6') + dndR::roll('1d4')
#> [1] 10
```

### Character Creation

You can also roll for your character’s six ability scores by summing
four d6 and dropping the lowest value, rolling three d6, or (for the
truly wild) rolling only a d20.

``` r
dndR::ability_scores(method = "4d6")
#>   ability score
#> 1      V1    17
#> 2      V2    10
#> 3      V3    15
#> 4      V4    12
#> 5      V5    12
#> 6      V6    16
```

That method allows for manual specification of which ability scores
should go to each roll but you could also assign them based on the
Player’s Handbook’s (PHB’s) recommendations for various classes.

``` r
dndR::class_block(class = 'wizard', score_method = "4d6")
#>   ability score
#> 1     STR    14
#> 2     DEX    12
#> 3     CON    14
#> 4     INT    14
#> 5     WIS    11
#> 6     CHA     8
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
#> 1     STR        16             2    18            +4
#> 2     DEX        11             0    11             0
#> 3     CON        15             1    16            +3
#> 4     INT         9             0     9            -1
#> 5     WIS        14             0    14            +2
#> 6     CHA        12             0    12            +1
```

## Current Functions (GMs)

I’ve also designed some functions to help other GMs in developing
encounters. It can be very difficult to balance encounter difficulty
appropriately so I’ve begun to write functions that (hopefully) make it
a little easier to navigate the opaque difficulty, challenge rating, and
experience point systems outlined in the Dungeon Master’s Guide (DMG).

The first such function is `xp_total()` and it identifies the total
experience points of all creatures given a party level (average of PCs
level in party), the number of adventurers (i.e., party size), and a
desired difficulty level (easy, medium, hard, or deadly). GMs can use
this value to “buy” creatures/monsters based on their XP until the pool
is exhausted to ensure their encounters are the desired level of
difficulty for the specified party.

Here is the XP maximum for a medium difficulty encounter for a party of
four PCs, all of whom are level 3.

``` r
dndR::xp_total(party_level = 3, party_size = 4, difficulty = 'medium')
#> [1] 741
```

Here is a comparison of the total XP for an easy encounter recommended
in the DMG versus the XP calculated by `dndR::xp_total()` for the same
difficulty of encounter.

<img src="man/figures/README-xp_demo-1.png" width="50%" style="display: block; margin: auto;" />

## Looking Ahead

I’m working on a function to help stat out monsters/creatures for
various challenge ratings (“CR”) and will update this README when
it/they are ready!

If you have other function ideas, post them as Issues on this
repository!
