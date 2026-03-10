# Create a Non-Player Character (NPC)

Randomly generates a name for a user-specified number of Non-Player
Characters (NPCs) as well as a species (a.k.a. "race" in 2014 rules) and
a job. Shout out to Billy Mitchell for providing the work to include
names for NPCs.

## Usage

``` r
npc_creator(npc_count = 1)
```

## Arguments

- npc_count:

  (numeric) number of NPCs for which to return names, species, and
  positions

## Value

(dataframe) dataframe with three columns (one each for name, race, and
job) and a number of rows equal to \`npc_count\`

## Examples

``` r
# Create some information for an NPC
dndR::npc_creator(npc_count = 1)
#>              name  species        job
#> 1 Kimbera Richett half orc ambassador
```
