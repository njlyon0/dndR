# Calculate Total XP of Monsters for Given Party Level and Difficulty

Returns the total XP (experience points) of all creatures that would
make an encounter the specified level of difficulty for a party of the
supplied level. This 'pool' can be used by a GM (game master) to
"purchase" monsters to identify how many a party is likely to be able to
handle given their average level. This function supports both 2014 and
2024 versions of fifth edition D&D. Note that the returned pool does not
take into account creature-specific abilities or traits so care should
be taken if a monster has many such traits that modify its difficulty
beyond its experience point value.

## Usage

``` r
xp_pool(party_level = NULL, party_size = NULL, ver = NULL, difficulty = NULL)
```

## Arguments

- party_level:

  (numeric) integer indicating the \_average\_ party level. If all
  players are the same level, that level is the average party level.
  Non-integer values are supported but results will be slightly affected

- party_size:

  (numeric) integer indicating how many player characters (PCs) are in
  the party

- ver:

  (character) which version of fifth edition to use ("2014" or "2024")

- difficulty:

  (character) one of a specific set of encounter difficulty level names.
  If \`ver = "2014"\`, this must be one of "easy", "medium", "hard", or
  "deadly" while for \`ver = "2024"\` it must instead be one of "low",
  "moderate", or "high"

## Value

(numeric) total encounter XP as an integer

## Examples

``` r
# Supply a party level and difficulty and get the total XP of such an encounter
dndR::xp_pool(party_level = 3, party_size = 2, ver = "2014", difficulty = "medium")
#> [1] 300

# Calculate the XP pool for the same party under the 2024 rules
dndR::xp_pool(party_level = 3, party_size = 2, ver = "2024", difficulty = "moderate")
#> [1] 450
```
