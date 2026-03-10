# Quickly Identify Monster Statistics

Quickly identify the vital statistics of a single creature worth the
provided experience points (XP) or Challenge Rating (CR). Uses the table
provided in p. 274-275 of the Dungeon Master's Guide. Accepts Challenge
Ratings of 0, '1/8', '1/4, and '1/2' in addition to numbers between 1
and 30. CR is \*not necessary\* to provide \*\*if\*\* XP is provided.

## Usage

``` r
monster_stats(xp = NULL, cr = NULL)
```

## Arguments

- xp:

  (numeric) experience point (XP) value of the monster

- cr:

  (numeric) challenge rating (CR) of the monster. Note that this is NOT
  necessary if XP is provided

## Value

(dataframe) two columns and eight rows

## Examples

``` r
# Identify monster statistics for a known challenge rating
dndR::monster_stats(cr = 4)
#> # A tibble: 8 × 2
#>   statistic    values 
#>   <chr>        <chr>  
#> 1 Challenge    4      
#> 2 DMG_XP       1100   
#> 3 Prof_Bonus   2      
#> 4 Armor_Class  14     
#> 5 HP_Range     116-130
#> 6 HP_Average   123    
#> 7 Attack_Bonus 5      
#> 8 Save_DC      14     

# Or XP value
dndR::monster_stats(xp = 2800)
#> # A tibble: 8 × 2
#>   statistic    values 
#>   <chr>        <chr>  
#> 1 Challenge    6      
#> 2 DMG_XP       2300   
#> 3 Prof_Bonus   3      
#> 4 Armor_Class  15     
#> 5 HP_Range     146-160
#> 6 HP_Average   153    
#> 7 Attack_Bonus 6      
#> 8 Save_DC      15     
```
