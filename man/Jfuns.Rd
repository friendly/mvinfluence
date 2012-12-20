\name{Jfuns}
\alias{Jdet}
\alias{Jtr}
\alias{COOKD}
\alias{COVRATIO}
\alias{DFFITS}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
General Classes of Influence Measures
}
\description{
These functions implement the general classes of influence measures
for multivariate regression models defined in Barrett and Ling (1992),
Eqn 2.3, 2.4, as shown in their Table 1.

They are defined in terms of the submatrices for a deleted index subset \eqn{I}
\deqn{H_I = X_I (X^T X)^{-1} X_I}
\deqn{Q_I = E_I (E^T E)^{-1} E_I}
corresponding to the hat and residual matrices in univariate models.

For subset size \eqn{m = 1} these evaluate to scalar equivalents of
hat values and studentized residuals.

For subset size \eqn{m > 1} these are \eqn{m \times m} matrices and
functions in the \eqn{J^{det}} class use \eqn{|H_I|} and \eqn{|Q_I|},
while those in the \eqn{J^{tr}} class use \eqn{tr(H_I)} and \eqn{tr(Q_I)}.

The functions \code{COOKD}, \code{COVRATIO}, and \code{DFFITS} implement
some of the standard influence measures in these terms for the general
cases of multivariate linear models and deletion of subsets of size
\code{m>1}, but they are only included here for experimental purposes.
}
\usage{

Jdet(H, Q, a, b, f)

Jtr(H, Q, a, b, f)

COOKD(H, Q, n, p, r, m)

COVRATIO(H, Q, n, p, r, m)

DFFITS(H, Q, n, p, r, m)
}
%- maybe also 'usage' for other objects documented here.
\arguments{

  \item{H}{
a scalar or \eqn{m \times m} matrix giving the hat values for subset \eqn{I}
}
  \item{Q}{
a scalar or \eqn{m \times m} matrix giving the residual values for subset \eqn{I}
}
  \item{a}{
the \eqn{a} parameter for the \eqn{J^{det}} and \eqn{J^{tr}} classes
}
  \item{b}{
the \eqn{b} parameter for the \eqn{J^{det}} and \eqn{J^{tr}} classes
}
  \item{f}{
scaling factor for the \eqn{J^{det}} and \eqn{J^{tr}} classes
}


  \item{n}{
sample size
}
  \item{p}{
number of predictor variables
}
  \item{r}{
number of response variables
}
  \item{m}{
deletion subset size 
}


}
\details{
These functions are purely experimental and not intended to be used directly.
However, they may be useful to define other influence measures than are currently
implemented here.
}
\value{
The scalar result of the computation.
%%  ~Describe the value returned
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

%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
%\examples{
%}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{array}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
