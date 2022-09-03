
<!-- README.md is generated from README.Rmd. Please edit that file and knit again -->

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/mvinfluence)](https://cran.r-project.org/package=mvinfluence)
[![](http://cranlogs.r-pkg.org/badges/grand-total/mvinfluence)](https://cran.r-project.org/package=mvinfluence)
[![DOI](https://zenodo.org/badge/128774860.svg)](https://zenodo.org/badge/latestdoi/128774860)

# mvinfluence <img src="man/figures/mvinfluence-logo.png" align="right" height="200px" />

**Influence Measures and Diagnostic Plots for Multivariate Linear
Models**

Functions in this package compute regression deletion diagnostics for
multivariate linear models following methods proposed by Barrett & Ling
(1992) and provide some associated diagnostic plots. The diagnostic
measures include hat-values (leverages), generalized Cook’s distance,
and generalized squared ‘studentized’ residuals. Several types of plots
to detect influential observations are provided.

In addition, the functions provide diagnostics for deletion of subsets
of observations of size `m>1`. This case is theoretically interesting
because sometimes pairs (`m=2`) of influential observations can mask
each other, sometimes they can have joint influence far exceeding their
individual effects, as well as other interesting phenomena described by
Lawrence (1995). Associated methods for the case `m>1` are still under
development in this package.

## Installation

Get the released version from CRAN:

     install.packages("mvinfluence")

## Goals

The design goal for this package is that, as an extension of standard
methods for univariate linear models, you should be able to fit a linear
model with a **multivariate** response,

    mymlm <- lm( cbind(y1, y2, y3) ~ x1 + x2 + x3, data=mydata)

and then get useful diagnostics and plots with:

    influence(mymlm)
    hatvalues(mymlm)
    cooks.distance(mymlm)
    influencePlot(mymlm, ...)  

As is done in comparable univariate functions in the `car` package,
*noteworthy* points are identified in printed output and graphs.

## Examples

Fit a MLM to a subset of the Rohwer data (the Low SES group).  
The default influence plot (`type="stres"`) shows the squared
standardized residual against the Hat value. The areas of the circles
representing the observations are proportional to generalized Cook’s
distances.

``` r
data(Rohwer, package="heplots")
Rohwer2 <- subset(Rohwer, subset=group==2)
Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)

influencePlot(Rohwer.mod, id.n=4)
```

![](man/figures/README-rohwer1-1.png)<!-- -->

    #>            H          Q      CookD         L          R
    #> 42 0.5682146 0.34387765 0.84671734 1.3159654 0.79640874
    #> 47 0.4516115 0.03239271 0.06339198 0.8235248 0.05906890
    #> 51 0.1264993 0.29967992 0.16427359 0.1448187 0.34307919
    #> 52 0.3324674 0.01054411 0.01519082 0.4980543 0.01579565
    #> 62 0.1571260 0.38198170 0.26008352 0.1864170 0.45318959
    #> 64 0.3672647 0.21279661 0.33866160 0.5804397 0.33631219
    #> 66 0.3042700 0.22949988 0.30259634 0.4373392 0.32986917

An alternative (`type="stres"`) plots residual components against
leverage components, with the property that contours of constant Cook’s
distance fall on diagonal lines with slope = -1.

``` r
influencePlot(Rohwer.mod, id.n=4, type="LR")
```

![](man/figures/README-rohwer2-1.png)<!-- -->

    #>            H          Q      CookD         L          R
    #> 42 0.5682146 0.34387765 0.84671734 1.3159654 0.79640874
    #> 47 0.4516115 0.03239271 0.06339198 0.8235248 0.05906890
    #> 51 0.1264993 0.29967992 0.16427359 0.1448187 0.34307919
    #> 52 0.3324674 0.01054411 0.01519082 0.4980543 0.01579565
    #> 62 0.1571260 0.38198170 0.26008352 0.1864170 0.45318959
    #> 64 0.3672647 0.21279661 0.33866160 0.5804397 0.33631219
    #> 66 0.3042700 0.22949988 0.30259634 0.4373392 0.32986917

## Citation

To cite `mvinfluence` in publications, use:

``` r
citation("mvinfluence")
#> 
#> To cite package 'mvinfluence' in publications use:
#> 
#>   Michael Friendly (2018). mvinfluence: Influence Measures and
#>   Diagnostic Plots for Multivariate Linear Models. R package version
#>   0.8-3. https://CRAN.R-project.org/package=mvinfluence
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {mvinfluence: Influence Measures and Diagnostic Plots for Multivariate Linear
#> Models},
#>     author = {Michael Friendly},
#>     year = {2018},
#>     note = {R package version 0.8-3},
#>     url = {https://CRAN.R-project.org/package=mvinfluence},
#>   }
#> 
#> ATTENTION: This citation information has been auto-generated from the
#> package DESCRIPTION file and may need manual editing, see
#> 'help("citation")'.
```

## References

Barrett, B. E. and Ling, R. F. (1992). General Classes of Influence
Measures for Multivariate Regression. *Journal of the American
Statistical Association*, **87**(417), 184-191.

Barrett, B. E. (2003). Understanding Influence in Multivariate
Regression. *Communications in Statistics – Theory and Methods*, **32**,
3, 667-680.

A. J. Lawrence (1995). Deletion Influence and Masking in Regression
*Journal of the Royal Statistical Society. Series B (Methodological)* ,
**57**, No. 1, pp. 181-189.
