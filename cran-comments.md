## Test environments
* local Windows 11 install, R version 4.6.1
* win-builder R Under development (unstable) (2026-09-10 r90519 ucrt)

## R CMD check results
0 errors | 0 warnings | 0 notes

## Reverse dependencies

> tools::package_dependencies("mvinfluence", reverse = TRUE, which = "most")
[1] "heplots"

heplots's own vignettes (including `Robust.Rmd`, which calls `mvinfluence::influencePlot()`)
were re-rendered against this version with no errors, as a smoke test in lieu of a full
`revdepcheck()` run.

## Comments
This release bundles two maintenance versions since the last CRAN submission (0.9.2):

### Version 0.9.4
o Fix bug in `mlm.influence()` where models with transformed response variables (e.g.,
  `lm(cbind(log(y1), log(y2)) ~ ...)`) caused an error in the internal `vec()` helper because the
  coefficient matrix lacked column names
o Add "Comparing Coefficients" section to `vignette("uni-vs-multi")`
o Fix `Jfuns.Rd` picking up bogus `\keyword{}` entries from an adjacent roxygen block

### Version 0.9.3
o Add warning for weights in influence diagnostics

### Version 0.9.2 (previously released)
o Revise notation in mvinfluence-package
o Point to R-universe dev version
o Add schooldata examples
o Now depends: R (>= 4.1.0)
o Corrected duplicate aliases and missing/incorrect links in Rd files


