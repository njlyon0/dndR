# Identify Race-Based Ability Modifiers

Identify the race-based ability modifiers identified in the Player's
Handbook (PHB).

## Usage

``` r
race_mods(race = NULL)
```

## Arguments

- race:

  (character) string of race (supported classes returned by
  \`dndR::dnd_races()\`). Also supports "random" and will randomly
  select a supported race

## Value

(dataframe) two columns and as many rows as there are abilities modified
by the race

## Examples

``` r
# Identifies race modifiers of provided race
dndR::race_mods(race = "mountain dwarf")
#>   ability modifier
#> 1     STR        2
#> 2     DEX        0
#> 3     CON        2
#> 4     INT        0
#> 5     WIS        0
#> 6     CHA        0
```
