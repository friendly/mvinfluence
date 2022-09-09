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
#' Hat values are a component of influence diagnostics, measuring the leverage or 
#' outlyingness of observations in the space of the predictor variables.  
#' 
#' The usual
#' case considers observations one at a time (\code{m=1}), where the hatvalue is 
#' proportional to the squared Mahalanobis distance, \eqn{D^2} of each observation
#' from the centroid of all observations. This function extends that definition
#' to calculates a comparable quantity for subsets of size \code{m>1}.
#'
#' @param model  An object of class \code{mlm}, as returned by \code{\link[stats]{lm}}
#' @param m      The size of subsets to be considered
#' @param infl   An \code{inflmlm} object, as returned by \code{mlm.influence}
#' @param ...    Other arguments, for compatibility with the generic; ignored.
#'
#' @return
#' @export
#'
#' @examples
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
