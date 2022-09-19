#####################
# extractor functions -- trying to find a way to be consistent with the .lm versions

#	FIXME: Can't find a way to pass m= to mlm.influence, other than providing the infl= argument explicity
#        or calling the .mlm method explicitly
#> hatvalues(Rohwer.mod, m=2)
#Error in UseMethod("hatvalues") : 
#  no applicable method for 'hatvalues' applied to an object of class "c('double', 'numeric')"
# These work:
#> hatvalues.mlm(Rohwer.mod, m=2)
#> hatvalues(Rohwer.mod, infl=mlm.influence(Rohwer.mod,m=2))

#hatvalues <- function (model, ...) 
#	UseMethod("hatvalues")


#' Hatvalues for a MLM
#' 
#' The functions \code{cooks.distance.mlm} and \code{hatvalues.mlm} are
#' designed as extractor functions for regression deletion diagnostics for
#' multivariate linear models following Barrett & Ling (1992). These are close
#' analogs of methods for univariate and generalized linear models handled by
#' the \code{\link[stats]{influence.measures}} in the \code{stats} package.
#' 
#' Hat values are a component of influence diagnostics, measuring the leverage or 
#' outlyingness of observations in the space of the predictor variables.  
#' 
#' The usual
#' case considers observations one at a time (\code{m=1}), where the hatvalue is 
#' proportional to the squared Mahalanobis distance, \eqn{D^2} of each observation
#' from the centroid of all observations. This function extends that definition
#' to calculate a comparable quantity for subsets of size \code{m>1}.
#'
#' @param model  An object of class \code{mlm}, as returned by \code{\link[stats]{lm}}
#' @param m      The size of subsets to be considered
#' @param infl   An \code{inflmlm} object, as returned by \code{mlm.influence}
#' @param ...    Other arguments, for compatibility with the generic; ignored.
#'
#' @return       A vector of hatvalues
#' @seealso      \code{\link{cooks.distance.mlm}}
#' @references Barrett, B. E. and Ling, R. F. (1992). General Classes of
#' Influence Measures for Multivariate Regression. \emph{Journal of the
#' American Statistical Association}, \bold{87}(417), 184-191.
#' @keywords models regression
#
#' @export
#'
#' @examples
#' 
#' data(Rohwer, package="heplots")
#' Rohwer2 <- subset(Rohwer, subset=group==2)
#' rownames(Rohwer2)<- 1:nrow(Rohwer2)
#' Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)
#' 
#' options(digits=3)
#' hatvalues(Rohwer.mod)
#' cooks.distance(Rohwer.mod)

hatvalues.mlm <- function(model, m=1, infl, ...) 
{
	if (missing(infl)) {
		infl <- mlm.influence(model, m=m, do.coef=FALSE);
	}
	hat <- infl$H
	m <- infl$m
	names(hat) <- if(m==1) infl$subsets else apply(infl$subsets,1, paste, collapse=',')
	hat
}
