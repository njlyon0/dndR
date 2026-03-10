# Character Creation

## Ability Score Rolling

The most fundamental aspect of a character–besides how you role play
their actions–are their ability scores. In fifth edition (“5e”) Dungeons
& Dragons, there are six ability scores: strength, dexterity,
constitution, intelligence, wisdom, and charisma.

There are a few common ways of rolling for these scores and the
`ability_scores` function accepts three of them. You can (A) roll four
six-sided dice drop the lowest value and sum the remaining three dice,
(B) roll three six-sided dice, or–for the truly wild–(C) roll a single
d20 and trust the dice gods to still give reasonable good scores.

Regardless of your chosen rolling method, if any score is less than 8 or
the total of all six scores is less than 70, a message will be printed
to let you know that you might be justified in re-rolling for your
character’s abilities. There is an optional `quiet` argument you can set
to `TRUE` if you don’t want that message to print regardless of the roll
outcomes.

``` r
# Roll for ability scores using the '4d6 drop lowest' method
dndR::ability_scores(method = "4d6")
#>   ability score
#> 1      V1    16
#> 2      V2    15
#> 3      V3    16
#> 4      V4    14
#> 5      V5    14
#> 6      V6    13
```

## Detailed Character Creation

If you are creating a player character and already have your desired
class and race in mind, you can go one step further and use `pc_creator`
to roll for ability scores, include racial modifiers to those scores,
assign your highest two scores to the “most important” abilities for
that class, and return final ability scores and modifiers as a
dataframe.

``` r
# Create a half orc barbarian
dndR::pc_creator(class = 'barbarian', race = 'half orc', score_method = "4d6")
#>   ability raw_score race_modifier score roll_modifier
#> 1     STR        14             2    16            +3
#> 2     DEX        10             0    10            +0
#> 3     CON        14             1    15            +2
#> 4     INT        11             0    11            +0
#> 5     WIS        14             0    14            +2
#> 6     CHA        11             0    11            +0
```

Note that to it does require under the hood tweaks to accept various
class/race information so not all character races or classes are
necessarily supported. I’m always happy to add support for new ones
though so feel free to [open a GitHub
Issue](https://github.com/njlyon0/dndR/issues) and I can add support for
the missing class(es)/race(s) in the next version of `dndR`.

You can check currently supported character races and classes with the
`dnd_races` and `dnd_classes` functions respectively.

``` r
# Identify supported character races
dndR::dnd_races()
#>  [1] "aarakocra"          "bugbear"            "changeling"        
#>  [4] "dark elf"           "dragonborn"         "drow"              
#>  [7] "forest gnome"       "goblin"             "half elf"          
#> [10] "half-elf"           "half orc"           "half-orc"          
#> [13] "high elf"           "hill dwarf"         "hobgoblin"         
#> [16] "human"              "kalashtar"          "lightfoot halfling"
#> [19] "mountain dwarf"     "orc"                "plasmoid"          
#> [22] "shifter"            "rock gnome"         "stout halfling"    
#> [25] "tiefling"           "warforged"          "wood elf"

# Identify supported character classes
dndR::dnd_classes()
#>  [1] "artificer" "barbarian" "bard"      "cleric"    "druid"     "fighter"  
#>  [7] "monk"      "paladin"   "ranger"    "rogue"     "sorcerer"  "warlock"  
#> [13] "wizard"
```

## Ability Modifiers

If you have a single ability score and want to remind yourself what roll
modifier that translates to, you can use the `mod_calc` function.

``` r
# What is the roll modifier for an ability score of 15?
dndR::mod_calc(score = 15)
#> [1] "+2"
```

## Player Level Calculation

If your party uses experience point (XP)-based leveling, you can quickly
determine your current level for your earned XP with the `pc_level_calc`
function. This function also returns what your proficiency bonus should
be and the minimum XP threshold for your current level.

Big thanks to Humberto Nappo for contributing this function!

``` r
# What level is a player character that earned 8,250 XP?
dndR::pc_level_calc(player_xp = 8250)
#>   player_level xp_threshold proficiency
#> 5            5         6500          +3
```

## Non-Player Characters (NPCs)

> **DM:** “You walk into the tavern and glance around the poorly-lit,
> grimy room. In a corner booth, you catch sight of the traitor you’ve
> been hunting these past two weeks–Tymoth Grissel. You nearly had him
> in the Sootpile mountains but that rockslide allowed him to escape by
> the skin of his teeth. He won’t escape this time.”

> **Player:** “Cool, cool, cool…but who *else* is in the tavern?

> **DM:** …

When I’m DMing, I sometimes struggle with improvising background
non-player characters (NPCs) that aren’t relevant to the current
questlines when my player ask about them. To hopefully help fellow DMs,
`dndR` includes a function to let you quickly respond in situations like
the one I’ve described above. The `npc_creator` function quickly
generates a full name (first and last) and selects a random race and job
for however many NPCs you need.

``` r
# Make three NPCs
dndR::npc_creator(npc_count = 3)
#>            name   species        job
#> 1   Natyan Sage   bugbear inquisitor
#> 2  Rjila Tanner  half-elf    acolyte
#> 3 Viktorja Arch aarakocra  navigator
```

If your players decide to go chat with the goblin carpenter passing them
on the street (or whoever else they cross paths with) you can then
improvise more details about that particular NPC as needed. Hopefully
this function helps you skip the “uh…” step of trying to on-the-fly come
up with some brief NPC descriptions that give depth to your world.

Note that because both NPC race and job are selected randomly you may
wind up with some unusual combinations. I hope that adds to the fun but
feel free to re-run the function until you get NPCs that fit your world
and intended tone.
