\name{mlm.influence}
\alias{mlm.influence}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Calculate Regression Deletion Diagnostics for Multivariate Linear Models
}
\description{
\code{mlm.influence} is the main computational function in this package.
It is usually not called directly, but rather via its alias,
\code{\link{influence.mlm}}, the S3 method for a \code{mlm} object.

}
\usage{

mlm.influence(model, do.coef = TRUE, m = 1, ...)

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

  \item{\dots}{
Further arguments passed to other methods
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
