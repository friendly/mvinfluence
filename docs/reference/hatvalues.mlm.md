# Hatvalues for a MLM

The functions `cooks.distance.mlm` and `hatvalues.mlm` are designed as
extractor functions for regression deletion diagnostics for multivariate
linear models following Barrett & Ling (1992). These are close analogs
of methods for univariate and generalized linear models handled by the
[`influence.measures`](https://rdrr.io/r/stats/influence.measures.html)
in the `stats` package.

## Usage

``` r
# S3 method for class 'mlm'
hatvalues(model, m = 1, infl, ...)
```

## Arguments

- model:

  An object of class `mlm`, as returned by
  [`lm`](https://rdrr.io/r/stats/lm.html)

- m:

  The size of subsets to be considered

- infl:

  An `inflmlm` object, as returned by `mlm.influence`

- ...:

  Other arguments, for compatibility with the generic; ignored.

## Value

A vector of hatvalues

## Details

Hat values are a component of influence diagnostics, measuring the
leverage or outlyingness of observations in the space of the predictor
variables.

The usual case considers observations one at a time (`m=1`), where the
hatvalue is proportional to the squared Mahalanobis distance, \\D^2\\ of
each observation from the centroid of all observations. This function
extends that definition to calculate a comparable quantity for subsets
of size `m>1`.

## References

Barrett, B. E. and Ling, R. F. (1992). General Classes of Influence
Measures for Multivariate Regression. *Journal of the American
Statistical Association*, **87**(417), 184-191.

## See also

[`cooks.distance.mlm`](http://friendly.github.io/mvinfluence/reference/cooks.distance.mlm.md)

## Examples

``` r
data(Rohwer, package="heplots")
Rohwer2 <- subset(Rohwer, subset=group==2)
rownames(Rohwer2)<- 1:nrow(Rohwer2)
Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)

options(digits=3)
hatvalues(Rohwer.mod)
#>      1      2      3      4      5      6      7      8      9     10     11 
#> 0.1670 0.2185 0.1417 0.0731 0.5682 0.1543 0.0453 0.1766 0.0513 0.4516 0.1454 
#>     12     13     14     15     16     17     18     19     20     21     22 
#> 0.1705 0.1037 0.1265 0.3325 0.3318 0.1732 0.2635 0.2984 0.0788 0.1402 0.1938 
#>     23     24     25     26     27     28     29     30     31     32 
#> 0.0446 0.2064 0.1571 0.1533 0.3673 0.1119 0.3043 0.0866 0.0892 0.0732 
cooks.distance(Rohwer.mod)
#>       1       2       3       4       5       6       7       8       9      10 
#> 0.11067 0.03576 0.07411 0.00645 0.84672 0.01458 0.02530 0.14768 0.04040 0.06339 
#>      11      12      13      14      15      16      17      18      19      20 
#> 0.04568 0.11629 0.04267 0.16427 0.01519 0.11832 0.14448 0.05671 0.17321 0.03733 
#>      21      22      23      24      25      26      27      28      29      30 
#> 0.15164 0.04025 0.03036 0.07294 0.26008 0.04261 0.33866 0.03422 0.30260 0.04505 
#>      31      32 
#> 0.09758 0.05503 
```
