## LR influence plot: plot of log studentized residual^2 vs log(h/p*(1-h))
## such that contours of equal Cook's distance fall on diagonal lines
## with slope = -1
# Following McCulloch & Meeter, Technometrics, 1983, 25, 152-155
# modified from car::influencePlot



#' Regression LR Influence Plot
#' 
#' This function creates a \dQuote{bubble} plot of functions, R =
#' log(Studentized residuals^2) by L = log(H/p*(1-H)) of the hat values, with
#' the areas of the circles representing the observations proportional to
#' Cook's distances.
#' 
#' This plot, suggested by McCulloch & Meeter (1983) has the attractive
#' property that contours of equal Cook's distance are diagonal lines with
#' slope = -1.  Various reference lines are drawn on the plot corresponding to
#' twice and three times the average hat value, a \dQuote{large} squared
#' studentized residual and contours of Cook's distance.
#' 
#' The \code{id.method="noteworthy"} setting also requires setting
#' \code{id.n>0} to have any effect. Using \code{id.method="noteworthy"}, and
#' \code{id.n>0}, the number of points labeled is the union of the largest
#' \code{id.n} values on each of L, R, and CookD.
#' 
#' @aliases lrPlot lrPlot.lm
#' @param model a linear or generalized-linear model.
#' @param \dots arguments to pass to the \code{plot} and \code{points}
#'         functions.
#' @return If points are identified, returns a data frame with the hat values,
#'         Studentized residuals and Cook's distance of the identified points.  If no
#'         points are identified, nothing is returned.  This function is primarily used
#'         for its side-effect of drawing a plot.
#' @author Michael Friendly
#' @seealso \code{\link{influencePlot.mlm}}
#'         \code{\link[car]{influencePlot}} in the \code{car} package for other methods
#' @references A. J. Lawrence (1995). Deletion Influence and Masking in
#' Regression \emph{Journal of the Royal Statistical Society. Series B
#' (Methodological)} , Vol. \bold{57}, No. 1, pp. 181-189.
#' 
#' McCulloch, C. E. & Meeter, D. (1983). Discussion of "Outliers..." by R. J.
#' Beckman and R. D. Cook.  \emph{Technometrics}, 25, 152-155.
#' @keywords regression
#' @examples
#' 
#' # artificial example from Lawrence (1995)
#' x <- c( 0, 0, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 18, 18 )
#' y <- c( 0, 6, 6, 7, 6, 7, 6, 7, 6,  7,  6,  7,  7,  18 )
#' DF <- data.frame(x,y, row.names=LETTERS[1:length(x)])
#' DF
#' 
#' with(DF, {
#' 	plot(x,y, pch=16, cex=1.3)
#' 	abline(lm(y~x), col="red", lwd=2)
#' 	NB <- c(1,2,13,14)
#' 	text(x[NB],y[NB], LETTERS[NB], pos=c(4,4,2,2))
#' 	}
#' )
#' 
#' mod <- lm(y~x, data=DF)
#' # standard influence plot from car
#' influencePlot(mod, id.n=4)
#' 
#' # lrPlot version
#' lrPlot(mod, id.n=4)
#' 
#' 
#' library(car)
#' dmod <- lm(prestige ~ income + education, data = Duncan)
#' influencePlot(dmod, id.n=3)
#' lrPlot(dmod, id.n=3)
#' 
#' @export
lrPlot <- function(model, ...){
    UseMethod("lrPlot")
    }

#' LR plot for lm objects
#' 
#' @rdname lrPlot
#' @method lrPlot lm
#' @param model a model object fit by \code{lm}
#' @param scale a factor to adjust the radii of the circles, in relation to \code{sqrt(CookD)}
#' @param xlab,ylab axis labels.
#' @param xlim,ylim Limits for x and y axes. In the space of (L, R) very small
#'        residuals typically extend the y axis enough to swamp the large residuals,
#'        so the default for \code{ylim} is set to a range of 6 log units starting at
#'        the maximum value.
#' @param labels,id.method,id.n,id.cex,id.col settings for labeling points; see
#'         \code{link{showLabels}} for details. To omit point labeling, set
#'         \code{id.n=0}, the default.  The default \code{id.method="noteworthy"} is
#'         used in this function to indicate setting labels for points with large
#'         Studentized residuals, hat-values or Cook's distances. See Details below.
#'         Set \code{id.method="identify"} for interactive point identification.
#' @param ref Options to draw reference lines, any one or more of \code{c("h", "v", "d", "c")}.  
#'        \code{"h"} and \code{"v"} draw horizontal and vertical
#'         reference lines at noteworthy values of R and L respectively. \code{"d"}
#'         draws equally spaced diagonal reference lines for contours of equal CookD.
#'         \code{"c"} draws diagonal reference lines corresponding to approximate 0.95 and 0.99 contours of CookD.
#' @param ref.col,ref.lty Color and line type for reference lines.  Reference
#'        lines for \code{"c" \%in\% ref} are handled separately.
#' @param ref.lab A logical, indicating whether the reference lines should be labeled.
#' @importFrom graphics abline axis box mtext par plot points text
#' @export

lrPlot.lm <- function(model, 
                      scale=12,  
		xlab="log Leverage factor [log H/p*(1-H)]", 
		ylab="log (Studentized Residual^2)",
		xlim=NULL, ylim, 
    labels, 
    id.method = "noteworthy",
    id.n = if(id.method[1]=="identify") Inf else 0, 
    id.cex=1, id.col=palette()[1],
    ref=c("h", "v", "d", "c"),                     # reference lines
    ref.col="gray", ref.lty=2, ref.lab=TRUE,       # args for reference lines
     ...){ 

	hatval <- hatvalues(model)
	rstud <- rstudent(model)
	p <- length(coef(model))

	Hfun <- function(hat) log(hat/(p*(1-hat)))
	
	L <- Hfun(hatval)
	R <- log(rstud^2)
	if (missing(labels)) labels <- names(rstud)
	cook <- sqrt(CookD <- cooks.distance(model))
	scale <- scale/max(cook, na.rm=TRUE)
	n <- sum(!is.na(rstud))
#	cutoff <- sqrt(4/(n - p))

	# allow 6 log steps by default to avoid small values swamping the plot
	if (missing(ylim)) ylim <- rev(c(ymax<-ceiling(max(R)), ymax-6))

	plot(L, R, xlab=xlab, ylab=ylab, type='n', xlim=xlim, ylim=ylim,  ...)
	points(L, R, cex=pmax(.05, scale*cook), ...)

	nomit <- sum(R < ylim[1])
	if (nomit>0) cat("Note:",nomit, "points less than R=", ylim[1], "have been clipped to preserve resolution\n")

	# diagonal lines of slope -1, indicating constant leverage
	xmin <- floor(par("usr")[1])
	xmax <- floor(par("usr")[2])
	# FIXME: bit of a kludge in calculating intercepts of diagonal lines, but does no harm
	if ("d" %in% ref) for(a in (2*xmin):xmax) abline(a=a, b=-1, col=ref.col, lty=ref.lty)
	if ("c" %in% ref) {
		cref <- c(.95, .99)
		for(i in seq_along(cref)) {
			a <- -log(qf(cref[i],p,n-p))
			abline(a=a, b=-1, lwd=2, col="red")
			if(ref.lab) text(xmax, a-xmax, cref[i], adj=c(1,1), cex=0.9, col="red")
			}
		}

	# high leverage points, on this scale
	if ("v" %in% ref) {
		hL <- Hfun(c(2, 3)*p/n)
		ymin <- par("usr")[3]
		abline(v=hL, lty=ref.lty, col=ref.col)
		if(ref.lab) text(hL, ymin, c("2p/n", "3p/n"), pos=3, cex=0.9)
		}
	# high rstud^2
	if ("h" %in% ref) {
		abline(h=log(qf(.95, 1, n-p)), lty=ref.lty, col=ref.col)
		if(ref.lab) text(par("usr")[1], log(qf(.95, 1, n-p)), "0.95", adj=c(0,0), cex=0.9)
		}
	
	if(id.method != "identify"){
	   which.rstud <- order(abs(rstud), decreasing=TRUE)[1:id.n]
	   which.cook <- order(cook, decreasing=TRUE)[1:id.n]
	   which.hatval <- order(hatval, decreasing=TRUE)[1:id.n]
	   which.all <- union(which.rstud, union(which.cook, which.hatval))
	   id.method <- which.all
	   }

	noteworthy <- car::showLabels(L, R, labels=labels, method=id.method, 
    n=id.n, cex=id.cex, col=id.col)
  	if (length(noteworthy > 0))
	res <- data.frame(Rstudent=rstud, Hat=hatval, CookD=CookD, L, R)[noteworthy,]
	return(res)
  }

