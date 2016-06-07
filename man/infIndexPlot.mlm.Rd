\name{infIndexPlot.mlm}
\alias{infIndexPlot.mlm}
\alias{influenceIndexPlot}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{Influence Index Plots for Multivariate Linear Models}

\description{
Provides index plots of some diagnostic measures for a multivariate linear
model: Cook's distance, a generalized (squared) studentized residual,
hat-values (leverages), and Mahalanobis squared distances of the residuals.

}
\usage{
\method{infIndexPlot}{mlm}(model, 
	infl = mlm.influence(model, do.coef = FALSE), FUN = det, 
	vars = c("Cook", "Studentized", "hat", "DSQ"), 
	main = paste("Diagnostic Plots for", deparse(substitute(model))), 
	pch = 19, 
	labels, 
	id.method = "y", id.n = if (id.method[1] == "identify") Inf else 0, 
	id.cex = 1, id.col = palette()[1], id.location = "lr", 
	grid = TRUE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{model}{A multivariate linear model object of class \code{mlm} .}
  \item{infl}{
influence measure structure as returned by \code{\link{mlm.influence}}
}
  \item{FUN}{
For \code{m>1}, the function to be applied to the \eqn{H} and \eqn{Q}
matrices returning a scalar value.  \code{FUN=det} and \code{FUN=tr}
are possible choices, returning the \eqn{|H|} and \eqn{tr(H)}
respectively.
}
  \item{vars}{
All the quantities listed in this argument are plotted.  Use \code{"Cook"}
for generalized Cook's distances, \code{"Studentized"} for 
generalized Studentized residuals, \code{"hat"} for hat-values (or leverages), and
\code{DSQ} for the squared Mahalanobis distances of the model residuals.  
Capitalization is optional.
All may be abbreviated by the first one or more letters.
}
  \item{main}{main title for graph}
  \item{pch}{
Plotting character for points
}
  \item{id.method,labels,id.n,id.cex,id.col,id.location}{Arguments for the labelling of
    points.  The default is \code{id.n=0} for labeling no points.  See
    \code{\link[car]{showLabels}} for details of these arguments.
}
\item{grid}{If TRUE, the default, a light-gray background grid is put on the
graph}
  \item{\dots}{Arguments passed to \code{plot}}
}

\details{
This function produces index plots of the various influence measures
calculated by \code{\link{influence.mlm}}, and in addition,
the measure based on the Mahalanobis squared distances of the
residuals from the origin.
}
\value{
None. Used for its side effect of producing a graph.  
}
\references{
Barrett, B. E. and Ling, R. F. (1992).
General Classes of Influence Measures for Multivariate Regression.
\emph{Journal of the American Statistical Association}, \bold{87}(417), 184-191.

Barrett, B. E. (2003).
Understanding Influence in Multivariate Regression 
\emph{Communications in Statistics - Theory and Methods}, \bold{32}, 667-680.

}
\author{
Michael Friendly; borrows code from \code{car::infIndexPlot}
}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{influencePlot}}, 
\code{\link[heplots]{Mahalanobis}},
\code{\link[car]{infIndexPlot}},

}
\examples{
# iris data
data(iris)
iris.mod <- lm(as.matrix(iris[,1:4]) ~ Species, data=iris)
infIndexPlot(iris.mod, col=iris$Species, id.n=3)

# Sake data
data(Sake, package="heplots")
Sake.mod <- lm(cbind(taste,smell) ~ ., data=Sake)
infIndexPlot(Sake.mod, id.n=3)

# Rohwer data
data(Rohwer, package="heplots")
Rohwer2 <- subset(Rohwer, subset=group==2)
rownames(Rohwer2)<- 1:nrow(Rohwer2)
rohwer.mlm <- lm(cbind(SAT, PPVT, Raven) ~ n + s + ns + na + ss, data=Rohwer2)
infIndexPlot(rohwer.mlm, id.n=3)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ hplot}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
