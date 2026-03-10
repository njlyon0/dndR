# Roll for All Ability Scores

Rolls for six ability scores using the desired method of rolling (4d6
drop lowest, 3d6, or 1d20). Doesn't assign abilities to facilitate
player selection of which score should be each ability for a given
character. Prints a warning if the total of all abilities is less than
70 or if any one ability is less than 8.

## Usage

``` r
ability_scores(method = "4d6", quiet = FALSE)
```

## Arguments

- method:

  (character) string of "4d6", "3d6", or "1d20" ("d20" also accepted).
  Enter your preferred method of rolling for each ability score ("4d6"
  drops lowest before summing)

- quiet:

  (logical) whether to print warnings if the total score is very low or
  one ability score is very low. Defaults to FALSE

## Value

(dataframe) two columns and six rows for ability score for each ability

## Examples

``` r
# Roll ability scores using four d6 and dropping the lowest
dndR::ability_scores(method = "4d6")
#>   ability score
#> 1      V1    16
#> 2      V2    15
#> 3      V3    16
#> 4      V4    14
#> 5      V5    14
#> 6      V6    13

# Roll using 3d6 and dropping nothing
dndR::ability_scores("3d6")
#> Total score low. Consider re-rolling?
#> At least one ability very low. Consider re-rolling?
#>   ability score
#> 1      V1    10
#> 2      V2    12
#> 3      V3    13
#> 4      V4     7
#> 5      V5    13
#> 6      V6    11

# Or if you're truly wild, just roll a d20 for each ability
dndR::ability_scores('d20')
#> Total score low. Consider re-rolling?
#> At least one ability very low. Consider re-rolling?
#>   ability score
#> 1      V1     1
#> 2      V2    15
#> 3      V3    18
#> 4      V4     5
#> 5      V5     8
#> 6      V6     1
```
