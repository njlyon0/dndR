# Finding & Making Creatures

Whether they come from a standard source book or the darker corners of
your imagination, the creatures your party faces can have a dramatic
influence on the tone of your sessions and your players’ experience. The
following functions are meant to help DMs either find creatures that
meet their needs or homebrew new antagonists to face off against their
players.

## Standard Creatures

### Searching with Criteria

If you want to identify creatures defined by official D&D source books,
the `creature_list` function can be a helpful mechanism for narrowing
your search. This function lets you search through official creatures
based on criteria you specify. A dataframe including all of the
big-picture information for creatures that meet your criteria is
returned to help orient you for any subsequent steps you plan on taking.
Note that all `creature_list` arguments that accept characters are case
*in*-sensitive and queries use partial string matching so you don’t need
to try to engineer exact matches.

See the help file for `monster_list` for the full list of supported
query criteria.

``` r
# Find all small creatures with 'goblin' in their name
gobbo_df <- dndR::creature_list(name = "goblin", size = "small")

# Check the structure of that output
str(gobbo_df)
#> 'data.frame':    7 obs. of  23 variables:
#>  $ creature_name       : chr  "Dust Goblin" "Fire Goblin" "Goblin" "Goblin Boss" ...
#>  $ creature_source     : chr  "Tome Of Beasts" "Tome Of Horrors" "Monster Manual" "Monster Manual" ...
#>  $ STR                 : chr  "8 (-1)" "14 (+2)" "8 (-1)" "10 (0)" ...
#>  $ DEX                 : chr  "16 (+3)" "18 (+4)" "14 (+2)" "14 (+2)" ...
#>  $ CON                 : chr  "14 (+2)" "13 (+1)" "10 (0)" "10 (0)" ...
#>  $ INT                 : chr  "10 (+0)" "16 (+3)" "10 (0)" "10 (0)" ...
#>  $ WIS                 : chr  "8 (-1)" "10 (+0)" "8 (-1)" "8 (-1)" ...
#>  $ CHA                 : chr  "8 (-1)" "12 (+1)" "8 (-1)" "10 (0)" ...
#>  $ creature_size       : chr  "small" "small" "small" "small" ...
#>  $ creature_type       : chr  "humanoid" "humanoid" "humanoid (goblinoid)" "humanoid (goblinoid)" ...
#>  $ creature_alignment  : chr  "neutral evil" "neutral evil" "neutral evil" "neutral evil" ...
#>  $ creature_xp         : num  50 2900 50 200 100 1100 200
#>  $ creature_cr         : num  0.25 7 0.25 1 0.5 4 1
#>  $ languages           : chr  "common, goblin" "common, goblin, sylvan" "common, goblin" "common, goblin" ...
#>  $ skills              : chr  "Stealth +7" "Deception +4, Perception +3, Stealth +7" "Stealth +6" "Stealth +6" ...
#>  $ speed               : chr  "40 ft." "20 ft." "30 ft." "30 ft." ...
#>  $ hit_points          : chr  "5 (1d6 + 2)" "45 (10d6 + 10)" "7 (2d6)" "21 (6d6)" ...
#>  $ armor_class         : chr  "14 (leather armor)" "15 (natural armor)" "15 (leather armor, shield)" "17 (chain shirt, shield)" ...
#>  $ senses              : chr  "darkvision 60 ft., passive perception 9" "darkvision 120 ft., passive perception 13" "darkvision 60 ft." "darkvision 60 ft." ...
#>  $ saving_throws       : chr  "" "DEX +7, CON +4" "" "" ...
#>  $ damage_immunities   : chr  "" "fire" "" "" ...
#>  $ damage_resistances  : chr  "" "lightning; bludgeoning, piercing, and slashing from nonmagical weapons" "" "" ...
#>  $ condition_immunities: chr  "charmed, frightened" "" "" "" ...
#>  - attr(*, "groups")= tibble [7 × 1] (S3: tbl_df/tbl/data.frame)
#>   ..$ .rows: list<int> [1:7] 
#>   .. ..$ : int 1
#>   .. ..$ : int 2
#>   .. ..$ : int 3
#>   .. ..$ : int 4
#>   .. ..$ : int 5
#>   .. ..$ : int 6
#>   .. ..$ : int 7
#>   .. ..@ ptype: int(0)
```

### Creature Descriptions

If you need to access the specific description of a particular creature
(or creatures), you can use the `creature_text` function. This returns
an R-style dataframe equivalent of the sort of creature card information
you’d find in the back of a typical D&D source book.

``` r
# Get the information for a hunter shark
shark_df <- dndR::creature_text(name = "hunter shark")

# Check that out
head(shark_df, n = 7)
#>             Hunter Shark
#> 1 Source: Monster Manual
#> 2           STR: 18 (+4)
#> 3           DEX: 13 (+1)
#> 4           CON: 15 (+2)
#> 5            INT: 1 (-5)
#> 6            WIS: 10 (0)
#> 7            CHA: 4 (-3)
```

## Generic Monster Stats

### Converting Challenge Rating to XP

The DMG provides a table (see p. 274) that gives the vital statistics of
creatures based on their Challenge Rating (CR) but this table can be
cumbersome to compare to Experience Points (XP) which are the numbers
actually used to balance encounter difficulty. While there are functions
that go further, at its simplest it can be nice to convert CR into XP.
To that end, the `cr_convert` function can perform this conversion
without too much stress.

``` r
# Convert a CR of 5 into equivalent XP
dndR::cr_convert(cr = 5)
#> [1] 1690
```

Now that we can do this conversion easily, we can use other `dndR`
functions to go further.

### Monster Statistics Table

As referenced above, the DMG provides a nice table linking CR to
standard monster statistics. If you’d rather avoid using that table you
can instead use the `monster_stats` function to gather the information
for which you are looking. To use this function, input either the XP you
want to spend on this creature *or* the Challenge Rating (CR) if you
know it.

Once either XP or CR is provided, `monster_stats` returns the creature’s
statistics as they appear in the DMG for a *single* creature of that
difficulty.

``` r
# Find the statistics of a single creature worth 8,000 XP
dndR::monster_stats(xp = 8000)
#> # A tibble: 8 × 2
#>   statistic    values 
#>   <chr>        <chr>  
#> 1 Challenge    11     
#> 2 DMG_XP       7200   
#> 3 Prof_Bonus   4      
#> 4 Armor_Class  17     
#> 5 HP_Range     221-235
#> 6 HP_Average   228    
#> 7 Attack_Bonus 8      
#> 8 Save_DC      17
```

Note that if both CR and XP are specified, XP is ignored in favor of CR.
My assumption is that if you use CR you prefer it over XP.

## Homebrew Monsters

If you’d rather lean more into homebrewing your own monsters, the
`monster_creator` function may be of interest. This function follows the
advice of [Zee Bashew](https://twitter.com/Zeebashew) on how to build
interesting, challenging monsters for your party. These monsters are
built somewhat according to the Dungeon Master’s Guide for creating
monsters, partly Zee’s [YouTube video on homebrewing monsters based on
the video game *The
Witcher*](https://www.youtube.com/watch?v=GhjkPv4qo5w), and partly on my
own intuition about scaling the difficulty of a creature.

Creatures are spawned randomly so you may need to re-run the function
several times (or mentally modify one or more parts of the output) to
get a monster that fits your campaign and players. Each creature is
provided with up to five damage resistances, up to two damage
immunities, and a single damage vulnerability. This combination allows
you to build complex and mysterious homebrew monsters with plenty of
opportunities to reward player investigation and insight in discovering
the monster’s strengths and weaknesses before the final showdown.

``` r
# Make a monster for a 4-person party of level 5
dndR::monster_creator(party_level = 5, party_size = 4)
#>             statistic                                                  value
#> 1          Hit_Points                                                     92
#> 2         Armor_Class                                                     16
#> 3          Prof_Bonus                                                      3
#> 4        Attack_Bonus                                                      7
#> 5             Save_DC                                                     16
#> 6  Prof_Saving_Throws                                               WIS; INT
#> 7           Immune_to                                       poison; slashing
#> 8        Resistant_to necrotic; fire; non-magical damage; psychic; lightning
#> 9       Vulnerable_to                                                  force
#> 10                STR                                                     +2
#> 11                DEX                                                     +3
#> 12                CON                                                     +2
#> 13                INT                                                     +1
#> 14                WIS                                                     +3
#> 15                CHA                                                     +1
```

Note that if you use `monster_creator` you may need to help your players
identify the creature’s immunities and vulnerabilities *before* the
actual confrontation with the creature to avoid sending them into a
fight that is more difficult than your party can handle.
