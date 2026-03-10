# Create a Player Character (PC)

Assign ability scores for a fifth edition Dungeons and Dragons player
character (PC) of specified race and class using your preferred method
for rolling ability scores. Note that in the 2024 version of fifth
edition, race has no effect on ability scores so that part of this
function is ignored if the 2024 rules are indicated.

## Usage

``` r
pc_creator(
  class = NULL,
  race = NULL,
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
  select a supported class. Random class returned as message

- race:

  (character) name of character race (supported classes returned by
  \`dndR::dnd_races()\`). Also supports "random" and will randomly
  select a supported race. Random race returned as message. Note that if
  \`ver\` is set to "2024", this argument is ignored

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

(dataframe) raw ability score, race modifier, total ability score, and
the roll modifier for each of the six abilities

## Examples

``` r
# Create a PC's base statistics from scratch
dndR::pc_creator(class = 'barbarian', race = 'warforged', score_method = "4d6", quiet = TRUE)
#> Warforged get +1 to one (non-CON) ability. You'll need to do that manually.
#>   ability raw_score race_modifier score roll_modifier
#> 1     STR        14             0    14            +2
#> 2     DEX        10             0    10            +0
#> 3     CON        13             2    15            +2
#> 4     INT        10             0    10            +0
#> 5     WIS         7             0     7            -2
#> 6     CHA        12             0    12            +1

# Or you can roll separately and then create a character with that dataframe
my_scores <- dndR::ability_scores(method = "4d6", quiet = TRUE)
dndR::pc_creator(class = 'sorcerer', race = 'orc', scores_rolled = TRUE, scores_df = my_scores)
#>   ability raw_score race_modifier score roll_modifier
#> 1     STR        12             2    14            +2
#> 2     DEX        10             0    10            +0
#> 3     CON        15             1    16            +3
#> 4     INT         7             0     7            -2
#> 5     WIS         8             0     8            -1
#> 6     CHA        16             0    16            +3
```
