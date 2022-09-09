#' Influence Measures and Diagnostic Plots for Multivariate Linear Models
#' 
#' The \code{mvinfluence} package computes regression deletion diagnostics for multivariate linear models and provides 
#' some associated diagnostic plots. 
#' 
#' Functions in this package compute regression deletion diagnostics for multivariate linear 
#' models following methods proposed by Barrett & Ling (1992) and provide some associated diagnostic plots.  
#' 
#' The diagnostic measures include hat-values (leverages), generalized Cook's distance and
#' generalized squared 'studentized' residuals.  Several types of plots to detect 
#' influential observations are provided.
#' 
#' In addition, the functions provide diagnostics for deletion of subsets of observations 
#' of size \code{m>1}. This case is theoretically interesting because sometimes pairs (\code{m=2}) 
#' of influential observations can mask each other, sometimes they can have joint influence 
#' far exceeding their individual effects, as well as other interesting phenomena described 
#' by Lawrence (1995). Associated methods for the case \code{m>1} are still under development in this package.
#' 
#' 
#' @docType package
#' @name mvinfluence
#' @importFrom car showLabels influencePlot infIndexPlot influenceIndexPlot
#' @importFrom heplots trans.colors Mahalanobis
#' @importFrom grDevices palette
#' @importFrom graphics abline axis box mtext par plot points text
#' @importFrom stats cooks.distance hatvalues influence coef model.frame model.matrix
#' @importFrom stats model.response qbeta qf residuals rstudent
#' @importFrom utils combn

#' @S3method lrPlot lm

#' @S3method hatvalues mlm
#' @S3method cooks.distance mlm
#' @S3method influence mlm
#' @S3method influencePlot mlm
#' @S3method infIndexPlot mlm

#' @S3method print inflmlm
#' @S3method as.data.frame inflmlm


