#' Cook's distance for a MLM
#'
#' @param model A \code{mlm} object, fit by \code{lm()}
#' @param infl  A \code{inflmlm} object. The default simply runs \code{mlm.influence()} on the model, suppressing coefficients.
#' @param ...   Ignored
#'
#' @return
#' @export
#'
#' @examples
cooks.distance.mlm <-
function (model, infl = mlm.influence(model, do.coef = FALSE), ...) 
{
    cookd <- infl$CookD
    m <- infl$m
    names(cookd) <- if(m==1) infl$subsets else apply(infl$subsets,1, paste, collapse=',')
    cookd
}
