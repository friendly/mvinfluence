#' Matrix trace
#' 
#' Calculates the trace of a matrix
#' 
#' 
#' @param M a matrix
#' @return returns the sum of the diagonal elements %% ~Describe the value
#' returned %% If it is a LIST, use %% \item{comp1 }{Description of 'comp1'} %%
#' \item{comp2 }{Description of 'comp2'} %% ...
#' @author Michael Friendly
#' @keywords array
#' @examples
#' 
#' M <- matrix(sample(1:9), 3,3)
#' tr(M)
#' 
#' @export tr
tr <-
function(M) sum(diag(M))
