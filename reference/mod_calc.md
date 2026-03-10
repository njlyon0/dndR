# Calculate Modifier for Specified Ability Score

Ability scores (typically 0-20 for most creatures) relate to roll
modifiers. These values are what a player or DM actually adds to a given
skill or ability check. This function performs the simple calculation to
identify the roll modifier that relates to the supplied ability score.

## Usage

``` r
mod_calc(score = 10)
```

## Arguments

- score:

  (numeric) ability score value for which to identify the roll modifier

## Value

(character) roll modifier for a given ability score. If positive,
includes a plus sign to make the addition explicit. Negative values are
also returned as characters for consistency with positive modifiers

## Examples

``` r
# Calculate roll modifier for an ability score of 17
dndR::mod_calc(score = 17)
#> [1] "+3"
```
