#' Convert an inflmlm object to a data frame
#' 
#' This function is used internally in the package to convert the result of \code{mlm.influence()} to a data frame.
#' It is not normally called by the user.
#'
#' @param x    a \code
#' @param ...  ignored
#' @param FUN  in the case where the subset size, \code{m>1}, the function used on the \code{H, Q, L, R} to calculate
#'             a single statistic. The default is \code{det}. An alternative is \code{tr}, for matrix trace.
#' @param funnames 
#'
#' @return
#' @export
#'
#' @examples
#' # none
#' 
as.data.frame.inflmlm <-
function(x, ..., FUN=det, funnames=TRUE) {
	m <- x$m
	if(m==1) {
		df <- with(x, data.frame(H, Q, CookD, L, R))
		rownames(df) <- x$labels
		}
	else {
#		FUN <- match.arg(FUN)
		H <- sapply(x$H, FUN)
		Q <- sapply(x$Q, FUN)
		L <- sapply(x$L, FUN)
		R <- sapply(x$R, FUN)
		df <- data.frame(H, Q, CookD=x$CookD, L, R)
		rownames(df) <- apply(x$subsets,1, paste, collapse=',')
		if(funnames) colnames(df)[c(1,2,4,5)] <- paste(deparse(substitute(FUN)), c("H","Q","L","R"), sep="")
		}
	df
}
