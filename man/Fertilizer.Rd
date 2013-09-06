\name{Fertilizer}
\alias{Fertilizer}
\docType{data}
\title{
Fertilizer Data
}
\description{
A small data set on the use of fertilizer (x) in relation to the amount of
grain (y1) and straw (y2) produced.


}
\usage{data(Fertilizer)}
\format{
  A data frame with 8 observations on the following 3 variables.
  \describe{
    \item{\code{grain}}{amount of grain produced}
    \item{\code{straw}}{amount of straw produced}
    \item{\code{fertilizer}}{amount of fertilizer applied}
  }
}
\details{
The first observation is an obvious outlier and influential observation.
}
\source{
Anderson, T. W. (1984).
\emph{An Introduction to Multivariate Statistical Analysis},
New York: Wiley, p. 369.
}
\references{
Hossain, A. and Naik, D. N. (1989).
Detection of influential observations in multivariate regression.
\emph{Journal of Applied Statistics}, 16 (1), 25-37.
}
\examples{
data(Fertilizer)

# simple plots
plot(Fertilizer, col=c('red', rep("blue",7)), cex=c(2,rep(1.2,7)), pch=as.character(1:8))
biplot(prcomp(Fertilizer))

#fit mlm
mod <- lm(cbind(grain, straw) ~ fertilizer, data=Fertilizer)
Anova(mod)

# influence plots (m=1)
influencePlot(mod)
influencePlot(mod, type='LR')
influencePlot(mod, type='stres')

}
\keyword{datasets}
