# Roll Any Number of Dice

Rolls the specified number and type of dice. Dice are specified in the
shorthand common to Dungeons & Dragons (i.e., number of dice, "d",
number of faces of those dice). Includes an argument for whether each
die's value should be returned as a message (rather than just the total
of all dice in the roll). Rolling two twenty-sided dice (i.e., "2d20")
is assumed to be rolling with advantage/disadvantage so both numbers are
returned.

## Usage

``` r
roll(dice = "d20", show_dice = FALSE, re_roll = FALSE)
```

## Arguments

- dice:

  (character) number and type of dice to roll specified in Dungeons &
  Dragons shorthand (e.g., "2d4" to roll two four-sided dice). Defaults
  to a single twenty-sided die (i.e., "1d20")

- show_dice:

  (logical) whether to print the values of each individual die included
  in the total. Defaults to FALSE

- re_roll:

  (logical) whether to re-roll 1s from the initial roll result. Defaults
  to FALSE

## Value

(numeric) sum of specified dice outcomes

## Examples

``` r
# Roll your desired dice
dndR::roll(dice = "4d6", show_dice = TRUE)
#> Individual rolls: 2, 6, 3, 4
#> [1] 15

# Returned as a number so you can add rolls together or integers
dndR::roll(dice = '1d20') + 5
#> [1] 8

# Can also re-roll ones if desired
dndR::roll(dice = '4d4', re_roll = TRUE)
#> Re-rolling 1s
#> [1] 11
```
