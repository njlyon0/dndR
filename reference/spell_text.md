# Retrieve Full Spell Description Text by Spell Name

Accepts user-provided fifth edition Dungeons & Dragons spell name(s) and
returns the full set of spell information (for the 2014 version) and the
complete description text. Unlike \`dndR::spell_list\`, this function
requires an exact match between the user-provided spell name(s) and how
they appear in the main spell data object. The argument in this function
is not sensitive. This function's output differs from
\`dndR::spell_list\` only in that it returns the additional spell
description text.

## Usage

``` r
spell_text(name = NULL, ver = "2014")
```

## Arguments

- name:

  (character) exact spell name(s) for which to gather description
  information

- ver:

  (character) which version of fifth edition to use ("2014" or "2024").
  Note that only 2014 is supported and entering "2024" will print a
  warning to that effect

## Value

(dataframe) 11 columns of spell information with one row per spell
specified by the user. Returns 12 columns if the spell is a
damage-dealing cantrip that deals increased damage as player level
increases or if spell can be cast with a higher level spell slot (i.e.,
"upcast") for an increased effect.

## Examples

``` r
dndR::spell_text(name = "chill touch")
#>    spell_name                                         spell_source
#> 1 Chill Touch Player's Handbook.221, System Reference Document.124
#>                                   pc_class spell_level spell_school ritual_cast
#> 1 sorcerer, warlock, wizard, druid: spores     cantrip   necromancy       FALSE
#>   casting_time    range components duration
#> 1     1 action 120 feet       V, S  1 round
#>                                                                                                                                                                                                                                                                                                                                                                                                                                              description
#> 1 You create a ghostly, skeletal hand in the space of a creature within range. Make a ranged spell attack against the creature to assail it with the chill of the grave. On a hit, the target takes 1d8 necrotic damage, and it can't regain hit points until the start of your next turn. Until then, the hand clings to the target. If you hit an undead target, it also has disadvantage on attack rolls against you until the end of your next turn.
#>                                                                                                  higher_levels
#> 1 This spell's damage increases by 1d8 when you reach 5th level (2d8), 11th level (3d8), and 17th level (4d8).
```
