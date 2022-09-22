#' Extend car::confidenceEllipse to mlms

confidenceEllipse.mlm <- function(model, xlab, ylab, which.coef=1:2, ...){
  if (missing(xlab) || missing(ylab)){
    coefnames <- rownames(vcov(model))
    if (missing(xlab)) xlab <- coefnames[which.coef[1]]
    if (missing(ylab)) ylab <- coefnames[which.coef[2]]
  }
  NextMethod(xlab=xlab, ylab=ylab)
}

