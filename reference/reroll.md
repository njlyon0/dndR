# Re-Roll 1s from a Prior Dice Roll

Re-rolls only the dice that "landed on" 1 from a prior use of \`roll\`.
Retains other dice results from the first roll but replaces the ones.

## Usage

``` r
reroll(dice_faces, first_result = NULL)
```

## Arguments

- dice_faces:

  (numeric) number of sides on the die to be rerolled (i.e., type of
  dice without the "d" found in the \`roll\` function)

- first_result:

  (numeric) vector of original dice results (including 1s to reroll)

## Value

(numeric) vector of non-1 original dice results with re-rolled dice
results appended

## Examples

``` r
# Re-roll ones from a prior result
dndR::reroll(dice_faces = 8, first_result = c(1, 3, 1))
#> [1] 3 5 8
```
