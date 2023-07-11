## R CMD check results

There were no ERRORs or WARNINGs. There were two NOTEs.


`devtools::check_rhub()` returns this note:

```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```

As noted in [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this could be due to a bug/crash in MiKTeX and can likely be ignored.

`devtools::check_rhub()` also returns this note:

```
checking for non-standard things in the check directory ... NOTE
  Found the following files/directories:
    ''NULL''
```

[R-hub issue #560](https://github.com/r-hub/rhub/issues/560) indicates that this note can also is not related to any issue with this package and can be ignored.

### Changes per CRAN Reviewer Instructions

- Fixed a broken URL ("htttps" -> "https")

## Downstream dependencies

There are currently no downstream dependencies for this package.
