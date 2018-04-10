[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/mvinfluence)](https://cran.r-project.org/package=mvinfluence)
[![](http://cranlogs.r-pkg.org/badges/grand-total/mvinfluence)](https://cran.r-project.org/package=mvinfluence)
[![Rdoc](http://www.rdocumentation.org/badges/version/mvinfluence)](http://www.rdocumentation.org/packages/mvinfluence)



# mvinfluence
**Influence Measures and Diagnostic Plots for Multivariate Linear Models**

Functions in this package compute regression deletion diagnostics for multivariate linear models and provides some associated
diagnostic plots.  The diagnostic measures include hat-values (leverages), generalized Cook's distance, and
generalized squared 'studentized' residuals.  Several types of plots to detect influential observations are
provided.

## Installation

Get the released version from CRAN:

     install.packages("mvinfluence")

## Goals

The design goal for this package is that, as an extension of standard methods for univariate linear models, you should
be able to fit a linear model with a multivariate response,

    mymlm <- lm( cbind(y1, y2, y3) ~ x1 + x2 + x3, data=mydata)

and then get useful diagnostics and plots with:

    influence(mymlm)
    hatvalues(mymlm)
    influencePlot(mymlm, ...)  

## Examples




