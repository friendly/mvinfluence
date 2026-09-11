# Convert an inflmlm object to a data frame

This function is used internally in the package to convert the result of
[`mlm.influence()`](http://friendly.github.io/mvinfluence/reference/mlm.influence.md)
to a data frame. It is not normally called by the user.

## Usage

``` r
# S3 method for class 'inflmlm'
as.data.frame(x, ..., FUN = det, funnames = TRUE)
```

## Arguments

- x:

  An `inflmlm` object, as returned by `mlm.influence`

- ...:

  ignored

- FUN:

  in the case where the subset size, `m>1`, the function used on the
  `H, Q, L, R` to calculate a single statistic. The default is `det`. An
  alternative is `tr`, for matrix trace.

- funnames:

  logical. Should the `FUN` name be prepended to the statistics when
  creating a data frame?

## Value

A data frame containing the influence statistics

## Examples

``` r
# none
```
