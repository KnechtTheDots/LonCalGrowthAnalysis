
#' Calculate expected phenotypic variation and means caused by additive and dominant genotypic effects
#'
#' @param frq Vector of allele frequencies
#' @param a Vector of additive genetic effects (i.e. substituting an allele increases the phenotype by a value of a)
#' @param k Vector of dominance effects. -1 is dominance of one allele, 1 is dominance of the other, values outside would be under/over dominant, depending on fitness context
#'
#' @export
#' @rdname quant_gen
mu_calc <- function(frq, a, k){
  return(frq^2*-a + 2*frq*(1-frq)*a*k + (1-frq)^2*a)
}

#' @param mu vector of phenotypic means at each locus
#' @export
#' @rdname quant_gen
var_calc <- function(frq, a, k, mu){
  return(sum(frq^2*(-a - mu)^2 + 2*frq*(1-frq)*(a*k - mu)^2 + (1-frq)^2*(a - mu)^2))
}
