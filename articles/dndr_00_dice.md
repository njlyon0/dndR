# Dice Rolling

## Welcome to `dndR`!

I am a big fan of both R and Dungeons and Dragons so I thought it would
be fun to combine the two and build an R package that supports other
fans of this hobby! `dndR` includes functions for several facets of D&D
and I’ve broken these categories into separate, dedicated vignettes. As
dice rolling is arguably the most fundamental element of D&D, this first
vignette focuses on the dice rolling functions included in the package.

If any of these functions break for you, please [post an
Issue](https://github.com/njlyon0/dndR/issues) so that I can fix the
issue as soon as possible.

## Flexible Dice Rolling

At its simplest, D&D involves significant amounts of dice rolling and
(often) summing their values, so `dndR` includes a `roll` function! This
function supports ‘rolling’ up to 10 million of any dice type and
returns the sum of their outcomes.

``` r
# Roll three six-sided dice
dndR::roll(dice = "3d6")
#> [1] 14
```

If desired, you can set the `show_dice` argument to message the
individual dice outcomes that make up that total.

``` r
# Roll four four-sided dice and show the per-dice results
dndR::roll(dice = "4d4", show_dice = TRUE)
#> Individual rolls: 2, 3, 3, 3
#> [1] 11
```

If you are rolling for a character that has a feature that allows them
to re-roll ones, `roll` also supports re-rolling ones once and keeping
the re-rolled value. If a one is detected, a message will be printed
indicating that it has been re-rolled.

``` r
# Re-roll low values (if any)
dndR::roll(dice = "10d10", re_roll = TRUE)
#> [1] 56
```

Because the sum of the individual dice is returned by `roll`, you can
use it multiple times if you want to roll multiple types of dice and sum
them together.

``` r
# Roll 1d10 and 2d8
dndR::roll(dice = "1d10") + dndR::roll(dice = "2d8")
#> [1] 15
```

## Simple Dice Rolling

If you’d rather keep things simple, there are also helper functions for
each of the standard dice types. The ‘standard’ dice types include dice
with the following number of faces: 100, 20, 12, 10, 8, 6, 4, and 2.
These functions do not accept any arguments and simply “roll” one of the
respective die.

``` r
# Roll one twenty-sided die
dndR::d20()
#> [1] 4
```

Just for fun, there is also a `coin` helper function that is analogous
to a two-sided dice (i.e., “d2”)

``` r
# Flip a coin
dndR::coin()
#> [1] 2
```
