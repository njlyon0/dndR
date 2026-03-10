# Dungeons and Dragons Quick Table for Creature Statistics

On pages 274 and 275 in the Dungeon Master's Guide (Fifth Edition; 2014
version) there are two tables that relate creature Challenge Rating (CR)
to various vital statistics (armor, hit points, etc.) and to Experience
Points (XP). These tables have been transcribed into this data object
for ease of reference.

## Usage

``` r
monster_table
```

## Format

Dataframe with 8 columns and 34 rows

- Challenge:

  Challenge Rating (CR) expressed as a number

- DMG_XP:

  Experience Points (XP) for that CR as dictated by the DMG

- Prof_Bonus:

  Modifier to add to rolls where the creature is proficient

- Armor_Class:

  Armor class of the creature

- HP_Range:

  Range of hit points (HP) for the creature

- HP_Average:

  Average of minimum and maximum HP of range for the creature

- Attack_Bonus:

  Modifier to add to the creature's attack rolls

- Save_DC:

  Save Difficulty Class (DC) for rolls against the creature's spells /
  certain abilities

## Source

Mearls, M., Crawford, J., Perkins, C., Wyatt, J. et al. Dungeon Master's
Guide (Fifth Edition). Wizards of the Coast 2014
