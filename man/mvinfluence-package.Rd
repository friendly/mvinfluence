\name{mvinfluence-package}
\alias{mvinfluence-package}
\alias{mvinfluence}
\docType{package}
\title{
Influence Measures and Diagnostic Plots for Multivariate Linear Models

}
\description{
This collection of functions is designed to compute regression deletion
diagnostics for multivariate linear models following Barrett & Ling (1992).
These are close analogs of standard
methods for univariate and generalized linear models handled by the
\code{\link[stats]{influence.measures}} in the \code{stats} package.
These functions also extend plots of influence diagnostic measures such as those
provided by \code{\link[car]{influencePlot}} in the \code{stats} package.

In addition, the functions provide diagnostics for deletion of
subsets of observations of size \code{m>1}. This case is theoretically interesting
because sometimes pairs (\code{m=2}) of influential observations can mask each other,
sometimes they can have joint influence far exceeding their individual effects,
as well as other interesting phenomena described by Lawrence (1995).
Associated methods for the case
\code{m>1} are still under development in this package.
}
\details{
\tabular{ll}{
Package: \tab mvinfluence\cr
Type: \tab Package\cr
Version: \tab 0.7\cr
Date: \tab 2013--9-06\cr
License: \tab GPL-2\cr
}
The design goal for this package is that, as an extension of standard methods for univariate linear models, you should
be able to fit a linear model with a multivariate response,
\preformatted{
  mymlm <- lm( cbind(y1, y2, y3) ~ x1 + x2 +x3, data=mydata)
}
and then get useful diagnostics and plots with
\preformatted{
  influence(mymlm)
  hatvalues(mymlm)
  influencePlot(mymlm, ...)  
}


%~~ An overview of how to use the package, including the most important ~~
%~~ functions ~~
}
\author{
Michael Friendly

Maintainer: Michael Friendly <friendly@yorku.ca>
}
\references{
Barrett, B. E. and Ling, R. F. (1992).
General Classes of Influence Measures for Multivariate Regression.
\emph{Journal of the American Statistical Association}, \bold{87}(417), 184-191.

Barrett, B. E. (2003). Understanding Influence in Multivariate Regression.
\emph{Communications in Statistics -- Theory and Methods}, \bold{32}, 3, 667-680.

A. J. Lawrence (1995).
Deletion Influence and Masking in Regression
\emph{Journal of the Royal Statistical Society. Series B (Methodological)} , Vol. \bold{57}, No. 1, pp. 181-189. 
}

\keyword{ package }
\seealso{
\code{\link{influence.measures}}, \code{\link{influence.mlm}}, \code{\link{influencePlot.mlm}}, ...

\code{\link{Jdet}},  \code{\link{Jtr}}
provide some theoretical description and definitions of influence measures in the
Barrett & Ling framework.
}
\examples{
# none here
}
