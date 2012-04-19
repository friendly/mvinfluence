\name{mlm.influence}
\alias{mlm.influence}
\alias{influence.mlm}
\alias{as.data.frame.inflmlm}
\alias{print.inflmlm}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Regression Deletion Diagnostics for Multivariate Linear Models
}
\description{
This collection of functions is designed to compute regression deletion
diagnostics for multivariate linear models following Barrett & Ling (1992)
that are close analogs of
methods for univariate and generalized linear models handled by the
\code{\link[stats]{influence.measures}} in the \pkg{stats} package.

In addition, the functions provide diagnostics for deletion of
subsets of observations of size \code{m>1}.
}
\usage{

mlm.influence(model, do.coef = TRUE, m = 1, ...)

\method{influence}{mlm}(model, do.coef = TRUE, m = 1, ...)

\method{as.data.frame}{inflmlm}(x, ..., FUN = det, funnames = TRUE)

\method{print}{inflmlm}(x, digits = max(3, getOption("digits") - 4), FUN = det, ...)

}
%- maybe also 'usage' for other objects documented here.
\arguments{

  \item{model}{
An \code{mlm} object, as returned by \code{\link[stats]{lm}}
}
  \item{do.coef}{
logical. Should the coefficients be returned in the \code{inflmlm} object?
}
  \item{m}{
Size of the subsets for deletion diagnostics
}

  \item{x}{
An \code{inflmlm} object, as returned by \code{mlm.influence}
}
  \item{FUN}{
For \code{m>1}, the function to be applied to the \eqn{H} and \eqn{Q}
matrices returning a scalar value.  \code{FUN=det} and \code{FUN=tr}
are possible choices, returning the \eqn{|H|} and \eqn{tr(H)}
respectively.
}
  \item{funnames}{
logical. Whether the \code{as.data.frame} method should prepend \code{FUN}
to the variable names
}

  \item{\dots}{
Further arguments passed to other methods
}


  \item{digits}{
Number of digits to print.
}
}
\details{
The computations and methods for the \code{m=1} case are straight-forward,
as are the computations for the \code{m>1} case.  Associated methods for
\code{m>1} are still under development.
}
\value{
\code{mlm.influence} returns an S3 object of class \code{inflmlm}, a list with the following components
%%  If it is a LIST, use
  \item{m}{Deletion subset size}
  \item{H}{Hat values, \eqn{H_I}. If \code{m=1}, a vector of diagonal entries of the \sQuote{hat} matrix.
  	Otherwise, a list of \eqn{m \times m} matrices corresponding to the \code{subsets}.}
  \item{Q}{Residuals, \eqn{Q_I}.}
  \item{CookD}{Cook's distance values}
  \item{L}{Leverage components}
  \item{R}{Residual components}
  \item{subsets}{Indices of the observations in the subsets of size \code{m}}
  \item{labels}{Observation labels}
  \item{call}{Model call for the \code{mlm} object}
  \item{Beta}{Deletion regression coefficients-- included if \code{do.coef=TRUE}}
%% ...
}

\references{
Barrett, B. E. and Ling, R. F. (1992).
General Classes of Influence Measures for Multivariate Regression.
\emph{Journal of the American Statistical Association}, \bold{87}(417), 184-191.

Barrett, B. E. (2003). Understanding Influence in Multivariate Regression.
\emph{Communications in Statistics -- Theory and Methods}, \bold{32}, 3, 667-680.
}
\author{
Michael Friendly
}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{influencePlot.mlm}}, ~~~
}
\examples{
Rohwer2 <- subset(Rohwer, subset=group==2)
rownames(Rohwer2)<- 1:nrow(Rohwer2)
Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)
Rohwer.mod
influence(Rohwer.mod)

# Sake data
Sake.mod <- lm(cbind(taste,smell) ~ ., data=Sake)
influence(Sake.mod)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{models}
\keyword{regression}% __ONLY ONE__ keyword per line
\keyword{multivariate}% __ONLY ONE__ keyword per line
