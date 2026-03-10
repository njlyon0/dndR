# Return Vector of Accepted Classes

Simply returns a vector of classes that \`class_block()\` accepts
currently. Submit an issue on the GitHub repository if you want a class
added.

## Usage

``` r
dnd_classes()
```

## Value

(character) vector of accepted class names

## Examples

``` r
# Want to check which classes this package supports?
dndR::dnd_classes()
#>  [1] "artificer" "barbarian" "bard"      "cleric"    "druid"     "fighter"  
#>  [7] "monk"      "paladin"   "ranger"    "rogue"     "sorcerer"  "warlock"  
#> [13] "wizard"   
```
