# Creates a Monster for Given Party Level and Size

Returns the vital statistics of a randomized monster based on a the
average player level and number of players in the party. This function
follows the advice of \[Zee Bashew\](https://x.com/Zeebashew) on how to
build interesting, challenging monsters for your party. These monsters
are built somewhat according to the fifth edition Dungeon Master's Guide
(2014 version) for creating monsters, partly Zee's \[YouTube video on
homebrewing monsters based on The Witcher
videogame\](https://www.youtube.com/watch?v=GhjkPv4qo5w), and partly on
my own sensibilities about scaling the difficulty of a creature.
Creatures are spawned randomly so you may need to re-run the function
several times (or mentally modify one or more parts of the output) to
get a monster that fits your campaign and players, but the
vulnerabilities and resistances should allow for cool quest building
around what this function provides. Happy DMing!

## Usage

``` r
monster_creator(party_level = NULL, party_size = NULL)
```

## Arguments

- party_level:

  (numeric) indicating the average party level. If all players are the
  same level, that level is the average party level

- party_size:

  (numeric) indicating how many player characters (PCs) are in the party

## Value

(dataframe) two columns and 15 rows

## Examples

``` r
# Creates a monster from the specified average party level
dndR::monster_creator(party_level = 4, party_size = 3)
#>             statistic                                             value
#> 1          Hit_Points                                                77
#> 2         Armor_Class                                                15
#> 3          Prof_Bonus                                                 3
#> 4        Attack_Bonus                                                 6
#> 5             Save_DC                                                15
#> 6  Prof_Saving_Throws                                          CON; WIS
#> 7           Immune_to                             bludgeoning; piercing
#> 8        Resistant_to slashing; poison; cold; non-magical damage; force
#> 9       Vulnerable_to                                         lightning
#> 10                STR                                                +0
#> 11                DEX                                                +1
#> 12                CON                                                +1
#> 13                INT                                                +1
#> 14                WIS                                                +2
#> 15                CHA                                                +1
```
