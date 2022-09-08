#' Matrix trace
#' 
#' Calculates the trace of a matrix
#' 
#' 
#' @param M a matrix
#' @return returns the sum of the diagonal elements of the matrix
#' @author Michael Friendly
#' @keywords array
#' @examples
#' 
#' M <- matrix(sample(1:9), 3,3)
#' tr(M)
#' 
#' @export tr
tr <- function(M) sum(diag(M))
