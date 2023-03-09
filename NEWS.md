## dndR Version 1.1.0

Development version of `dndR`. The following changes from the preceding version have been made:

- `roll` now supports three-sided dice (i.e., "d3")
- `roll` now includeds a `show_dice` argument that accepts either `TRUE` or `FALSE` (the default). If `show_dice = T` (and more than one die is rolled), the individual die results will be returned as a message in addition to the sum of their results. Note that the behavior of "2d20" is unchanged and both values are returned as a two-column, one-row dataframe

## dndR Version 1.0.0

This is the first fully functioning version of the package. There are currently no ERRORs, WARNINGs, or NOTEs returned by `devtools::check()`
