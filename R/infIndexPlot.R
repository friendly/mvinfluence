# influence index plot  written 9 Dec 09 by S. Weisberg
# 21 Jan 10: added wrapper influenceIndexPlot(). J. Fox
# 30 March 10: bug-fixes and changed arguments, S. Weisberg
# 15 October 13:  Bug-fix on labeling x-axis
# 25 April 2016:  For compatibility with Rcmdr, change na.action=exclude to na.action=na.omit SW.
# 8 Sep 2022: try setting xpd=TRUE; allow to suppress main title
# modified for use in mvinfluence by MF

# influenceIndexPlot <- function(model, ...)
# 	{UseMethod("infIndexPlot")}
# 
# infIndexPlot <- function(model, ...)
#          {UseMethod("infIndexPlot")}



#' Influence Index Plots for Multivariate Linear Models
#' 
#' Provides index plots of some diagnostic measures for a multivariate linear
#' model: Cook's distance, a generalized (squared) studentized residual,
#' hat-values (leverages), and Mahalanobis squared distances of the residuals.
#' 
#' This function produces index plots of the various influence measures
#' calculated by \code{\link{influence.mlm}}, and in addition, the measure
#' based on the Mahalanobis squared distances of the residuals from the origin.
#' 
#' @aliases infIndexPlot.mlm influenceIndexPlot
#' @param model A multivariate linear model object of class \code{mlm} .
#' @param infl influence measure structure as returned by
#' \code{\link{mlm.influence}}
#' @param FUN For \code{m>1}, the function to be applied to the \eqn{H} and
#' \eqn{Q} matrices returning a scalar value.  \code{FUN=det} and \code{FUN=tr}
#' are possible choices, returning the \eqn{|H|} and \eqn{tr(H)} respectively.
#' @param vars All the quantities listed in this argument are plotted.  Use
#' \code{"Cook"} for generalized Cook's distances, \code{"Studentized"} for
#' generalized Studentized residuals, \code{"hat"} for hat-values (or
#' leverages), and \code{DSQ} for the squared Mahalanobis distances of the
#' model residuals.  Capitalization is optional. All may be abbreviated by the
#' first one or more letters.
#' @param main main title for graph
#' @param pch Plotting character for points
#' @param id.method,labels,id.n,id.cex,id.col,id.location Arguments for the
#' labeling of points.  The default is \code{id.n=0} for labeling no points.
#' See \code{\link[car]{showLabels}} for details of these arguments.
#' @param grid If TRUE, the default, a light-gray background grid is put on the
#' graph
#' @param \dots Arguments passed to \code{plot}
#' @return None. Used for its side effect of producing a graph.
#' @author Michael Friendly; borrows code from \code{car::infIndexPlot}
#' @seealso \code{\link{influencePlot.mlm}},
#' \code{\link[heplots]{Mahalanobis}}, \code{\link[car]{infIndexPlot}},
#' @references Barrett, B. E. and Ling, R. F. (1992). General Classes of
#' Influence Measures for Multivariate Regression. \emph{Journal of the
#' American Statistical Association}, \bold{87}(417), 184-191.
#' 
#' Barrett, B. E. (2003). Understanding Influence in Multivariate Regression
#' \emph{Communications in Statistics - Theory and Methods}, \bold{32},
#' 667-680.
#' @keywords hplot
#' @examples
#' 
#' # iris data
#' data(iris)
#' iris.mod <- lm(as.matrix(iris[,1:4]) ~ Species, data=iris)
#' infIndexPlot(iris.mod, col=iris$Species, id.n=3)
#' 
#' # Sake data
#' data(Sake, package="heplots")
#' Sake.mod <- lm(cbind(taste,smell) ~ ., data=Sake)
#' infIndexPlot(Sake.mod, id.n=3)
#' 
#' # Rohwer data
#' data(Rohwer, package="heplots")
#' Rohwer2 <- subset(Rohwer, subset=group==2)
#' rownames(Rohwer2)<- 1:nrow(Rohwer2)
#' rohwer.mlm <- lm(cbind(SAT, PPVT, Raven) ~ n + s + ns + na + ss, data=Rohwer2)
#' infIndexPlot(rohwer.mlm, id.n=3)
#' 
#' 
#' @importFrom car showLabels influencePlot infIndexPlot influenceIndexPlot
#' @importFrom heplots trans.colors Mahalanobis
#' @importFrom grDevices palette
#' @method   infIndexPlot mlm
#' @export 
infIndexPlot.mlm <- function(model,
		 infl=mlm.influence(model, do.coef = FALSE), 
		 FUN=det,
     vars=c("Cook", "Studentized", "hat", "DSQ"), 
     main=paste("Diagnostic Plots for", deparse(substitute(model))),
     pch = 19,
     labels, id.method = "y", 
     id.n = if(id.method[1]=="identify") Inf else 0,
     id.cex=1, 
		 id.col=palette()[1], 
		 id.location="lr",
     grid=TRUE, ...) {

		m <- infl$m
		df <- as.data.frame(infl, FUN=FUN, funnames=FALSE)
		CookD <- df$CookD
		H <- df$H
		Q <- df$Q
		L <- df$L
		R <- df$R
		DSQ <- Mahalanobis(residuals(model))

   what <- pmatch(tolower(vars), 
                  tolower(c("Cook", "Studentized", "hat", "DSQ")))
   if(length(what) < 1) stop("Nothing to plot")
   names <- c("Cook's distance", "Sq. Studentized residuals",
           "hat-values", "Squared distances")
# check for row.names, and use them if they are numeric.
   if(missing(labels)) labels <-  row.names(model$model)

   op <- par(mfrow=c(length(what), 1), 
             mar=c(1, 4, 0, 2) + .0,
             mgp=c(2, 1, 0), oma=c(6, 0, 6, 0),
             xpd = TRUE)

   oldwarn <- options()$warn
   options(warn=-1)
   xaxis <- as.numeric(row.names(model$model))
   options(warn=oldwarn)

   if (any (is.na(xaxis))) xaxis <- 1:length(xaxis)
   on.exit(par(op))

#   outlier.t.test <- pmin(outlierTest(model, order=FALSE, n.max=length(xaxis),
#      cutoff=length(xaxis))$bonf.p, 1)

   nplots <- length(what)
   plotnum <- 0
   for (j in what){
      plotnum <- plotnum + 1 
      y <- switch(j, CookD, R, H, DSQ)
      plot(xaxis, y, type="n", ylab=names[j], xlab="", xaxt="n", tck=0.1, ...)
	    if(grid){
        grid(lty=1, equilogs=FALSE)
        box()}
#      if(j==3) {
#            for (k in which(y < 1)) lines(c(xaxis[k], xaxis[k]), c(1, y[k]))}
#          else {
      points(xaxis, y, type="h", ...)  
      points(xaxis, y, type="p", pch=pch,  ...)  
#      if (j == 2) abline(h=0, lty=2 )
      axis(1, labels= ifelse(plotnum < nplots, FALSE, TRUE))
      showLabels(xaxis, y, labels=labels,
            id.method=id.method, id.n=id.n, id.cex=id.cex,
            id.col=id.col, id.location=id.location)
    }
    if (!is.null(main)) mtext(side=3, outer=TRUE, main, cex=1.2, line=1)
    mtext(side=1, outer=TRUE, "Index", line=3)
   invisible()
}

