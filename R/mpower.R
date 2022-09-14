# compute A^n where A is a square matrix, allowing non-integer and negative powers
# For integer values, see the technique in...
#https://en.wikipedia.org/wiki/Exponentiation_by_squaring



#' General Matrix Power
#' 
#' Calculates the \code{n}-th power of a square matrix, where \code{n} can be a
#' positive or negative integer or a fractional power.
#'
#' @details  
#' If \code{n<0}, the method is applied to \eqn{A^{-1}}. 
#' When \code{n} is an
#' integer, the function uses the Russian peasant method, or repeated squaring
#' for efficiency.  
#' Otherwise, it uses the spectral decomposition of \code{A},
#' \eqn{\mathbf{A}^n = \mathbf{V} \mathbf{D}^n \mathbf{V}^{T}}
#' requiring a symmetric matrix.
#' 
#' @aliases mpower %^%
#' @param A   A square matrix. Must also be symmetric for non-integer powers.
#' @param n   matrix power
#' @return    Returns the matrix \eqn{A^n} 
#' 
#' @author Michael Friendly
#' @references \url{https://en.wikipedia.org/wiki/Exponentiation_by_squaring}
#' @seealso Packages \pkg{corpcor} and \pkg{expm} define similar functions.
#' @keywords array
#' @examples
#' 
#' M <- matrix(sample(1:9), 3,3)
#' mpower(M,2)
#' mpower(M,4)
#' 
#' # make a symmetric matrix
#' MM <- crossprod(M)
#' mpower(MM, -1)
#' Mhalf <- mpower(MM, 1/2)
#' all.equal(MM, Mhalf %*% Mhalf)
#' 
#' 
#' @export
mpower <- function(A,n){

	is.wholenumber <-
    function(x, tol = .Machine$double.eps^0.5)  abs(x - round(x)) < tol
	if(!ncol(A)==nrow(A)) stop("Input must be a square matrix")
	p <- nrow(A)
	if (n==0) return (diag(p))
	if (n==1) return (A)

	if (n < 0 ) {
		A <- solve(A)
		n <- abs(n)
	}
	if (is.wholenumber(n)) {
	  result <- diag(p)
	  while (n > 0) {
	    if (n %% 2 != 0) {
	      result <- result %*% A
	      n <- n - 1
	    }
	    A <- A %*% A
	    n <- n / 2
	  }
	}
	else {
		if( any( abs(A-t(A)) > 100*.Machine$double.eps  ) ) 
      stop("Input must be a symmetric matrix for non-integer powers")
		result <- with(eigen(A), vectors %*% (values^n * t(vectors)))
	}
	dimnames(result) <- dimnames(A)
	return(result)
}

#' Shorthand operator for mpower
#'
#' @rdname mpower 
#' @export
"%^%" <- function(A,n) mpower(A,n)
