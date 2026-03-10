# List Spells Based on Criteria

Query list of all fifth edition Dungeons & Dragons spells (2014 version)
based on partial string matches between user inputs and the relevant
column of the spell information data table. Currently supports users
querying the spell list by spell name, which class lists allow the
spell, spell's level, the school of magic the spell belongs in, whether
or not the spell can be cast as a ritual, and the time it takes to cast
the spell. All character arguments are case-insensitive (note that the
ritual argument expects a logical). Any argument set to \`NULL\` (the
default) will not be used to include/exclude spells from the returned
set of spells

## Usage

``` r
spell_list(
  name = NULL,
  class = NULL,
  level = NULL,
  school = NULL,
  ritual = NULL,
  cast_time = NULL,
  ver = "2014"
)
```

## Arguments

- name:

  (character) text to look for in spell names

- class:

  (character) character class(es) with the spell(s) on their list

- level:

  (character) "cantrip" and/or the minimum required spell slot level

- school:

  (character) school(s) of magic within which the spell belongs (e.g.,
  'evocation', 'necromancy', etc.)

- ritual:

  (logical) whether the spell can be cast as a ritual

- cast_time:

  (character) either the phase of a turn needed to cast the spell or the
  in-game time required (e.g., "reaction", "1 minute", etc.)

- ver:

  (character) which version of fifth edition to use ("2014" or "2024").
  Note that only 2014 is supported and entering "2024" will print a
  warning to that effect

## Value

(dataframe) 10 columns of information with one row per spell(s) that
fit(s) the user-specified criteria. If no spells fit the criteria,
returns a message to that effect instead of a data object

## Examples

``` r
# Search for evocation spells with 'fire' in the name that a wizard can cast
dndR::spell_list(name = "fire", class = "wizard", school = "evocation")
#>               spell_name                                         spell_source
#> 1              Fire Bolt Player's Handbook.241, System Reference Document.144
#> 2               Fireball Player's Handbook.241, System Reference Document.144
#> 3 Delayed Blast Fireball Player's Handbook.230, System Reference Document.133
#> 4            Fire Shield Player's Handbook.241, System Reference Document.144
#> 5           Wall of Fire Player's Handbook.285, System Reference Document.190
#>                                                                                                            pc_class
#> 1                                                                                       artificer, sorcerer, wizard
#> 2                   sorcerer, wizard, artificer: artillerist, cleric: light, warlock: fiend, warlock: genie efreeti
#> 3                                                                                                  sorcerer, wizard
#> 4      druid, sorcerer, wizard, artificer: armorer, artificer: battle smith, warlock: fiend, warlock: genie efreeti
#> 5 druid, sorcerer, wizard, artificer: artillerist, cleric: forge, cleric: light, warlock: celestial, warlock: fiend
#>   spell_level spell_school ritual_cast casting_time    range
#> 1     cantrip    evocation       FALSE     1 action 120 feet
#> 2     level 3    evocation       FALSE     1 action 150 feet
#> 3     level 7    evocation       FALSE     1 action 150 feet
#> 4     level 4    evocation       FALSE     1 action     self
#> 5     level 4    evocation       FALSE     1 action 120 feet
#>                                      components                      duration
#> 1                                          V, S                 instantaneous
#> 2 V, S, M (a tiny ball of bat guano and sulfur)                 instantaneous
#> 3 V, S, M (a tiny ball of bat guano and sulfur) concentration, up to 1 minute
#> 4   V, S, M (a bit of phosphorous or a firefly)                    10 minutes
#> 5         V, S, M (a small piece of phosphorus) concentration, up to 1 minute
```
