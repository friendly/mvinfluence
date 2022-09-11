#' Print an inflmlm object
#'
#' @param x       An \code{inflmlm} object
#' @param digits  Number of digits to print 
#' @param FUN     Function to combine diagnostics when \code{m>1}, one of \code{det} or \code{tr}
#' @param ...     passed to \code{print()}
#'
#' @return        Invisibly returns the object
#' @export
#'
#' @examples
#' # none
#' 
print.inflmlm <-
function(x, 
         digits = max(3, getOption("digits") - 4), 
         FUN=det, 
         ...) 
{
  if (!inherits(x, "inflmlm")) stop('Not a class("inflmlm") object')
	df <- as.data.frame(x, FUN=FUN)
	cat("Multivariate influence statistics for model:\n", 
	    paste(deparse(x$call), sep = "\n", collapse = "\n"), 
	    "\n m= ", x$m, "case deletion diagnostics",
	    ifelse(x$m>1, paste(", using", deparse(substitute(FUN)), "for matrix values\n\n"), "\n"))
	print(df, digits=digits, ...)
	invisible(x)
}
