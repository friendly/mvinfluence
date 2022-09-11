#' Cook's distance for a MLM
#'
#' The functions \code{cooks.distance.mlm} and \code{hatvalues.mlm} are
#' designed as extractor functions for regression deletion diagnostics for
#' multivariate linear models following Barrett & Ling (1992). These are close
#' analogs of methods for univariate and generalized linear models handled by
#' the \code{\link[stats]{influence.measures}} in the \code{stats} package.
#' 
#' In addition, the functions provide diagnostics for deletion of subsets of
#' observations of size \code{m>1}.
#' 
#' @param model A \code{mlm} object, fit by \code{lm()}
#' @param infl  A \code{inflmlm} object. The default simply runs \code{mlm.influence()} on the model, suppressing coefficients.
#' @param ...   Ignored
#'
#' @importFrom stats cooks.distance hatvalues influence coef model.frame model.matrix
#' @return      A vector of Cook's distances
#' @export
#' @references Barrett, B. E. and Ling, R. F. (1992). General Classes of
#' Influence Measures for Multivariate Regression. \emph{Journal of the
#' American Statistical Association}, \bold{87}(417), 184-191.
#' @keywords models regression
#'
#' @examples
#' 
#' data(Rohwer, package="heplots")
#' Rohwer2 <- subset(Rohwer, subset=group==2)
#' rownames(Rohwer2)<- 1:nrow(Rohwer2)
#' Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)
#' 
#' hatvalues(Rohwer.mod)
#' cooks.distance(Rohwer.mod)
#' 
cooks.distance.mlm <-
function (model, infl = mlm.influence(model, do.coef = FALSE), ...) 
{
    cookd <- infl$CookD
    m <- infl$m
    names(cookd) <- if(m==1) infl$subsets else apply(infl$subsets,1, paste, collapse=',')
    cookd
}
