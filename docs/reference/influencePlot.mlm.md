# Influence Plots for Multivariate Linear Models

This function creates various types of “bubble” plots of influence
measures with the areas of the circles representing the observations
proportional to generalized Cook's distances.

## Usage

``` r
# S3 method for class 'mlm'
influencePlot(
  model,
  scale = 12,
  type = c("stres", "LR", "cookd"),
  infl = mlm.influence(model, do.coef = FALSE),
  FUN = det,
  fill = TRUE,
  fill.col = "red",
  fill.alpha.max = 0.5,
  labels,
  id.method = "noteworthy",
  id.n = if (id.method[1] == "identify") Inf else 0,
  id.cex = 1,
  id.col = palette()[1],
  ref.col = "gray",
  ref.lty = 2,
  ref.lab = TRUE,
  ...
)
```

## Arguments

- model:

  An `mlm` object, as returned by
  [`lm`](https://rdrr.io/r/stats/lm.html) with a multivariate response.

- scale:

  a factor to adjust the radii of the circles, in relation to
  `sqrt(CookD)`

- type:

  Type of plot: one of `c("stres", "cookd", "LR")`. See Details.

- infl:

  influence measure structure as returned by
  [`mlm.influence`](http://friendly.github.io/mvinfluence/reference/mlm.influence.md)

- FUN:

  For `m>1`, the function to be applied to the \\H\\ and \\Q\\ matrices
  returning a scalar value. `FUN=det` and `FUN=tr` are possible choices,
  returning the \\\|H\|\\ and \\tr(H)\\ respectively.

- fill, fill.col, fill.alpha.max:

  `fill`: logical, specifying whether the circles should be filled. When
  `fill=TRUE`, `fill.col` gives the base fill color to which
  transparency specified by `fill.alpha.max` is applied.

- labels, id.method, id.n, id.cex, id.col:

  settings for labeling points; see
  [`showLabels`](https://rdrr.io/pkg/car/man/showLabels.html) for
  details. To omit point labeling, set `id.n=0`, the default. The
  default `id.method="noteworthy"` is used in this function to indicate
  setting labels for points with large Studentized residuals, hat-values
  or Cook's distances. See Details below. Set `id.method="identify"` for
  interactive point identification.

- ref.col, ref.lty, ref.lab:

  arguments for reference lines. Incompletely implemented in this
  version

- ...:

  other arguments passed down

## Value

If points are identified, returns a data frame with the hat values,
Studentized residuals and Cook's distance of the identified points. If
no points are identified, nothing is returned. This function is
primarily used for its side-effect of drawing a plot.

## Details

`type="stres"` plots squared (internally) Studentized residuals against
hat values; `type="cookd"` plots Cook's distance against hat values;
`type="LR"` plots residual components against leverage components, with
the attractive property that contours of constant Cook's distance fall
on diagonal lines with slope = -1. Adjacent reference lines represent
multiples of influence.

The `id.method="noteworthy"` setting also requires setting `id.n>0` to
have any effect. Using `id.method="noteworthy"`, and `id.n>0`, the
number of points labeled is the union of the largest `id.n` values on
each of L, R, and CookD.

## References

Barrett, B. E. and Ling, R. F. (1992). General Classes of Influence
Measures for Multivariate Regression. *Journal of the American
Statistical Association*, **87**(417), 184-191.

Barrett, B. E. (2003). Understanding Influence in Multivariate
Regression *Communications in Statistics - Theory and Methods*, **32**,
667-680.

McCulloch, C. E. & Meeter, D. (1983). Discussion of "Outliers..." by R.
J. Beckman and R. D. Cook. *Technometrics*, 25, 152-155

## See also

[`mlm.influence`](http://friendly.github.io/mvinfluence/reference/mlm.influence.md),
[`lrPlot`](http://friendly.github.io/mvinfluence/reference/lrPlot.md)

[`influencePlot`](https://rdrr.io/pkg/car/man/influencePlot.html) in the
car package

## Author

Michael Friendly

## Examples

``` r
data(Rohwer, package="heplots")
Rohwer2 <- subset(Rohwer, subset=group==2)
Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)

# Types of influence plots
influencePlot(Rohwer.mod, id.n=4, type="stres")

#>        H      Q  CookD     L      R
#> 42 0.568 0.3439 0.8467 1.316 0.7964
#> 47 0.452 0.0324 0.0634 0.824 0.0591
#> 51 0.126 0.2997 0.1643 0.145 0.3431
#> 52 0.332 0.0105 0.0152 0.498 0.0158
#> 62 0.157 0.3820 0.2601 0.186 0.4532
#> 64 0.367 0.2128 0.3387 0.580 0.3363
#> 66 0.304 0.2295 0.3026 0.437 0.3299

influencePlot(Rohwer.mod, id.n=4, type="LR")

#>        H      Q  CookD     L      R
#> 42 0.568 0.3439 0.8467 1.316 0.7964
#> 47 0.452 0.0324 0.0634 0.824 0.0591
#> 51 0.126 0.2997 0.1643 0.145 0.3431
#> 52 0.332 0.0105 0.0152 0.498 0.0158
#> 62 0.157 0.3820 0.2601 0.186 0.4532
#> 64 0.367 0.2128 0.3387 0.580 0.3363
#> 66 0.304 0.2295 0.3026 0.437 0.3299

influencePlot(Rohwer.mod, id.n=4, type="cookd")

#>        H      Q  CookD     L      R
#> 42 0.568 0.3439 0.8467 1.316 0.7964
#> 47 0.452 0.0324 0.0634 0.824 0.0591
#> 51 0.126 0.2997 0.1643 0.145 0.3431
#> 52 0.332 0.0105 0.0152 0.498 0.0158
#> 62 0.157 0.3820 0.2601 0.186 0.4532
#> 64 0.367 0.2128 0.3387 0.580 0.3363
#> 66 0.304 0.2295 0.3026 0.437 0.3299

# Sake data
data(Sake, package="heplots")
  Sake.mod <- lm(cbind(taste,smell) ~ ., data=Sake)
  
  influencePlot(Sake.mod, id.n=3, type="stres")

#>        H      Q  CookD     L      R
#> 1  0.812 0.5757 1.0903 4.309 3.0564
#> 21 0.602 0.2129 0.2989 1.511 0.5346
#> 25 0.325 0.4486 0.3402 0.481 0.6646
#> 28 0.741 0.0167 0.0289 2.858 0.0645
  
  influencePlot(Sake.mod, id.n=3, type="LR")

#>        H      Q  CookD     L      R
#> 1  0.812 0.5757 1.0903 4.309 3.0564
#> 21 0.602 0.2129 0.2989 1.511 0.5346
#> 25 0.325 0.4486 0.3402 0.481 0.6646
#> 28 0.741 0.0167 0.0289 2.858 0.0645
  
  influencePlot(Sake.mod, id.n=3, type="cookd")

#>        H      Q  CookD     L      R
#> 1  0.812 0.5757 1.0903 4.309 3.0564
#> 21 0.602 0.2129 0.2989 1.511 0.5346
#> 25 0.325 0.4486 0.3402 0.481 0.6646
#> 28 0.741 0.0167 0.0289 2.858 0.0645

# Adopted data  
data(Adopted, package="heplots")
Adopted.mod <- lm(cbind(Age2IQ, Age4IQ, Age8IQ, Age13IQ) ~ AMED + BMIQ, data=Adopted)

influencePlot(Adopted.mod, id.n=3)

#>         H      Q CookD      L     R
#> 12 0.1315 0.1057 0.273 0.1514 0.122
#> 37 0.0599 0.1469 0.173 0.0638 0.156
#> 44 0.1414 0.0978 0.272 0.1648 0.114
#> 45 0.1986 0.1313 0.513 0.2479 0.164
#> 51 0.0857 0.1669 0.281 0.0938 0.182

influencePlot(Adopted.mod, id.n=3, type="LR", ylim=c(-4,-1.5))

#>         H      Q CookD      L     R
#> 12 0.1315 0.1057 0.273 0.1514 0.122
#> 37 0.0599 0.1469 0.173 0.0638 0.156
#> 44 0.1414 0.0978 0.272 0.1648 0.114
#> 45 0.1986 0.1313 0.513 0.2479 0.164
#> 51 0.0857 0.1669 0.281 0.0938 0.182

# schooldata 
data(schooldata, package = "heplots")
school.mod <- lm(cbind(reading, mathematics, selfesteem) ~ ., 
                 data=schooldata)

influencePlot(school.mod, id.n=4, type="stres")

#>        H      Q  CookD     L      R
#> 33 0.328 0.2017 0.7054 0.488 0.3001
#> 35 0.101 0.2825 0.3038 0.112 0.3142
#> 44 0.503 0.2984 1.6022 1.014 0.6009
#> 59 0.568 0.4937 2.9938 1.317 1.1441
#> 66 0.355 0.0174 0.0657 0.551 0.0269

influencePlot(school.mod, id.n=4, type="LR")

#>        H      Q  CookD     L      R
#> 33 0.328 0.2017 0.7054 0.488 0.3001
#> 35 0.101 0.2825 0.3038 0.112 0.3142
#> 44 0.503 0.2984 1.6022 1.014 0.6009
#> 59 0.568 0.4937 2.9938 1.317 1.1441
#> 66 0.355 0.0174 0.0657 0.551 0.0269
```
