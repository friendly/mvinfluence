confidenceEllipses <- function(model, ...) {
  UseMethod("confidenceEllipses")
}


confidenceEllipses.default <-
  function(model, coefnames,  main, ...) {
    if (missing(main))
      main <- paste("Pairwise Confidence Ellipses for",
                    deparse(substitute(model)))
    b <- coef(model)
    p <- length(b)
    if (missing(coefnames))
      coefnames <- paste0(names(b), "\ncoefficient")
    save <-
      par(
        mfrow = c(p, p),
        mar = c(2, 2, 0, 0),
        oma = c(0, 0, 2, 0)
      )
    on.exit(par(save))
    ylab <- coefnames[1]
    for (i in 1:p) {
      for (j in 1:p) {
        if (j == 1) {
          yaxis <- TRUE
        } else {
          yaxis <- FALSE
        }
        if (i == p) {
          xaxis <- TRUE
        } else {
          xaxis <- FALSE
        }
        if (i == j) {
          if (i == 1) {
            confidenceEllipse(
              model,
              c(2, 1),
              xaxt = "n",
              yaxt = "n",
              center.pch = "",
              col = "white",
              grid = FALSE
            )
            axis(2)
          } else if (j == p) {
            confidenceEllipse(
              model,
              c(p, 2),
              xaxt = "n",
              yaxt = "n",
              center.pch = "",
              col = "white",
              grid = FALSE
            )
            axis(1)
          }
          else {
            confidenceEllipse(
              model,
              c(1, 2),
              xaxt = "n",
              yaxt = "n",
              center.pch = "",
              col = "white",
              grid = FALSE
            )
          }
          usr <- par("usr")
          text(mean(usr[1:2]), mean(usr[3:4]), coefnames[i])
        }
        else{
          confidenceEllipse(model, c(j, i), # xlab = xlab, ylab = ylab,
                            xaxt = "n", yaxt = "n", ...)
          if (j == 1)
            axis(2)
          if (i == p)
            axis(1)
        }
      }
    }
    title(main = main,
          outer = TRUE,
          line = 1)
    invisible(NULL)
  }

confidenceEllipses.mlm <- function(model, coefnames, ...) {
  if (missing(coefnames))  {
    coefnames <- rownames(vcov(model))
    coefnames <- paste0(coefnames, "\ncoefficient")
  }
  NextMethod(coefnames = coefnames)
}
