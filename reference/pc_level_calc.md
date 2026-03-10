# Calculate Player Character (PC) Level from Current Experience Points (XP)

Uses total player experience points (XP) to identify player character
(PC) level and proficiency modifier. Only works for a single PC at a
time (though this is unlikely to be an issue if all party members have
the same amount of XP). Big thanks to Humberto Nappo for contributing
this function!

## Usage

``` r
pc_level_calc(player_xp = NULL)
```

## Arguments

- player_xp:

  (numeric) total value of experience points earned by one player

## Value

(dataframe) current player level, XP threshold for that level, and the
proficiency modifier used at that level

## Examples

``` r
# Calculate player level from XP earned
dndR::pc_level_calc(player_xp = 950)
#>   player_level xp_threshold proficiency
#> 3            3          900          +2
```
