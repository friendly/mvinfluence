# Cook's distance for a MLM

The functions `cooks.distance.mlm` and `hatvalues.mlm` are designed as
extractor functions for regression deletion diagnostics for multivariate
linear models following Barrett & Ling (1992). These are close analogs
of methods for univariate and generalized linear models handled by the
[`influence.measures`](https://rdrr.io/r/stats/influence.measures.html)
in the `stats` package.

## Usage

``` r
# S3 method for class 'mlm'
cooks.distance(model, infl = mlm.influence(model, do.coef = FALSE), ...)
```

## Arguments

- model:

  A `mlm` object, fit by [`lm()`](https://rdrr.io/r/stats/lm.html)

- infl:

  A `inflmlm` object. The default simply runs
  [`mlm.influence()`](http://friendly.github.io/mvinfluence/reference/mlm.influence.md)
  on the model, suppressing coefficients.

- ...:

  Ignored

## Value

A vector of Cook's distances

## Details

In addition, the functions provide diagnostics for deletion of subsets
of observations of size `m>1`.

## References

Barrett, B. E. and Ling, R. F. (1992). General Classes of Influence
Measures for Multivariate Regression. *Journal of the American
Statistical Association*, **87**(417), 184-191.

## Examples

``` r

data(Rohwer, package="heplots")
Rohwer2 <- subset(Rohwer, subset=group==2)
rownames(Rohwer2)<- 1:nrow(Rohwer2)
Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)

hatvalues(Rohwer.mod)
#>          1          2          3          4          5          6          7 
#> 0.16700926 0.21845327 0.14173469 0.07314341 0.56821462 0.15432157 0.04530969 
#>          8          9         10         11         12         13         14 
#> 0.17661104 0.05131298 0.45161152 0.14542776 0.17050399 0.10374592 0.12649927 
#>         15         16         17         18         19         20         21 
#> 0.33246744 0.33183461 0.17320579 0.26353864 0.29835817 0.07880597 0.14023750 
#>         22         23         24         25         26         27         28 
#> 0.19380286 0.04455330 0.20641708 0.15712604 0.15333879 0.36726467 0.11189754 
#>         29         30         31         32 
#> 0.30426999 0.08655434 0.08921878 0.07320950 
cooks.distance(Rohwer.mod)
#>           1           2           3           4           5           6 
#> 0.110668789 0.035758983 0.074110633 0.006454502 0.846717339 0.014584590 
#>           7           8           9          10          11          12 
#> 0.025295531 0.147676200 0.040403408 0.063391985 0.045680183 0.116293594 
#>          13          14          15          16          17          18 
#> 0.042671229 0.164273594 0.015190817 0.118323491 0.144482540 0.056707069 
#>          19          20          21          22          23          24 
#> 0.173206386 0.037332773 0.151642786 0.040245143 0.030356681 0.072943655 
#>          25          26          27          28          29          30 
#> 0.260083518 0.042608984 0.338661595 0.034223968 0.302596343 0.045051960 
#>          31          32 
#> 0.097583942 0.055032090 
```
