\name{lrPlot}
\alias{lrPlot}
\alias{lrPlot.lm}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Regression LR Influence Plot}
\description{
  This function creates a \dQuote{bubble} plot of functions, 
  R = log(Studentized residuals^2) by L = log(H/p*(1-H)) of the 
  hat values, with the areas of the
  circles representing the observations proportional to Cook's distances.

  This plot, suggested by McCulloch & Meeter (1983) has the attractive property that
  contours of equal Cook's distance are diagnonal lines with slope = -1.
  Various reference lines are drawn on the plot corresponding to 
  twice and three times the average hat value, a \dQuote{large} squared studentized
  residual and contours of Cook's distance.
}
\usage{

lrPlot(model, ...)

\method{lrPlot}{lm}(model, scale = 12, 
	xlab = "log Leverage factor [log H/p*(1-H)]", ylab = "log (Studentized Residual^2)", 
	xlim = NULL, ylim, 
	labels, 
	id.method = "noteworthy", id.n = if (id.method[1] == "identify") Inf else 0, id.cex = 1, id.col = palette()[1],
	ref = c("h", "v", "d", "c"), ref.col = "gray", ref.lty = 2, ref.lab = TRUE, 
	 ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{

  \item{model}{a linear or generalized-linear model.
  }
\item{scale}{a factor to adjust the radii of the circles, in relation to \code{sqrt(CookD)}
  }
  \item{xlab, ylab}{axis labels.}

  \item{xlim, ylim}{Limits for x and y axes. In the space of (L, R) very small residuals
  	typically extend the y axis enough to swamp the large residuals, so the default for
  	\code{ylim} is set to a range of 6 log units starting at the maximum value.
}
  \item{labels, id.method, id.n, id.cex, id.col}{settings for labelling
points; see \code{link{showLabels}} for details. To omit point labelling, set
\code{id.n=0}, the default.  The default \code{id.method="noteworthy"} is used
in this function to indicate setting labels for points with large
Studentized residuals, hat-values or Cook's distances. See Details below.  Set 
\code{id.method="identify"} for interactive point identification.
}

  \item{ref}{Options to draw reference lines, any one or more of \code{c("h", "v", "d", "c")}.
  	\code{"h"} and \code{"v"} draw horizontal and vertical reference lines at noteworthy values
  	of R and L respectively. \code{"d"} draws equally spaced diagonal reference lines for
  	contours of equal CookD.  \code{"c"} draws diagonal reference lines corresponding to
  	approximate 0.95 and 0.99 contours of CookD.
}
  \item{ref.col, ref.lty}{
Color and line type for reference lines.  Reference lines for \code{"c" \%in\% ref} are handled
separately.
}
  \item{ref.lab}{
A logical, indicating whether the reference lines should be labeled.
}
  \item{\dots}{arguments to pass to the \code{plot} and \code{points} functions.
}
}
\details{
The \code{id.method="noteworthy"} setting 
also requires setting \code{id.n>0} to have any effect.
Using \code{id.method="noteworthy"}, and \code{id.n>0}, the number of points labeled
is the union of the largest \code{id.n} values on each of L, R, and CookD.
}
\value{
  If points are identified, returns a data frame with the hat values, 
Studentized residuals and Cook's distance of the identified points.  If
no points are identified, nothing is returned.  This function is primarily
used for its side-effect of drawing a plot.
}
\references{
A. J. Lawrence (1995).
Deletion Influence and Masking in Regression
\emph{Journal of the Royal Statistical Society. Series B (Methodological)} , Vol. \bold{57}, No. 1, pp. 181-189. 


McCulloch, C. E. & Meeter, D. (1983).
Discussion of "Outliers..." by R. J. Beckman and R. D. Cook.
 \emph{Technometrics},  25, 152-155.


}
\author{
Michael Friendly
}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{influencePlot}}

\code{\link[car]{influencePlot}} in the \code{car} package for other methods
}
\examples{
# artificial example from Lawrence (1995)
x <- c( 0, 0, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 18, 18 )
y <- c( 0, 6, 6, 7, 6, 7, 6, 7, 6,  7,  6,  7,  7,  18 )
DF <- data.frame(x,y, row.names=LETTERS[1:length(x)])
DF

with(DF, {
	plot(x,y, pch=16, cex=1.3)
	abline(lm(y~x), col="red", lwd=2)
	NB <- c(1,2,13,14)
	text(x[NB],y[NB], LETTERS[NB], pos=c(4,4,2,2))
	}
)

mod <- lm(y~x, data=DF)
# standard influence plot from car
influencePlot(mod, id.n=4)

# lrPlot version
lrPlot(mod, id.n=4)


library(car)
dmod <- lm(prestige ~ income + education, data = Duncan)
influencePlot(dmod, id.n=3)
lrPlot(dmod, id.n=3)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{regression}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
