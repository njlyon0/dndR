# List Creatures Based on Criteria

Query list of fifth edition Dungeons & Dragons creatures (2014 version)
based on partial string matches between user inputs and the relevant
column of the creature information data table. Currently supports users
querying the creature list by creature name, size, type, source
document, experience point (XP), and challenge rating (CR). All
characters arguments are case-insensitive. XP and CR may be specified as
either characters or numbers but match to creature must be exact in
either case (rather than partial). Any argument set to \`NULL\` (the
default) will not be used to include/exclude creatures from the returned
set of creatures

## Usage

``` r
creature_list(
  name = NULL,
  size = NULL,
  type = NULL,
  source = NULL,
  xp = NULL,
  cr = NULL,
  ver = "2014"
)
```

## Arguments

- name:

  (character) text to look for in creature names

- size:

  (character) size(s) of creature

- type:

  (character) creature 'type' (e.g., "undead", "elemental", etc.)

- source:

  (character) source book/document of creature

- xp:

  (character/numeric) experience point (XP) value of creature (note this
  must be an exact match as opposed to partial matches tolerated by
  other arguments)

- cr:

  (character/numeric) challenge rating (CR) value of creature (note this
  must be an exact match as opposed to partial matches tolerated by
  other arguments)

- ver:

  (character) which version of fifth edition to use ("2014" or "2024").
  Note that only 2014 is supported and entering "2024" will print a
  warning to that effect

## Value

(dataframe) Up to 23 columns of information with one row per creature(s)
that fit(s) the user-specified criteria. Fewer columns are returned when
no creatures that fit the criteria have information for a particular
category (e.g., if no queried creatures have damage vulnerabilities,
that column will be excluded from the results). If no creatures fit the
criteria, returns a message to that effect instead of a data object

## Examples

``` r
# Identify medium undead creatures from the Monster Manual worth 450 XP
dndR::creature_list(type = "undead", size = "medium", source = "monster manual", xp = 450)
#>   creature_name creature_source     STR     DEX    CON    INT    WIS    CHA
#> 1         Ghast  Monster Manual 16 (+3) 17 (+3) 10 (0) 11 (0) 10 (0) 8 (-1)
#> 2   Poltergeist  Monster Manual  1 (-5) 14 (+2) 11 (0) 10 (0) 10 (0) 11 (0)
#>   creature_size creature_type creature_alignment creature_xp creature_cr
#> 1        medium        undead       chaotic evil         450           2
#> 2        medium        undead       chaotic evil         450           2
#>                                                   languages
#> 1                                                    common
#> 2 understands all languages it knew in life but can't speak
#>                       speed hit_points armor_class            senses
#> 1                    30 ft.   36 (8d8)          13 darkvision 60 ft.
#> 2 0 ft., fly 50 ft. (hover)   22 (5d8)          12 darkvision 60 ft.
#>   damage_immunities
#> 1          necrotic
#> 2  necrotic, poison
#>                                                                                  damage_resistances
#> 1                                                                                                  
#> 2 acid, cold, fire, lightning, thunder, bludgeoning, piercing, and slashing from nonmagical weapons
#>                                                                            condition_immunities
#> 1                                                                                      poisoned
#> 2 charmed, exhaustion, grappled, paralyzed, petrified, poisoned, prone, restrained, unconscious
```
