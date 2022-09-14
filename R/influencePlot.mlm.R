#' Influence Plots for Multivariate Linear Models
#' 
#' This function creates various types of \dQuote{bubble} plots of influence
#' measures with the areas of the circles representing the observations
#' proportional to generalized Cook's distances.
#' 
#' \code{type="stres"} plots squared (internally) Studentized residuals against
#' hat values; 
#' \code{type="cookd"} plots Cook's distance against hat values;
#' \code{type="LR"} plots residual components against leverage components, with
#' the attractive property that contours of constant Cook's distance fall on diagonal
#' lines with slope = -1. Adjacent reference lines represent multiples of influence.
#' 
#' The \code{id.method="noteworthy"} setting also requires setting
#' \code{id.n>0} to have any effect. Using \code{id.method="noteworthy"}, and
#' \code{id.n>0}, the number of points labeled is the union of the largest
#' \code{id.n} values on each of L, R, and CookD.
#' 
#' @param model An \code{mlm} object, as returned by \code{\link[stats]{lm}}
#'              with a multivariate response.
#' @param scale a factor to adjust the radii of the circles, in relation to
#'              \code{sqrt(CookD)}
#' @param type  Type of plot: one of \code{c("stres", "cookd", "LR")}. See Details.
#' @param infl  influence measure structure as returned by
#'              \code{\link{mlm.influence}}
#' @param FUN   For \code{m>1}, the function to be applied to the \eqn{H} and
#'              \eqn{Q} matrices returning a scalar value.  \code{FUN=det} and \code{FUN=tr}
#'              are possible choices, returning the \eqn{|H|} and \eqn{tr(H)} respectively.
#' @param labels,id.method,id.n,id.cex,id.col settings for labeling points;
#'               see \code{\link{showLabels}} for details. To omit point labeling, set
#'               \code{id.n=0}, the default.  The default \code{id.method="noteworthy"} is
#'               used in this function to indicate setting labels for points with large
#'               Studentized residuals, hat-values or Cook's distances. See Details below.
#'               Set \code{id.method="identify"} for interactive point identification.
#' @param fill,fill.col,fill.alpha.max \code{fill}: logical, specifying whether
#'               the circles should be filled. When \code{fill=TRUE}, \code{fill.col} gives
#'               the base fill color to which transparency specified by \code{fill.alpha.max}
#'               is applied.
#' @param ref.col,ref.lty,ref.lab arguments for reference lines.  Incompletely
#'               implemented in this version
#' @param \dots other arguments passed down
#' 
#' @return If points are identified, returns a data frame with the hat values,
#'               Studentized residuals and Cook's distance of the identified points.  If no
#'               points are identified, nothing is returned.  This function is primarily used
#'               for its side-effect of drawing a plot.
#' @author Michael Friendly
#' @seealso \code{\link{mlm.influence}}, \code{\link{lrPlot}}
#' 
#' \code{\link[car]{influencePlot}} in the car package
#'
#' @method influencePlot mlm
#' @importFrom car influencePlot
#' @importFrom grDevices palette
#' @importFrom stats model.response qbeta qf residuals rstudent
#' 
#' @references 
#' Barrett, B. E. and Ling, R. F. (1992). General Classes of
#' Influence Measures for Multivariate Regression. \emph{Journal of the
#' American Statistical Association}, \bold{87}(417), 184-191.
#' 
#' Barrett, B. E. (2003). Understanding Influence in Multivariate Regression
#' \emph{Communications in Statistics - Theory and Methods}, \bold{32},
#' 667-680.
#' 
#' McCulloch, C. E. & Meeter, D. (1983). Discussion of "Outliers..." by R. J.
#' Beckman and R. D. Cook.  \emph{Technometrics}, 25, 152-155
#' @keywords models regression multivariate
#' @examples
#' 
#' data(Rohwer, package="heplots")
#' Rohwer2 <- subset(Rohwer, subset=group==2)
#' Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)
#' 
#' influencePlot(Rohwer.mod, id.n=4, type="stres")
#' influencePlot(Rohwer.mod, id.n=4, type="LR")
#' influencePlot(Rohwer.mod, id.n=4, type="cookd")
#' 
#' # Sake data
#' data(Sake, package="heplots")
#' 	Sake.mod <- lm(cbind(taste,smell) ~ ., data=Sake)
#' 	influencePlot(Sake.mod, id.n=3, type="stres")
#' 	influencePlot(Sake.mod, id.n=3, type="LR")
#' 	influencePlot(Sake.mod, id.n=3, type="cookd")
#' 
#' # Adopted data	
#' data(Adopted, package="heplots")
#' Adopted.mod <- lm(cbind(Age2IQ, Age4IQ, Age8IQ, Age13IQ) ~ AMED + BMIQ, data=Adopted)
#' influencePlot(Adopted.mod, id.n=3)
#' influencePlot(Adopted.mod, id.n=3, type="LR", ylim=c(-4,-1.5))
#' 
#' 
#' @export
#' 
influencePlot.mlm <-
function(model, scale=12, type=c("stres", "LR", "cookd"),
		infl=mlm.influence(model, do.coef = FALSE), FUN=det,
    fill=TRUE, fill.col="red",
    fill.alpha.max=0.5,
    labels, 
    id.method = "noteworthy",
    id.n = if(id.method[1]=="identify") Inf else 0, 
    id.cex=1, id.col=palette()[1],
    ref.col="gray", ref.lty=2, ref.lab=TRUE,       # args for reference lines
    ...)
{
	
	m <- infl$m
	df <- as.data.frame(infl, FUN=FUN, funnames=FALSE)
	CookD <- df$CookD
	H <- df$H
	Q <- df$Q
	L <- df$L
	R <- df$R
	if(missing(labels)) labels <- rownames(df)
	
	p <- nrow(coef(model))
	q <- ncol(coef(model))
	n <- length(infl$H)
	scale=scale/max(sqrt(CookD))
	# TODO: replace with grDevices::adjustcolor to avoid CRAN warning
	if (fill) cols <- heplots::trans.colors(fill.col, alpha=fill.alpha.max * CookD/(max(CookD)))

	if(id.method != "identify"){
	  which.rstud <- order(R, decreasing=TRUE)[1:id.n]
		which.cook <- order(CookD, decreasing=TRUE)[1:id.n]
		which.hat <- order(H, decreasing=TRUE)[1:id.n]
		id.method <- inf <- Reduce(union, list(which.rstud,which.cook, which.hat))
	}
	
	type <- match.arg(type)
	if (type=='cookd') {
		plot(H, CookD, xlab="Hat value", ylab="Cook's D", cex=scale*CookD, ...)
		if (fill) points(H, CookD, cex=scale*CookD, pch=16, col=cols)
#		abline(h=qf(.95, 1, n-p), lty=ref.lty, col=ref.col)
		abline(h=4/(n-p), lty=ref.lty, col=ref.col)
		abline(v=c(2, 3)*p/n, lty=ref.lty, col=ref.col)
		noteworthy <- car::showLabels(H, CookD, labels=labels, method=id.method, 
    	n=id.n, cex=id.cex, col=id.col)
	}
	else if (type=='stres') {
		plot(H, Q, xlab="Hat value", ylab="Squared Studentized Residual", cex=scale*CookD, ...)
		if (fill) points(H, Q, cex=scale*CookD, pch=16, col=cols)
		abline(v=c(2, 3)*p/n, lty=ref.lty, col=ref.col)
		abline(h=qbeta(.95, q/2, (n-p-q)/2), lty=ref.lty, col=ref.col)
		noteworthy <- car::showLabels(H, Q, labels=labels, method=id.method, 
    	n=id.n, cex=id.cex, col=id.col)
	}
	else if (type=='LR') {
		logL <- log(L)
		logR <- log(R)
		plot(logL, logR, xlab="log Leverage", ylab="log Residual", cex=scale*CookD, ...)
		if (fill) points(logL, logR, cex=scale*CookD, pch=16, col=cols)
		xmin <- floor(par("usr")[1])
		xmax <- ceiling(par("usr")[2])
		# FIXME: bit of a kludge in calculating intercepts of diagonal lines
		for(a in (2*xmin):xmax) abline(a=a, b=-1, col=ref.col, lty=ref.lty)	
		noteworthy <- car::showLabels(logL, logR, labels=labels, method=id.method, 
    	n=id.n, cex=id.cex, col=id.col)
		}
#browser()

	  if (length(noteworthy > 0)) {
	  	## FIXME:  m>1 car::showLabels returns the labels, not the indices
	  	if (m>1) noteworthy <- inf
	  	res <- data.frame(H, Q, CookD, L, R)[noteworthy,]
	  	rownames(res) <- labels[noteworthy]
			return(res)
		}

}
