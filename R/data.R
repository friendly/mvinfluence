

#' Fertilizer Data
#' 
#' A small data set on the use of fertilizer (x) in relation to the amount of
#' grain (y1) and straw (y2) produced.
#' 
#' The first observation is an obvious outlier and influential observation.
#' 
#' @name Fertilizer
#' @docType data
#' @format A data frame with 8 observations on the following 3 variables.
#' \describe{ \item{list("grain")}{amount of grain produced}
#' \item{list("straw")}{amount of straw produced}
#' \item{list("fertilizer")}{amount of fertilizer applied} }
#' @references Hossain, A. and Naik, D. N. (1989). Detection of influential
#' observations in multivariate regression. \emph{Journal of Applied
#' Statistics}, 16 (1), 25-37.
#' @source Anderson, T. W. (1984). \emph{An Introduction to Multivariate
#' Statistical Analysis}, New York: Wiley, p. 369.
#' @keywords datasets
#' @examples
#' 
#' data(Fertilizer)
#' 
#' # simple plots
#' plot(Fertilizer, col=c('red', rep("blue",7)), cex=c(2,rep(1.2,7)), pch=as.character(1:8))
#' biplot(prcomp(Fertilizer))
#' 
#' #fit mlm
#' mod <- lm(cbind(grain, straw) ~ fertilizer, data=Fertilizer)
#' Anova(mod)
#' 
#' # influence plots (m=1)
#' influencePlot(mod)
#' influencePlot(mod, type='LR')
#' influencePlot(mod, type='stres')
#' 
#' 
NULL





#' Regression Deletion Diagnostics for Multivariate Linear Models
#' 
#' The functions \code{cooks.distance.mlm} and \code{hatvalues.mlm} are
#' designed as extractor functions for regression deletion diagnostics for
#' multivariate linear models following Barrett & Ling (1992). These are close
#' analogs of methods for univariate and generalized linear models handled by
#' the \code{\link[stats]{influence.measures}} in the \code{stats} package.
#' 
#' In addition, the functions provide diagnostics for deletion of subsets of
#' observations of size \code{m>1}.
#' 
#' 
#' @aliases cooks.distance.mlm hatvalues.mlm
#' @param model A \code{mlm} object, as returned by \code{\link[stats]{lm}}
#' with a multivariate response
#' @param do.coef logical. Should the coefficients be returned in the
#' \code{inflmlm} object?
#' @param m Size of the subsets for deletion diagnostics
#' @param infl An influence structure, of class \code{inflmlm} as returned by
#' \code{\link{mlm.influence}}
#' @param \dots Other arguments, passed on
#' @return When \code{m=1}, these functions return a vector, corresponding to
#' the observations in the data set.
#' 
#' When \code{m>1}, they return a list of \eqn{m \times m} matrices,
#' corresponding to deletion of subsets of size \code{m}. %% If it is a LIST,
#' use %% \item{comp1 }{Description of 'comp1'} %% \item{comp2 }{Description of
#' 'comp2'} %% ...
#' @author Michael Friendly
#' @seealso \code{\link{influencePlot.mlm}}, ~~~
#' @references Barrett, B. E. and Ling, R. F. (1992). General Classes of
#' Influence Measures for Multivariate Regression. \emph{Journal of the
#' American Statistical Association}, \bold{87}(417), 184-191.
#' @keywords models regression
#' @examples
#' 
#' data(Rohwer, package="heplots")
#' Rohwer2 <- subset(Rohwer, subset=group==2)
#' rownames(Rohwer2)<- 1:nrow(Rohwer2)
#' Rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n+s+ns+na+ss, data=Rohwer2)
#' 
#' hatvalues(Rohwer.mod)
#' cooks.distance(Rohwer.mod)
#' 
#' 
NULL





#' General Classes of Influence Measures
#' 
#' These functions implement the general classes of influence measures for
#' multivariate regression models defined in Barrett and Ling (1992), Eqn 2.3,
#' 2.4, as shown in their Table 1.
#' 
#' They are defined in terms of the submatrices for a deleted index subset
#' \eqn{I} \deqn{H_I = X_I (X^T X)^{-1} X_I} \deqn{Q_I = E_I (E^T E)^{-1} E_I}
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
#' but they are only included here for experimental purposes.
#' 
#' These functions are purely experimental and not intended to be used
#' directly. However, they may be useful to define other influence measures
#' than are currently implemented here.
#' 
#' @aliases Jdet Jtr COOKD COVRATIO DFFITS
#' @param H a scalar or \eqn{m \times m} matrix giving the hat values for
#' subset \eqn{I}
#' @param Q a scalar or \eqn{m \times m} matrix giving the residual values for
#' subset \eqn{I}
#' @param a the \eqn{a} parameter for the \eqn{J^{det}} and \eqn{J^{tr}}
#' classes
#' @param b the \eqn{b} parameter for the \eqn{J^{det}} and \eqn{J^{tr}}
#' classes
#' @param f scaling factor for the \eqn{J^{det}} and \eqn{J^{tr}} classes
#' @param n sample size
#' @param p number of predictor variables
#' @param r number of response variables
#' @param m deletion subset size
#' @return The scalar result of the computation. %% ~Describe the value
#' returned %% If it is a LIST, use %% \item{comp1 }{Description of 'comp1'} %%
#' \item{comp2 }{Description of 'comp2'} %% ...
#' @author Michael Friendly
#' @references Barrett, B. E. and Ling, R. F. (1992). General Classes of
#' Influence Measures for Multivariate Regression. \emph{Journal of the
#' American Statistical Association}, \bold{87}(417), 184-191.
#' @keywords array
NULL





#' c("\\Sexpr[results=rd,stage=build]{tools:::Rd_package_title(\"#1\")}",
#' "mvinfluence")\Sexpr{tools:::Rd_package_title("mvinfluence")}
#' 
#' This collection of functions is designed to compute regression deletion
#' diagnostics for multivariate linear models following Barrett & Ling (1992).
#' These are close analogs of standard methods for univariate and generalized
#' linear models handled by the \code{\link[stats]{influence.measures}} in the
#' \code{stats} package. These functions also extend plots of influence
#' diagnostic measures such as those provided by
#' \code{\link[car]{influencePlot}} in the \code{stats} package.
#' 
#' In addition, the functions provide diagnostics for deletion of subsets of
#' observations of size \code{m>1}. This case is theoretically interesting
#' because sometimes pairs (\code{m=2}) of influential observations can mask
#' each other, sometimes they can have joint influence far exceeding their
#' individual effects, as well as other interesting phenomena described by
#' Lawrence (1995). Associated methods for the case \code{m>1} are still under
#' development in this package.
#' 
#' 
#' The DESCRIPTION file:
#' c("\\Sexpr[results=rd,stage=build]{tools:::Rd_package_DESCRIPTION(\"#1\")}",
#' "mvinfluence")\Sexpr{tools:::Rd_package_DESCRIPTION("mvinfluence")}
#' c("\\Sexpr[results=rd,stage=build]{tools:::Rd_package_indices(\"#1\")}",
#' "mvinfluence")\Sexpr{tools:::Rd_package_indices("mvinfluence")} ~~ An
#' overview of how to use the package, including the most important ~~ ~~
#' functions ~~ The design goal for this package is that, as an extension of
#' standard methods for univariate linear models, you should be able to fit a
#' linear model with a multivariate response, \preformatted{ mymlm <- lm(
#' cbind(y1, y2, y3) ~ x1 + x2 + x3, data=mydata) } and then get useful
#' diagnostics and plots with \preformatted{ influence(mymlm) hatvalues(mymlm)
#' influencePlot(mymlm, ...)  }
#' 
#' @name mvinfluence-package
#' @aliases mvinfluence-package mvinfluence
#' @docType package
#' @author
#' c("\\Sexpr[results=rd,stage=build]{tools:::Rd_package_author(\"#1\")}",
#' "mvinfluence")\Sexpr{tools:::Rd_package_author("mvinfluence")}
#' 
#' Maintainer:
#' c("\\Sexpr[results=rd,stage=build]{tools:::Rd_package_maintainer(\"#1\")}",
#' "mvinfluence")\Sexpr{tools:::Rd_package_maintainer("mvinfluence")}
#' @seealso \code{\link{influence.measures}}, \code{\link{influence.mlm}},
#' \code{\link{influencePlot.mlm}}, ...
#' 
#' \code{\link{Jdet}}, \code{\link{Jtr}} provide some theoretical description
#' and definitions of influence measures in the Barrett & Ling framework.
#' @references Barrett, B. E. and Ling, R. F. (1992). General Classes of
#' Influence Measures for Multivariate Regression. \emph{Journal of the
#' American Statistical Association}, \bold{87}(417), 184-191.
#' 
#' Barrett, B. E. (2003). Understanding Influence in Multivariate Regression.
#' \emph{Communications in Statistics -- Theory and Methods}, \bold{32}, 3,
#' 667-680.
#' 
#' A. J. Lawrence (1995). Deletion Influence and Masking in Regression
#' \emph{Journal of the Royal Statistical Society. Series B (Methodological)} ,
#' Vol. \bold{57}, No. 1, pp. 181-189.
#' @keywords package
#' @examples
#' 
#' # none here
#' 
NULL



