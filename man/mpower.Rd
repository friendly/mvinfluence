\name{mpower}
\alias{mpower}
\alias{\%^\%}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
General Matrix Power
}
\description{
Calculates the \code{n}-th power of a square matrix, where \code{n}
can be a positive or negative integer or a fractional power.
}
\usage{
mpower(A, n)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{A}{
A square matrix. Must also be symmetric for non-integer powers.  
}
  \item{n}{
matrix power
}
}
\details{
If \code{n<0}, the method is applied to \eqn{A^{-1}}.
When \code{n} is an integer, the function uses the Russian peasant method,
or repeated squaring for efficiency. 
Otherwise, it uses the spectral decomposition of \code{A},
requiring a symmetric matrix.
}
\value{
Returns the matrix \eqn{A^n}
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

\seealso{
Packages corpcor and expm define similar functions.
}
\examples{
M <- matrix(sample(1:9), 3,3)
mpower(M,2)
mpower(M,4)

# make a symmetric matrix
MM <- crossprod(M)
mpower(MM, -1)
Mhalf <- mpower(MM, 1/2)
all.equal(MM, Mhalf \%*\% Mhalf)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{array}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
