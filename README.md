
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dndR

<!-- badges: start -->

[![R-CMD-check](https://github.com/njlyon0/dndR/workflows/R-CMD-check/badge.svg)](https://github.com/njlyon0/dndR/actions)
<!-- badges: end -->

The goal of `dndR` is to provide a suite of Dungeons & Dragons (Fifth
Edition a.k.a. “5e”) related functions.

## Installation

You can install the development version of dndR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("njlyon0/dndR")
```

There are several functions currently in `dndR` and I am working on more
as we speak!

## Dice Rolling

At its simplest, DnD involves significant amounts of dice rolling and
(often) summing their values, so I’ve scripted a `roll()` function! This
function supports ‘rolling’ up to 10 million of any of the standard
dice. “Standard” dice include the following numbers of sides: 100, 20,
12, 10, 8, 6, 4, and 2 (2 is essentially a coin so `coin()` is also a
function).

``` r
dndR::roll(dice = '1d20')
#> [1] 5

dndR::roll('3d6') + dndR::roll('1d4')
#> [1] 11
```

## Character Creation

I also have a function that can roll for a character’s ability scores
(strength, dexterity, constitution, intelligence, wisdom, and charisma)
given a particular class, race, and preferred method of rolling for
ability scores.

``` r
dndR::pc_creator(class = 'barbarian', race = 'half orc', score_method = "4d6")
#>   ability raw_score race_modifier score roll_modifier
#> 1     STR        15             2    17            +3
#> 2     DEX        14             0    14            +2
#> 3     CON        14             1    15            +2
#> 4     INT        12             0    12            +1
#> 5     WIS        14             0    14            +2
#> 6     CHA        12             0    12            +1
```

You can check which classes and races are currently supported by
`pc_creator()` by running `dnd_classes()` or `dnd_races()`. If you have
a class/race in mind that isn’t supported you can [post an
Issue](https://github.com/njlyon0/dndR/issues) and I’ll add that
class/race’s stats to the function ASAP!

While waiting for me to act on your Issue, you can run the simpler
`ability_scores()` function to simply roll for ability scores and
manually assign them to specific abilities yourself.

``` r
dndR::ability_scores(method = "4d6")
#>   ability score
#> 1      V1    11
#> 2      V2    10
#> 3      V3    17
#> 4      V4    11
#> 5      V5    17
#> 6      V6    12
```

## Encounter Balancing

When I am the Dungeon/Game Master (DM / GM) I find encounter balancing
to be really difficult, in part because of the nest of inter-related
tables and experience point multipliers outlined in the Dungeon Master’s
Guide (DMG) that must be consulted for novice GMs such as myself. To
help other newbies, I’ve created two functions to handle the brunt of
this work.

### Experience Point (XP) Thresholds

The difficulty of a fight in DnD is affected by three things: (1) the
level of the players’ characters, (2) the number of players in the
party, and (3) how difficult the GM wants to make things for their
players.

The DMG handles this by providing experience point (XP) thresholds based
on these three factors. All enemies are worth a pre-determined amount of
XP so encounters are balanced by the DMG listing the total XP of all
monsters in a given fight for every level of players, party size, and
difficulty. That table is useful but a little dense to work through as
you’re prepping potentially multiple encounters per session, so I
created `xp_pool()` to handle this.

The number returned by this function represents the amount of XP the GM
can ‘spend’ on monsters in a given encounter to ensure the difficulty is
as desired.

``` r
dndR::xp_pool(party_level = 2, party_size = 4, difficulty = "medium")
#> [1] 625
```

### XP Multipliers

While the XP pool is crucial to know while designing an encounter, it
does fail to account for the effect of the number of enemies. A fight
versus a single monster worth 1000 XP is a very different proposition
than one against four creatures each worth 250 XP even though the total
XP is the same.

The DMG accounts for this eventuality by providing XP multipliers based
on the number of monsters and the number of players. The same total
monster XP is multiplied by a larger value for more monsters facing a
smaller party than it would be for fewer monsters facing a larger party.

When using the XP threshold for a given encounter (as identified by
`xp_pool()`) the GM must pass their selected monsters’ total XP through
this multiplier table to identify the true ‘cost’ to compare against
their pool (to identify whether their encounter will be the desired
level of difficulty.) See why I wanted to write functions to do this for
me? Enter `xp_cost()`!

This function takes the total XP of the monsters you (the GM) have
selected, the number of monsters that make up that total, and the size
of your party and returns the true XP cost of the encounter for
comparison with the threshold identified by `xp_pool()`.

``` r
dndR::xp_cost(monster_xp = 1000, monster_count = 2, party_size = 3)
#> [1] 1500
```

### Quick Demonstration

Let’s say I am running a game for four players, all level 3, and I want
to design a hard encounter for them. This is how I would go about doing
that using `dndR`:

To begin, I’d identify the total XP I can ‘spend’ to make an encounter
this difficult

``` r
dndR::xp_pool(party_level = 3, party_size = 4, difficulty = 'hard')
#> [1] 1112
```

Now that I know how much XP I can ‘spend’ I can check the value of two
monsters worth (total) 500 XP against that threshold

``` r
dndR::xp_cost(monster_xp = 500, monster_count = 2, party_size = 4)
#> [1] 750
```

I can see that I’m well under the XP threshold I have to play with so I
can add a monster and see where that leaves me

``` r
dndR::xp_cost(monster_xp = 500, monster_count = 3, party_size = 4)
#> [1] 1000
```

Really close! What if I added another monster that isn’t worth as much
XP?

``` r
dndR::xp_cost(monster_xp = 550, monster_count = 4, party_size = 4)
#> [1] 1100
```

Basically right on target! I can now pick out my four monsters that
total up to 550 XP raw and know that they will likely\* make a hard
encounter for my players! (\* “Likely” because there is dice rolling
involved and it is possible the monters roll well while my players roll
badly or vice versa.)

### `xp_pool()` versus DMG Comparison

The DMG specifies the XP threshold *per player* for a given difficulty
while my function asks for the *average* player level and the party size
to avoid becoming simply a querying function for the DMG’s table.

I calculated the formula for the relationship between XP and player
level and used that calculation in lieu of embedding the DMG’s table in
my function. This has the added benefit of being able to handle
non-integer values for average party_level. Below is a comparison of the
DMG’s XP-to-player level curve and the one obtained by `xp_pool()`

<img src="man/figures/README-xp_dmg-to-pool_comparison-1.png" width="50%" style="display: block; margin: auto;" />

## Looking Ahead

I’m working on a function to help stat out monsters/creatures for
various challenge ratings (“CR”) and will update this README when
it/they are ready!

If you have other function ideas, post them as Issues on this
repository!
