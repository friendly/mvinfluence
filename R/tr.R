#' Matrix trace
#' 
#' Calculates the trace of a matrix
#' 
#' For square, symmetric matrices, such as covariance matrices, the trace is sometimes
#' used as a measure of size, e.g., in Pillai's trace criterion for a MLM.
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
#' @export
tr <- function(M) sum(diag(M))
