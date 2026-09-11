# Calculate Regression Deletion Diagnostics for Multivariate Linear Models

`mlm.influence` is the main computational function in this package. It
is usually not called directly, but rather via its alias,
[`influence.mlm`](http://friendly.github.io/mvinfluence/reference/influence.mlm.md),
the S3 method for a `mlm` object.

## Usage

``` r
mlm.influence(model, do.coef = TRUE, m = 1, ...)
```

## Arguments

- model:

  An `mlm` object, as returned by
  [`lm`](https://rdrr.io/r/stats/lm.html) with a multivariate response.

- do.coef:

  logical. Should the coefficients be returned in the `inflmlm` object?

- m:

  Size of the subsets for deletion diagnostics

- ...:

  Further arguments passed to other methods

## Value

`mlm.influence` returns an S3 object of class `inflmlm`, a list with the
following components:

- m:

  Deletion subset size

- H:

  Hat values, \\H_I\\. If `m=1`, a vector of diagonal entries of the
  ‘hat’ matrix. Otherwise, a list of \\m\times m\\ matrices
  corresponding to the `subsets`.

- Q:

  Residuals, \\Q_I\\.

- CookD:

  Cook's distance values

- L:

  Leverage components

- R:

  Residual components

- subsets:

  Indices of the observations in the subsets of size `m`

- labels:

  Observation labels

- call:

  Model call for the `mlm` object

- Beta:

  Deletion regression coefficients– included if`do.coef=TRUE`

## Details

The computations and methods for the `m=1` case are straight-forward, as
are the computations for the `m>1` case. Associated methods for `m>1`
are still under development.

## References

Barrett, B. E. and Ling, R. F. (1992). General Classes of Influence
Measures for Multivariate Regression. *Journal of the American
Statistical Association*, **87**(417), 184-191.

Barrett, B. E. (2003). Understanding Influence in Multivariate
Regression. *Communications in Statistics – Theory and Methods*, **32**,
3, 667-680.

## See also

[`influencePlot.mlm`](http://friendly.github.io/mvinfluence/reference/influencePlot.mlm.md)

## Author

Michael Friendly

## Examples

``` r
data(Rohwer, package = "heplots")
Rohwer2 <- subset(Rohwer, subset=group==2)
rownames(Rohwer2)<- 1:nrow(Rohwer2)
Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)
Rohwer.mod
#> 
#> Call:
#> lm(formula = cbind(SAT, PPVT, Raven) ~ n + s + ns + na + ss, 
#>     data = Rohwer2)
#> 
#> Coefficients:
#>              SAT       PPVT      Raven   
#> (Intercept)  -28.4675   39.6971   13.2438
#> n              3.2571    0.0673    0.0593
#> s              2.9966    0.3700    0.4924
#> ns            -5.8591   -0.3744   -0.1640
#> na             5.6662    1.5230    0.1190
#> ss            -0.6227    0.4102   -0.1212
#> 
influence(Rohwer.mod)
#> Multivariate influence statistics for model:
#>  lm(formula = cbind(SAT, PPVT, Raven) ~ n + s + ns + na + ss, 
#>     data = Rohwer2) 
#>  m=  1 case deletion diagnostics 
#> 
#>         H      Q   CookD      L      R
#> 1  0.1670 0.1529 0.11067 0.2005 0.1836
#> 2  0.2185 0.0378 0.03576 0.2795 0.0483
#> 3  0.1417 0.1207 0.07411 0.1651 0.1406
#> 4  0.0731 0.0204 0.00645 0.0789 0.0220
#> 5  0.5682 0.3439 0.84672 1.3160 0.7964
#> 6  0.1543 0.0218 0.01458 0.1825 0.0258
#> 7  0.0453 0.1288 0.02530 0.0475 0.1349
#> 8  0.1766 0.1930 0.14768 0.2145 0.2344
#> 9  0.0513 0.1817 0.04040 0.0541 0.1915
#> 10 0.4516 0.0324 0.06339 0.8235 0.0591
#> 11 0.1454 0.0725 0.04568 0.1702 0.0848
#> 12 0.1705 0.1574 0.11629 0.2056 0.1898
#> 13 0.1037 0.0949 0.04267 0.1158 0.1059
#> 14 0.1265 0.2997 0.16427 0.1448 0.3431
#> 15 0.3325 0.0105 0.01519 0.4981 0.0158
#> 16 0.3318 0.0823 0.11832 0.4966 0.1232
#> 17 0.1732 0.1925 0.14448 0.2095 0.2328
#> 18 0.2635 0.0497 0.05671 0.3578 0.0674
#> 19 0.2984 0.1340 0.17321 0.4252 0.1909
#> 20 0.0788 0.1093 0.03733 0.0855 0.1187
#> 21 0.1402 0.2495 0.15164 0.1631 0.2902
#> 22 0.1938 0.0479 0.04025 0.2404 0.0594
#> 23 0.0446 0.1572 0.03036 0.0466 0.1646
#> 24 0.2064 0.0815 0.07294 0.2601 0.1028
#> 25 0.1571 0.3820 0.26008 0.1864 0.4532
#> 26 0.1533 0.0641 0.04261 0.1811 0.0757
#> 27 0.3673 0.2128 0.33866 0.5804 0.3363
#> 28 0.1119 0.0706 0.03422 0.1260 0.0795
#> 29 0.3043 0.2295 0.30260 0.4373 0.3299
#> 30 0.0866 0.1201 0.04505 0.0948 0.1315
#> 31 0.0892 0.2524 0.09758 0.0980 0.2771
#> 32 0.0732 0.1735 0.05503 0.0790 0.1872

# extract the most influential cases
influence(Rohwer.mod) |> 
    as.data.frame() |> 
    dplyr::arrange(dplyr::desc(CookD)) |> 
    head()
#>        H     Q CookD     L     R
#> 5  0.568 0.344 0.847 1.316 0.796
#> 27 0.367 0.213 0.339 0.580 0.336
#> 29 0.304 0.229 0.303 0.437 0.330
#> 25 0.157 0.382 0.260 0.186 0.453
#> 19 0.298 0.134 0.173 0.425 0.191
#> 14 0.126 0.300 0.164 0.145 0.343

# Sake data
data(Sake, package = "heplots")
Sake.mod <- lm(cbind(taste,smell) ~ ., data=Sake)
influence(Sake.mod) |>
    as.data.frame() |> 
    dplyr::arrange(dplyr::desc(CookD)) |> head()
#>        H     Q CookD     L     R
#> 1  0.812 0.576 1.090 4.309 3.056
#> 25 0.325 0.449 0.340 0.481 0.665
#> 21 0.602 0.213 0.299 1.511 0.535
#> 5  0.195 0.407 0.186 0.243 0.506
#> 22 0.422 0.144 0.142 0.730 0.250
#> 11 0.277 0.213 0.138 0.383 0.295

```
