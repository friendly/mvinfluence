\name{mvinfluence-package}
\alias{mvinfluence-package}
\alias{mvinfluence}
\docType{package}
\title{
Influence Measures and Diagnostic Plots for Multivariate Linear Models

}
\description{
This collection of functions is designed to compute regression deletion
diagnostics for multivariate linear models following Barrett & Ling (1992)
that are close analogs of
methods for univariate and generalized linear models handled by the
\code{\link[stats]{influence.measures}} in the \code{stats} package,
and to extend plots of influence diagnostic measures such as those
provided by \code{\link[car]{influencePlot}} in the \code{stats} package.

In addition, the functions provide diagnostics for deletion of
subsets of observations of size \code{m>1}. Associated methods for
\code{m>1} are still under development.
}
\details{
\tabular{ll}{
Package: \tab mvinfluence\cr
Type: \tab Package\cr
Version: \tab 0.5\cr
Date: \tab 2012-12-19\cr
License: \tab GPL-2\cr
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
}

\keyword{ package }
\seealso{
\code{\link{influence.measures}}, \code{link{influence.mlm}}
}
\examples{
# none here
}
