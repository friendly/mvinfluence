\name{influence.measures}
\alias{cooks.distance.mlm}
\alias{hatvalues.mlm}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Regression Deletion Diagnostics for Multivariate Linear Models
}
\description{
The functions \code{cooks.distance.mlm} and \code{hatvalues.mlm}
are designed as extractor functions for regression deletion
diagnostics for multivariate linear models following Barrett & Ling (1992).
These are close analogs of
methods for univariate and generalized linear models handled by the
\code{\link[stats]{influence.measures}} in the \code{stats} package.

In addition, the functions provide diagnostics for deletion of
subsets of observations of size \code{m>1}.
}
\usage{


\method{cooks.distance}{mlm}(model, infl = mlm.influence(model, do.coef = FALSE), ...)

\method{hatvalues}{mlm}(model, m = 1, infl, ...)


}
%- maybe also 'usage' for other objects documented here.
\arguments{

  \item{model}{
A \code{mlm} object, as returned by \code{\link[stats]{lm}} with a multivariate response
}
  \item{do.coef}{
logical. Should the coefficients be returned in the \code{inflmlm} object?
}
  \item{m}{
Size of the subsets for deletion diagnostics
}


  \item{infl}{
An influence structure, of class \code{inflmlm} as returned by \code{\link{mlm.influence}}
}
  \item{\dots}{
Other arguments, passed on
}

}
%\details{
%%%  ~~ If necessary, more details than the description above ~~
%}
\value{
When \code{m=1}, these functions return a vector, corresponding to the observations
in the data set.

When \code{m>1}, they return a list of \eqn{m \times m} matrices,
corresponding to deletion of subsets of size \code{m}.
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
Barrett, B. E. and Ling, R. F. (1992).
General Classes of Influence Measures for Multivariate Regression.
\emph{Journal of the American Statistical Association}, \bold{87}(417), 184-191.
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

hatvalues(Rohwer.mod)
cooks.distance(Rohwer.mod)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{models}
\keyword{regression}% __ONLY ONE__ keyword per line
