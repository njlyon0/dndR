# Return Vector of Supported DnD Damage Types

Simply returns a vector of damage types in DnD

## Usage

``` r
dnd_damage_types()
```

## Value

character vector of damage types

## Examples

``` r
# Full set of damage types included in DnD Fifth Edition (5e)
dndR::dnd_damage_types()
#>  [1] "acid"               "bludgeoning"        "cold"              
#>  [4] "fire"               "force"              "lightning"         
#>  [7] "necrotic"           "piercing"           "poison"            
#> [10] "psychic"            "radiant"            "slashing"          
#> [13] "thunder"            "non-magical damage"
```
