# Influence Measures and Diagnostic Plots for Multivariate Linear Models

Functions in this package compute regression deletion diagnostics for
multivariate linear models following methods proposed by Barrett & Ling
(1992) and provide some associated diagnostic plots.

## Details

The design goal for this package is that, as an extension of standard
methods for univariate linear models, you should be able to fit a linear
model with a multivariate response,

      mymlm <- lm( cbind(y1, y2, y3) ~ x1 + x2 + x3, data=mydata)

and then get useful diagnostics and plots with

      influence(mymlm)
      hatvalues(mymlm)
      influencePlot(mymlm, ...)

The diagnostic measures include hat-values (leverages), generalized
Cook's distance and generalized squared 'studentized' residuals. Several
types of plots to detect influential observations are provided.

In addition, the functions provide diagnostics for deletion of subsets
of observations of size `m>1`. This case is theoretically interesting
because sometimes pairs (`m=2`) of influential observations can mask
each other, sometimes they can have joint influence far exceeding their
individual effects, as well as other interesting phenomena described by
Lawrence (1995). Associated methods for the case `m>1` are still under
development in this package.

The main function in the package is the S3 method,
[`influence.mlm`](http://friendly.github.io/mvinfluence/reference/influence.mlm.md),
a simple wrapper for
[`mlm.influence`](http://friendly.github.io/mvinfluence/reference/mlm.influence.md),
which does the actual computations. This design was dictated by that
used in the stats package, which provides the generic method
[`influence`](https://rdrr.io/r/stats/lm.influence.html) and methods
[`influence.lm`](https://rdrr.io/r/stats/lm.influence.html) and
[`influence.glm`](https://rdrr.io/r/stats/lm.influence.html). The car
package extends this to include
[`influence.lme`](https://rdrr.io/pkg/car/man/influence-mixed-models.html)
for models fit by [`lme`](https://rdrr.io/pkg/nlme/man/lme.html).

The following sections describe the notation and measures used in the
calculations.

## Notation

Let \\\mathbf{X}\\ be the model matrix in the multivariate linear model,
\\\mathbf{Y}\_{n \times p} = \mathbf{X}\_{n \times r}
\boldsymbol{\beta}\_{r \times p} + \mathbf{E}\_{n \times p}\\. The usual
least squares estimate of \\\boldsymbol{\beta}\\ is given by
\\\mathbf{B} = (\mathbf{X}^{T} \mathbf{X})^{-1} \mathbf{X}^{T}
\mathbf{Y}\\.

Then let

- \\\mathbf{X}\_I\\ be the submatrix of \\\mathbf{X}\\ whose \\m\\ rows
  are indexed by \\I\\,

- \\\mathbf{X}\_{(-I)}\\ is the complement, the submatrix of
  \\\mathbf{X}\\ with the \\m\\ rows in \\I\\ deleted,

Matrices \\\mathbf{Y}\_I\\, \\\mathbf{Y}\_{(-I)}\\ are defined
similarly.

In the calculation of regression coefficients, \\\mathbf{B}\_{(-I)} =
(\mathbf{X}\_{(-I)}^{T} \mathbf{X}\_{(-I)})^{-1} \mathbf{X}\_{(-I)}^{T}
\mathbf{Y}\_{I}\\ are the estimated coefficients when the cases indexed
by \\I\\ have been removed. The corresponding residuals are
\\\mathbf{E}\_{(-I)} = \mathbf{Y}\_{(-I)} - \mathbf{X}\_{(-I)}
\mathbf{B}\_{(-I)}\\.

## Hat values and Residuals

The influence measures defined by Barrett & Ling (1992) are functions of
two matrices \\\mathbf{H}\_I\\ and \\\mathbf{Q}\_I\\ defined as follows:

- For the full data set, the “hat matrix”, \\\mathbf{H}\\, is given by
  \\\mathbf{H} = \mathbf{X} (\mathbf{X}^{T} \mathbf{X})^{-1}
  \mathbf{X}^{T} \\,

- \\\mathbf{H}\_I\\ is \\m \times m\\ the submatrix of \\\mathbf{H}\\
  corresponding to the index set \\I\\, \\\mathbf{H}\_I = \mathbf{X}
  (\mathbf{X}\_I^{T} \mathbf{X}\_I)^{-1} \mathbf{X}^{T} \\,

- \\\mathbf{Q}\\ is the analog of \\\mathbf{H}\\ defined for the
  residual matrix \\\mathbf{E}\\, that is, \\\mathbf{Q} = \mathbf{E}
  (\mathbf{E}^{T} \mathbf{E})^{-1} \mathbf{E}^{T} \\, with corresponding
  submatrix \\\mathbf{Q}\_I = \mathbf{E} (\mathbf{E}\_I^{T}
  \mathbf{E}\_I)^{-1} \mathbf{E}^{T} \\,

## Cook's distance

In these terms, Cook's distance is defined for a univariate response by
\$\$D_I = (\mathbf{b} - \mathbf{b}\_{(-I)})^T (\mathbf{X}^T \mathbf{X})
(\mathbf{b} - \mathbf{b}\_{(-I)}) / p s^2 \\ ,\$\$ a measure of the
squared distance between the coefficients \\\mathbf{b}\\ for the full
data set and those \\\mathbf{b}\_{(-I)}\\ obtained when the cases in
\\I\\ are deleted.

In the multivariate case, Cook's distance is obtained by replacing the
vector of coefficients \\\mathbf{b}\\ by \\\mathrm{vec} (\mathbf{B})\\,
the result of stringing out the coefficients for all responses in a
single \\n \times p\\-length vector. \$\$D_I = \frac{1}{p}
\[\mathrm{vec} (\mathbf{B} - \mathbf{B}\_{(-I)})\]^T (S^{-1} \otimes
\mathbf{X}^T \mathbf{X}) \mathrm{vec} (\mathbf{B} - \mathbf{B}\_{(-I)})
\\ ,\$\$ where \\\otimes\\ is the Kronecker (direct) product and
\\\mathbf{S} = \mathbf{E}^T \mathbf{E} / (n-p)\\ is the covariance
matrix of the residuals.

## Leverage and residual components

For a univariate response, and when `m = 1`, Cook's distance can be
re-written as a product of leverage and residual components as \$\$D_i =
\left(\frac{n-p}{p} \right) \frac{h\_{ii} q\_{ii}}{(1 - h\_{ii})^2 }
\\.\$\$

Then we can define a leverage component \\L_i\\ and residual component
\\R_i\\ as

\$\$L_i = \frac{h\_{ii}}{1 - h\_{ii}} \quad\quad R_i =
\frac{q\_{ii}}{1 - h\_{ii}} \\.\$\$ \\R_i\\ is the studentized residual,
and \\D_i \propto L_i \times R_i\\.

In the general, multivariate case there are analogous matrix expressions
for \\\mathbf{L}\\ and \\\mathbf{R}\\. When `m > 1`, the quantities
\\\mathbf{H}\_I\\, \\\mathbf{Q}\_I\\, \\\mathbf{L}\_I\\, and
\\\mathbf{R}\_I\\ are \\m \times m\\ matrices. Where scalar quantities
are needed, the package functions apply a function, `FUN`, either
[`det()`](https://rdrr.io/r/base/det.html) or
[`tr()`](http://friendly.github.io/mvinfluence/reference/tr.md) to
calculate a measure of “size”, as in

      H <- sapply(x$H, FUN)
      Q <- sapply(x$Q, FUN)
      L <- sapply(x$L, FUN)
      R <- sapply(x$R, FUN)

## Other measures

The [`stats-package`](https://rdrr.io/r/stats/stats-package.html)
provides a collection of other leave-one-out deletion diagnostics that
work with multivariate response models.

- [`rstandard`](https://rdrr.io/r/stats/influence.measures.html):

  Standardized residuals, re-scaling the residuals to have unit variance

- [`rstudent`](https://rdrr.io/r/stats/influence.measures.html):

  Studentized residuals, re-scaling the residuals to have leave-one-out
  variance

- [`dffits`](https://rdrr.io/r/stats/influence.measures.html):

  a scaled measure of the change in the predicted value for the *i*th
  observation

- [`covratio`](https://rdrr.io/r/stats/influence.measures.html):

  the change in the determinant of the covariance matrix of the
  estimates by deleting the *i*th observation

## References

Barrett, B. E. and Ling, R. F. (1992). General Classes of Influence
Measures for Multivariate Regression. *Journal of the American
Statistical Association*, **87**(417), 184-191.

Barrett, B. E. (2003). Understanding Influence in Multivariate
Regression. *Communications in Statistics – Theory and Methods*, **32**,
3, 667-680.

A. J. Lawrence (1995). Deletion Influence and Masking in Regression.
*Journal of the Royal Statistical Society. Series B (Methodological)* ,
**57**, 1, 181-189.

## See also

Useful links:

- <https://github.com/friendly/mvinfluence>

- <https://friendly.github.io/mvinfluence/>

- Report bugs at <https://github.com/friendly/mvinfluence/issues>

## Author

**Maintainer**: Michael Friendly <friendly@yorku.ca>
([ORCID](https://orcid.org/0000-0002-3237-0941))

Authors:

- Michael Friendly <friendly@yorku.ca>
  ([ORCID](https://orcid.org/0000-0002-3237-0941))

## Examples

``` r
data(Rohwer, package="heplots")
Rohwer2 <- subset(Rohwer, subset=group==2)
rownames(Rohwer2) <- 1:nrow(Rohwer2)
Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)

influencePlot(Rohwer.mod, id.n = 3)

#>        H      Q  CookD     L      R
#> 5  0.568 0.3439 0.8467 1.316 0.7964
#> 10 0.452 0.0324 0.0634 0.824 0.0591
#> 14 0.126 0.2997 0.1643 0.145 0.3431
#> 25 0.157 0.3820 0.2601 0.186 0.4532
#> 27 0.367 0.2128 0.3387 0.580 0.3363
#> 29 0.304 0.2295 0.3026 0.437 0.3299
# LR plot
influencePlot(Rohwer.mod, id.n = 3, type = "LR")

#>        H      Q  CookD     L      R
#> 5  0.568 0.3439 0.8467 1.316 0.7964
#> 10 0.452 0.0324 0.0634 0.824 0.0591
#> 14 0.126 0.2997 0.1643 0.145 0.3431
#> 25 0.157 0.3820 0.2601 0.186 0.4532
#> 27 0.367 0.2128 0.3387 0.580 0.3363
#> 29 0.304 0.2295 0.3026 0.437 0.3299
# 'cookd' plot
influencePlot(Rohwer.mod, id.n = 3, type = "cookd")

#>        H      Q  CookD     L      R
#> 5  0.568 0.3439 0.8467 1.316 0.7964
#> 10 0.452 0.0324 0.0634 0.824 0.0591
#> 14 0.126 0.2997 0.1643 0.145 0.3431
#> 25 0.157 0.3820 0.2601 0.186 0.4532
#> 27 0.367 0.2128 0.3387 0.580 0.3363
#> 29 0.304 0.2295 0.3026 0.437 0.3299
```
