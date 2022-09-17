#' Influence Measures and Diagnostic Plots for Multivariate Linear Models
#' 
#' Functions in this package compute regression deletion diagnostics for multivariate linear 
#' models following methods proposed by Barrett & Ling (1992) and provide some associated diagnostic plots.  
#' 
#' The design goal for this package is that, as an extension of standard methods for univariate linear models, you should be able to fit a linear model with a multivariate response,
#' \preformatted{
#'   mymlm <- lm( cbind(y1, y2, y3) ~ x1 + x2 + x3, data=mydata)
#' }
#' and then get useful diagnostics and plots with
#' \preformatted{
#'   influence(mymlm)
#'   hatvalues(mymlm)
#'   influencePlot(mymlm, ...)  
#' }
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
#' The main function in the package is the S3 method, `influence.mlm()`, a simple wrapper for
#' `mlm.influence()`, which does the actual computations.
#' This design was dictated by that used in the `stats` package, which provides
#' the generic method `stats::influence()` and methods
#' `stats::influence.lm()` and `stats::influence.glm()`. The `car` package extends this to include
#' `car::influence.lme()` for models fit by `nlme::lme()`.
#' 
#' The following sections describe the notation and measures used in the calculations.
#' 
#' @section Notation:
#' 
#' Let \eqn{\mathbf{X}} be the model matrix in the multivariate linear model, 
#' \eqn{\mathbf{Y}_{n \times p} = \mathbf{X} \mathbf{\beta} + \mathbf{E}}.
#' The usual least squares estimate of \eqn{\mathbf{\beta}} is given by
#' \eqn{\mathbf{B} = (\mathbf{X}^{T} \mathbf{X})^{-1}  \mathbf{X}^{T} \mathbf{Y}}.
#' 
#' Then let 
#'   \itemize{
#'      \item \eqn{\mathbf{X}_I} be the submatrix of \eqn{\mathbf{X}} whose \eqn{m} rows are indexed by \eqn{I},
#'      \item \eqn{\mathbf{X}_{(I)}} is the complement, the submatrix of \eqn{\mathbf{X}} with the \eqn{m} rows in \eqn{I} deleted,
#'   }
#'  
#'  Matrices \eqn{\mathbf{Y}_I}, \eqn{\mathbf{Y}_{(I)}} are defined similarly. 
#'  
#'  In the calculation of regression coefficients,
#'  \eqn{\mathbf{B}_{(I)} = (\mathbf{X}_{(I)}^{T} \mathbf{X}_{(I)})^{-1} \mathbf{X}_{(I)}^{T} \mathbf{Y}_{I}} are the estimated 
#'  coefficients
#'  when the cases indexed by \eqn{I} have been removed. The corresponding residuals are
#'  \eqn{\mathbf{E}_{(I)} = \mathbf{Y}_{(I)} - \mathbf{X}_{(I)} \mathbf{B}_{(I)}}.
#'  
#' @section Measures:
#'  
#'  The influence measures defined by Barrett & Ling (1992) are functions of two matrices \eqn{\mathbf{H}_I} and \eqn{\mathbf{Q}_I}
#'  defined as follows
#'    \itemize{
#'       \item For the full data set, the \dQuote{hat matrix}, \eqn{\mathbf{H}}, is given by
#'             \eqn{\mathbf{H} = \mathbf{X} (\mathbf{X}^{T} \mathbf{X})^{-1} \mathbf{X}^{T} },
#'       \item \eqn{\mathbf{H}_I} is \eqn{m \times m} the submatrix of \eqn{\mathbf{H}} corresponding to the index set \eqn{I},
#'             \eqn{\mathbf{H}_I = \mathbf{X} (\mathbf{X}_I^{T} \mathbf{X}_I)^{-1} \mathbf{X}^{T} },
#'       \item \eqn{\mathbf{Q}} is the analog of \eqn{\mathbf{H}} defined for the residual matrix \eqn{\mathbf{E}}, that is,
#'             \eqn{\mathbf{Q} = \mathbf{E} (\mathbf{E}^{T} \mathbf{E})^{-1} \mathbf{E}^{T} }, with corresponding submatrix
#'             \eqn{\mathbf{Q}_I = \mathbf{E} (\mathbf{E}_I^{T} \mathbf{E}_I)^{-1} \mathbf{E}^{T} },
#'    } 
#' 
#' @docType package
#' @name mvinfluence
#' @aliases mvinfluence-package
#' @references 
#'    Barrett, B. E. and Ling, R. F. (1992).
#'      General Classes of Influence Measures for Multivariate Regression.
#'      \emph{Journal of the American Statistical Association}, \bold{87}(417), 184-191.
#'
#'    Barrett, B. E. (2003). Understanding Influence in Multivariate Regression.
#'      \emph{Communications in Statistics -- Theory and Methods}, \bold{32}, 3, 667-680.
#'
#'    A. J. Lawrence (1995).
#'      Deletion Influence and Masking in Regression.
#'      \emph{Journal of the Royal Statistical Society. Series B (Methodological)} , \bold{57}, 1, 181-189. 
#'
#' 
#' @importFrom car showLabels influencePlot infIndexPlot influenceIndexPlot
#' @importFrom heplots trans.colors Mahalanobis
#' @importFrom grDevices palette
#' @importFrom graphics abline axis box mtext par plot points text
#' @importFrom stats cooks.distance hatvalues influence coef model.frame model.matrix
#' @importFrom stats model.response qbeta qf residuals rstudent
#' @importFrom utils combn
#'
#' @method lrPlot lm
#'
#' @method hatvalues mlm
#' @method cooks.distance mlm
#' @method influence mlm
#' @method influencePlot mlm
#' @method infIndexPlot mlm
#'
#' @method print inflmlm
#' @method as.data.frame inflmlm
NULL

