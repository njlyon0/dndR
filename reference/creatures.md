# Dungeons and Dragons Creature Information

Creatures in fifth edition Dungeons and Dragons all fall into certain,
well-documented categories. This table summarizes all of that
information (for the 2014 version of the rules) into a long format
dataframe for easy navigation. Unless otherwise noted, all creature
querying functions in \`dndR\` use this table as their starting point.

## Usage

``` r
creatures
```

## Format

Dataframe with 26 columns and 1721 rows

- creature_name:

  Name of the creature

- creature_source:

  Source book for the creature

- STR:

  Strength ability score of creature with roll modifier indicated
  parenthetically

- DEX:

  Dexterity ability score of creature with roll modifier indicated
  parenthetically

- CON:

  Constitution ability score of creature with roll modifier indicated
  parenthetically

- INT:

  Intelligence ability score of creature with roll modifier indicated
  parenthetically

- WIS:

  Wisdom ability score of creature with roll modifier indicated
  parenthetically

- CHA:

  Charisma ability score of creature with roll modifier indicated
  parenthetically

- creature_size:

  Size category of the creature (one of 'tiny', 'small', 'medium',
  'large', 'huge', or 'gargantuan')

- creature_type:

  Type of the creature (e.g., undead, elemental, etc.)

- creature_alignment:

  The creature's alignment (e.g., chaotic evil, etc.)

- creature_xp:

  Experience point (XP) value of the creature

- creature_cr:

  Challenge rating (CR) of the creature

- languages:

  Any languages understood or spoken by the creature

- skills:

  Any skills in which the creature is proficient and the roll modifiers
  for each

- speed:

  Movement speed of the creature

- hit_points:

  Number of hit points (HP) of the creature (and the dice to roll if
  rolling for HP is desired)

- armor_class:

  Armor class of the creature

- senses:

  Any special senses of the creature

- saving_throws:

  Any saving throws in which the creature is proficient and the roll
  modifiers for each

- damage_immunities:

  Damage types to which the creature is immune (i.e., no damage)

- damage_resistances:

  Damage types to which the creature is resistant (i.e., half damage)

- damage_vulnerabilities:

  Damage types to which the creature is vulnerable (i.e., double damage)

- condition_immunities:

  Conditions to which the creature is immune

- abilities:

  Description of all abilities the creature has as well as any bonus
  actions or reactions it can take. Each item name is surrounded by
  triple asterisks

- actions:

  Description of all actions the creature can take. Each item name is
  surrounded by triple asterisks

## Source

Crawford, J., Hickman, L., Hickman, T., Lee, A., Perkins, C., Whitters,
R. Curse of Strahd. Wizards of the Coast 2015.

Waterdeep: Dungeon of the Mad Mage. Wizards of the Coast 2018.

Elemental Evil. Wizards of the Coast 2015.

Explorer's Guide to Wildemount. Wizards of the Coast 2020.

Guildmasters' Guide to Ravnica. Wizards of the Coast 2018.

Lost Mine of Phandelver. Wizards of the Coast 2014.

Mearls, M. and Crawford, J. Dungeons & Dragons Monster Manual (Fifth
Edition). Wizards of the Coast 2014

Morenkainen's Tome of Foes. Wizards of the Coast 2018.

Out of the Abyss. Wizards of the Coast 2015.

Storm King's Thunder. Wizards of the Coast 2016.

Tales from the Yawning Portal. Wizards of the Coast 2017.

Tomb of Annihilation. Wizards of the Coast 2017.

Baur, W. Tome of Beasts. Paizo Inc. 2016.

Tome of Horrors. Frog God Games 2019.

Tyranny of Dragons. Wizards of the Coast 2015.

Volo's Guide to Monsters. Wizards of the Coast 2016.
