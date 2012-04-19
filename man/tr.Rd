\name{tr}
\alias{tr}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Matrix trace
}
\description{
Calculates the trace of a matrix
}
\usage{
tr(M)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{M}{
a matrix
}
}
%\details{
%}
\value{
returns the sum of the diagonal elements
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
%\references{
%%% ~put references to the literature/web site here ~
%}
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
\examples{
M <- matrix(sample(1:9), 3,3)
tr(M)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{array}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
