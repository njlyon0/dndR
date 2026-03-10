# Assign Ability Scores Based on Class

Assign rolled ability scores based on the recommendations for quick
class building given in the Player's Handbook (PHB) in the 2014 version
of the rules.

## Usage

``` r
class_block(
  class = NULL,
  score_method = "4d6",
  scores_rolled = FALSE,
  scores_df = NULL,
  quiet = FALSE,
  ver = "2014"
)
```

## Arguments

- class:

  (character) name of character class (supported classes returned by
  \`dndR::dnd_classes()\`). Also supports "random" and will randomly
  select a supported class

- score_method:

  (character) preferred method of rolling for ability scores "4d6",
  "3d6", or "1d20" ("d20" also accepted synonym of "1d20"). Only values
  accepted by \`dndR::ability_scores()\` are accepted here

- scores_rolled:

  (logical) whether ability scores have previously been rolled (via
  \`dndR::ability_scores()\`). Defaults to FALSE

- scores_df:

  (dataframe) if 'scores_rolled' is TRUE, the name of the dataframe
  object returned by \`dndR::ability_scores()\`

- quiet:

  (logical) whether to print warnings if the total score is very low or
  one ability score is very low

- ver:

  (character) which version of fifth edition to use ("2014" or "2024")

## Value

(dataframe) two columns and six rows

## Examples

``` r
# Can roll up a new character of the desired class from scratch
dndR::class_block(class = "wizard", score_method = "4d6")
#> Total score low. Consider re-rolling?
#> At least one ability very low. Consider re-rolling?
#>   ability score
#> 1     STR    13
#> 2     DEX    12
#> 3     CON    14
#> 4     INT    14
#> 5     WIS     8
#> 6     CHA     6

# Or you can roll separately and then create a character with that dataframe
my_scores <- ability_scores(method = "4d6")
dndR::class_block(class = "fighter", scores_rolled = TRUE, scores_df = my_scores)
#>   ability score
#> 1     STR    15
#> 2     DEX    14
#> 3     CON    12
#> 4     INT     9
#> 5     WIS    11
#> 6     CHA    10
```
