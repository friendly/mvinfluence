##########################################################
# general functions of H_I and Q_I  B&L Eqn 2.3, 2.4
# as in Table 1
# These are simply experimental, probably not to be exported
##########################################################

#' General Classes of Influence Measures
#' 
#' These functions implement the general classes of influence measures for
#' multivariate regression models defined in Barrett and Ling (1992), Eqn 2.3,
#' 2.4, as shown in their Table 1.
#' 
#' There are two classes of functions, denoted \eqn{J_I^{det}} and \eqn{J_I^{tr}},
#' with parameters \eqn{n, p, q} of the data, \eqn{m} of the subset size
#' and \eqn{a} and \eqn{b} which define powers of terms in the formulas, typically
#' in the set \code{-2, -1, 0}.
#' 
#' They are defined in terms of the submatrices for a deleted index subset
#' \eqn{I},
#' \deqn{H_I = X_I (X^T X)^{-1} X_I} 
#' \deqn{Q_I = E_I (E^T E)^{-1} E_I}
#' corresponding to the hat and residual matrices in univariate models.
#' 
#' For subset size \eqn{m = 1} these evaluate to scalar equivalents of hat
#' values and studentized residuals.
#' 
#' For subset size \eqn{m > 1} these are \eqn{m \times m} matrices and
#' functions in the \eqn{J^{det}} class use \eqn{|H_I|} and \eqn{|Q_I|}, while
#' those in the \eqn{J^{tr}} class use \eqn{tr(H_I)} and \eqn{tr(Q_I)}.
#' 
#' The functions \code{COOKD}, \code{COVRATIO}, and \code{DFFITS} implement
#' some of the standard influence measures in these terms for the general cases
#' of multivariate linear models and deletion of subsets of size \code{m>1},
#' but they have not yet been incorporated into our main functions
#' \code{\link{mlm.influence}} and \code{\link{influence.mlm}}.
#' 
#' @name Jfuns
#' @aliases Jdet Jtr COOKD COVRATIO DFFITS
#' @param H a scalar or \eqn{m \times m} matrix giving the hat values for subset \eqn{I}
#' @param Q a scalar or \eqn{m \times m} matrix giving the residual values for subset \eqn{I}
#' @param a the \eqn{a} parameter for the \eqn{J^{det}} and \eqn{J^{tr}} classes
#' @param b the \eqn{b} parameter for the \eqn{J^{det}} and \eqn{J^{tr}} classes
#' @param f scaling factor for the \eqn{J^{det}} and \eqn{J^{tr}} classes
#' @return The scalar result of the computation. 
#' @author Michael Friendly
#' @references Barrett, B. E. and Ling, R. F. (1992). General Classes of
#' Influence Measures for Multivariate Regression. \emph{Journal of the
#' American Statistical Association}, \bold{87}(417), 184-191.
#' @keywords array

#' J trace function
#' @rdname Jfuns
Jtr <- function (H, Q, a, b, f) {
		I <- diag(nrow(H))
		res <- H %*% Q %*% mpower(I-H-Q, a) %*% mpower(I-H, b)
		f * tr(res)
	}

#' J det function
#' 
#' @rdname Jfuns
Jdet <- function (H, Q, a, b, f) {
		I <- diag(nrow(H))
		res <- H %*% Q %*% mpower(I-H-Q, a) %*% mpower(I-H, b)
		f * det(res)
	}

#' Cook D, in terms of Jtr()
#'
#' @param n sample size
#' @param p number of predictor variables
#' @param r number of response variables
#' @param m deletion subset size
#' @rdname Jfuns

COOKD <- function(H, Q, n, p, r, m) {
 		f <- (n-p)/p
 		Jtr(H, Q, 0, -2, f)
 }

#' DFFITS^2, in terms of Jtr()
#' 
#' @rdname Jfuns
DFFITS <- function(H, Q, n, p, r, m) {
 		f <- (n-p-m)/p
 		Jtr(H, Q, -1, 0, f)
 }
 
#' COVRATIO, in terms of Jdet()
#' @rdname Jfuns

COVRATIO <- function(H, Q, n, p, r, m) {
 		f <- ((n-p)/(n-p-m))^r*p
 		Jdet(H, Q, p, -(r+p), f)
 }
 
