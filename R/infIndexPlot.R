# influence index plot  written 9 Dec 09 by S. Weisberg
# 21 Jan 10: added wrapper influenceIndexPlot(). J. Fox
# 30 March 10: bug-fixes and changed arguments, S. Weisberg
# 15 October 13:  Bug-fix on labelling x-axis
# 25 April 2016:  For compatibility with Rcmdr, change na.action=exclude to na.action=na.omit SW.
# modified for use in mvinfluence by MF

# influenceIndexPlot <- function(model, ...)
# 	{UseMethod("infIndexPlot")}
# 
# infIndexPlot <- function(model, ...)
#          {UseMethod("infIndexPlot")}

infIndexPlot.mlm <- function(model,
		 infl=mlm.influence(model, do.coef = FALSE), FUN=det,
     vars=c("Cook", "Studentized", "hat", "DSQ"), 
     main=paste("Diagnostic Plots for", deparse(substitute(model))),
     pch = 19,
     labels, id.method = "y", 
     id.n = if(id.method[1]=="identify") Inf else 0,
     id.cex=1, id.col=palette()[1], id.location="lr",
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

   op <- par(mfrow=c(length(what), 1), mar=c(1, 4, 0, 2) + .0,
             mgp=c(2, 1, 0), oma=c(6, 0, 6, 0))

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
    mtext(side=3, outer=TRUE, main, cex=1.2, line=1)
    mtext(side=1, outer=TRUE, "Index", line=3)
   invisible()
}

