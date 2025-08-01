#' Calculate Regression Deletion Diagnostics for Multivariate Linear Models
#' 
#' \code{mlm.influence} is the main computational function in this package. It
#' is usually not called directly, but rather via its alias,
#' \code{\link{influence.mlm}}, the S3 method for a \code{mlm} object.
#' 
#' The computations and methods for the \code{m=1} case are straight-forward,
#' as are the computations for the \code{m>1} case.  Associated methods for
#' \code{m>1} are still under development.
#' 
#' @param model      An \code{mlm} object, as returned by \code{\link[stats]{lm}} with a multivariate response.
#' @param do.coef    logical. Should the coefficients be returned in the
#'                   \code{inflmlm} object?
#' @param m          Size of the subsets for deletion diagnostics
#' @param \dots      Further arguments passed to other methods
#' 
#' @return \code{mlm.influence} returns an S3 object of class \code{inflmlm}, a
#' list with the following components: 
#'    \item{m}{Deletion subset size} 
#'    \item{H}{Hat values, \eqn{H_I}. If \code{m=1}, a vector of
#'             diagonal entries of the \sQuote{hat} matrix.  Otherwise, a list of \eqn{m\times m} 
#'             matrices corresponding to the \code{subsets}.} 
#'     \item{Q}{Residuals, \eqn{Q_I}.} 
#'     \item{CookD}{Cook's distance values} 
#'     \item{L}{Leverage components} 
#'     \item{R}{Residual components} 
#'     \item{subsets}{Indices of the observations in the subsets of size \code{m}} 
#'     \item{labels}{Observation labels} 
#'     \item{call}{Model call for the \code{mlm} object}
#'     \item{Beta}{Deletion regression coefficients-- included if\code{do.coef=TRUE}} 
#'
#' @importFrom utils combn
#' @importFrom stats model.matrix model.frame model.response
#' @author Michael Friendly
#' @seealso \code{\link{influencePlot.mlm}}
#' 
#' @references Barrett, B. E. and Ling, R. F. (1992). General Classes of
#' Influence Measures for Multivariate Regression. \emph{Journal of the
#' American Statistical Association}, \bold{87}(417), 184-191.
#' 
#' Barrett, B. E. (2003). Understanding Influence in Multivariate Regression.
#' \emph{Communications in Statistics -- Theory and Methods}, \bold{32}, 3,
#' 667-680.
#' @keywords models regression multivariate
#' @examples
#' 
#' Rohwer2 <- subset(Rohwer, subset=group==2)
#' rownames(Rohwer2)<- 1:nrow(Rohwer2)
#' Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)
#' Rohwer.mod
#' influence(Rohwer.mod)
#' 
#' # extract the most influential cases
#' influence(Rohwer.mod) |> 
#'     as.data.frame() |> 
#'     dplyr::arrange(dplyr::desc(CookD)) |> 
#'     head()
#' 
#' # Sake data
#' Sake.mod <- lm(cbind(taste,smell) ~ ., data=Sake)
#' influence(Sake.mod) |>
#'     as.data.frame() |> 
#'     dplyr::arrange(dplyr::desc(CookD)) |> head()
#' 
#' 
#' @export
mlm.influence <-
function (model, do.coef = TRUE, m=1, ...) 
{
#    wt.res <- weighted.residuals(model)
#    e <- na.omit(wt.res)
#    if (model$rank == 0) {
#        n <- length(wt.res)
#        sigma <- sqrt(deviance(model)/df.residual(model))
#        res <- list(hat = rep(0, n), coefficients = matrix(0, 
#            n, 0), sigma = rep(sigma, n), wt.res = e)
#    return(res)
#    }

	# helper functions
  vec <- function(M) {
  	R <- matrix(M, ncol=1)
  	if (is.vector(M)) return(R)
  	nn<-expand.grid(dimnames(M))[,2:1]
  	rownames(R) <- apply(as.matrix(nn), 1, paste, collapse=":")
  	R
  	}

	X <- model.matrix(model)
	data <- model.frame(model)
	Y <- as.matrix(model.response(data))
	r <- ncol(Y)
	n <- nrow(X)
	p <- ncol(X)
	labels <- rownames(X)
	call <- model$call
	
	B <- coef(model)
	E <- residuals(model)
	XPXI <- solve(crossprod(X))
	EPEI <- solve(crossprod(E))
	vB <- vec(t(B))
	S <- crossprod(E)/(n-p);
	V <- solve(p*S) %x% crossprod(X)
	
	subsets <- t(combn(n, m))
	nsub <- nrow(subsets) 
	
	# at this point, there are several choices for fitting:
	# (a) update(model, subset=!(1:n) %in% subsets[i,])
	# (b) lm.fit(X[rows,], Y[rows,])
	# (c) direct matrix calculation
	#
	# For each subset:  keep Beta=coefficients, Hat=hatvalues E=residuals, ...
	# I don't know how to use the qr() components of (a) or (b) to
	# calculate hatvalues, so I'm using direct calculation

	Beta <- as.list(rep(0, nsub))
	R <- L <- H <- Q <- as.list(rep(0, nsub))
	CookD <- as.vector(rep(0, nsub))

	for (i in seq(nsub)) {
		I <- c(subsets[i,])
		rows <- which(!(1:n) %in% I)
		XI <- X[rows,]
		YI <- Y[rows,]
		BI <- solve(crossprod(XI)) %*% t(XI) %*% YI
		EI <- (Y - X %*% BI)[I, , drop=FALSE]
		CookD[i] <- t(vec(B - BI)) %*% V %*% vec(B - BI)
		H[[i]] <- X[I, , drop=FALSE] %*% XPXI %*% t(X[I, , drop=FALSE])
		Q[[i]] <- EI %*% EPEI %*% t(EI)
		if (do.coef) Beta[[i]] <- BI
		L[[i]] <- if(m==1) H[[i]] / (1-H[[i]]) else H[[i]] %*% solve(diag(m) - H[[i]])
		R[[i]] <- if(m==1) Q[[i]] / (1-H[[i]]) 
					else {
					IH <- mpower(diag(m)-H[[i]], -1/2)
					IH %*% Q[[i]] %*% IH
					}
	}
	if(m==1) {
		H <- unlist(H)
		Q <- unlist(Q)
		L <- unlist(L)
		R <- unlist(R)
		subsets <- c(subsets)
	}
	result <- list(m=m, 
	               H=H, 
	               Q=Q, 
	               CookD=CookD, 
	               L=L, 
	               R=R, 
	               subsets=subsets, 
	               labels=labels, 
	               call=call)
	if (do.coef) result <- c(result, list(Beta=Beta))
	class(result) <-"inflmlm"
	result
}
