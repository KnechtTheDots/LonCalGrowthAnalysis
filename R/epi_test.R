
#' A test for epistasis.
#'
#' @param p1 A vector of estimated parent 1 phenotype means
#' @param p2 A vector of estimated parent 2 phenotype means
#' @param f1 A vector of estimated F1 phenotype means
#' @param f2 A vector of estimated F2 phenotype means
#'
#' @returns A vector of differences between the observed F2 phenotypic mean and the expected F2 phenotypic mean, a value of zero indicates an additive and/or dominance genetic architecture sufficiently explains the data. If input vectors were generated through bootstrapping the output is an estimate the sampling distribution of the difference, or an approximation of the posterior if the vectors of means were generated through Bayesian analysis.
#'
#' @source See Lynch and Walsh (1998) Chapter 9 for the t-test version this was adapted from.
#' @export
#'
epi_test <- function(p1, p2, f1, f2){
  return(f2 - (f1/2 + (p1 + p2)/4))
}
