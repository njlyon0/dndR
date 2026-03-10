# Spells

## Searching for Spells

There are *a lot* of spells in the various Dungeons & Dragons source
books that your character might be able to invoke. Finding specific
spells can be a daunting task in the face of the sheer number of spells
that exist so `dndR` has some functions to hopefully make this effort
more manageable for your magic-using player characters and NPCs.

The `spell_list` function lets you search through official spells based
on several criteria that you specify. A dataframe including all of the
big-picture information for spells that meet your criteria is returned
to help orient you for any subsequent steps you plan on taking. Note
that all `spell_list` arguments that accept characters are case
*in*-sensitive and queries use partial string matching so you don’t need
to try to engineer exact matches.

This function lets you can query spells based on one or more of the
following criteria:

- Spell name(s)
- Character classes with access to the spell(s)
- Minimum spell slot required to cast the spell and/or “cantrip”
- School(s) of magic to which the spell belongs (e.g., “abjuration”,
  etc.)
- Whether or not the spell can be cast as a ritual
- Time to cast the spell (either the phase of a turn required or the
  in-game time for spells that take more than one turn to cast)

``` r
# Find all sorcerer spells that have the word 'bolt' in the name
bolt_df <- dndR::spell_list(name = "bolt", class = "sorcerer")

# Check the structure of that output
str(bolt_df)
#> 'data.frame':    4 obs. of  10 variables:
#>  $ spell_name  : chr  "Fire Bolt" "Witch Bolt" "Lightning Bolt" "Chaos Bolt"
#>  $ spell_source: chr  "Player's Handbook.241, System Reference Document.144" "Player's Handbook.289" "Player's Handbook.255, System Reference Document.159" "Xanathar's Guide to Everything.151"
#>  $ pc_class    : chr  "artificer, sorcerer, wizard" "sorcerer, warlock, wizard" "sorcerer, wizard, artificer: armorer, druid: mountain, warlock: fathomless" "sorcerer"
#>  $ spell_level : chr  "cantrip" "level 1" "level 3" "level 1"
#>  $ spell_school: chr  "evocation" "evocation" "evocation" "evocation"
#>  $ ritual_cast : logi  FALSE FALSE FALSE FALSE
#>  $ casting_time: chr  "1 action" "1 action" "1 action" "1 action"
#>  $ range       : chr  "120 feet" "30 feet" "self (100-foot line)" "120 feet"
#>  $ components  : chr  "V, S" "V, S, M (a twig from a tree that has been struck by lightning)" "V, S, M (a bit of fur and a rod of amber, crystal, or glass)" "V, S"
#>  $ duration    : chr  "instantaneous" "concentration, up to 1 minute" "instantaneous" "instantaneous"
#>  - attr(*, "groups")= tibble [4 × 1] (S3: tbl_df/tbl/data.frame)
#>   ..$ .rows: list<int> [1:4] 
#>   .. ..$ : int 1
#>   .. ..$ : int 2
#>   .. ..$ : int 3
#>   .. ..$ : int 4
#>   .. ..@ ptype: int(0)
```

``` r
# Find all seventh-level necromancy spells in the wizard spell list
necro_df <- dndR::spell_list(school = "necromancy", class = "wizard", level = 7)

# Check the structure
str(necro_df)
#> 'data.frame':    2 obs. of  10 variables:
#>  $ spell_name  : chr  "Finger of Death" "Tether Essence"
#>  $ spell_source: chr  "Player's Handbook.241, System Reference Document.144" "Explorer's Guide to Wildemount.189"
#>  $ pc_class    : chr  "sorcerer, warlock, wizard" "wizard: chronurgy, wizard: graviturgy"
#>  $ spell_level : chr  "level 7" "level 7"
#>  $ spell_school: chr  "necromancy" "necromancy"
#>  $ ritual_cast : logi  FALSE FALSE
#>  $ casting_time: chr  "1 action" "1 action"
#>  $ range       : chr  "60 feet" "60 feet"
#>  $ components  : chr  "V, S" "V, S, M (a spool of platinum cord worth at least 250 gp, which the spell consumes)"
#>  $ duration    : chr  "instantaneous" "concentration, up to 1 hour"
#>  - attr(*, "groups")= tibble [2 × 1] (S3: tbl_df/tbl/data.frame)
#>   ..$ .rows: list<int> [1:2] 
#>   .. ..$ : int 1
#>   .. ..$ : int 2
#>   .. ..@ ptype: int(0)
```

## Spell Descriptions

If you need to access the specific description of a particular spell (or
spells), you can use the `spell_text` function. This returns an R-style
dataframe equivalent of the sort of spell card information you’d find in
the back of a typical D&D source book.

``` r
# Get the Chill Touch spell description
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

I typically use this function to get more detail on a particular spell
after searching more broadly with `spell_list` but I think it’s also
nice as a quick reference if you need to consult the specific language
of the spell description or remind yourself how casting the spell with a
higher level spell slot affects the spell.
