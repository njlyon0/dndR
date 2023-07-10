# Welcome to `dndR`'s Development Area

If you are contributing scripts or data files please add them into this folder! The reason for this is that this folder's contents are automatically ignored by the package build. This means that if these new files contain any errors (or are simply not in the [required formatting for functions in an R package](https://cran.r-project.org/web/packages/roxygen2/vignettes/roxygen2.html)) they won't break the development version of `dndR`.

See `CONTRIBUTING.md` for more specifics about contributing functions to `dndR` and feel free to [post an issue](https://github.com/njlyon0/dndR/issues) if something about this documentation is unclear.

## Note on Scripts

- Any script that begins with `update-` is necessary for taking an external data file (also housed in `dev` folder) and processing it into the version of the data that is embedded in `dndR`. The name of the script after "update-" is an exact match for the name of the internal data object
