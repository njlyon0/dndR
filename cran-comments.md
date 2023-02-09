## R CMD check results

There were no ERRORs or WARNINGs. There are two NOTEs.

- One NOTE is that this is the first submission of this package to CRAN
- The other NOTE is returned by `devtools::check_rhub` and is as follows: 

```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```
As noted in [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this could be due to a bug/crash in MiKTeX and can likely be ignored.

## Downstream dependencies

There are currently no downstream dependencies for this package.
