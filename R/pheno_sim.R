
#' Simulate phenotypes from matrices of genotypes
#'
#' @description
#' This takes in both intraparental, F1, and F2 crosses and produces phenotypes from a set of additive and dominance genetic effects. Parameters p1, p2, f1, and f2 are matrices of genotypes where each row is a locus and each column is an individual. Environmental variance is added to the resulting phenotypes by calculating the simulated phenotypic variance in the F2 and, combined with the input broad sense heritability, solving for the environmental variance.
#'
#'
#' @param p1 Matrix of parent 1 population genotypes
#' @param p2 Matrix of parent 2 population genotypes
#' @param f1 Matrix of F1 population genotypes
#' @param f2 Matrix of F2 population genotypes
#' @param a Vector of additive genetic effects
#' @param k Vector of dominance effects
#' @param H2 Broad sense heritability
#'
#' @returns A list of 4 vectors containing the P1, P2, F1, F2 phenotypes.
#' @export
#'
pheno_sim <- function(p1, p2, f1, f2, a, k, H2 = .4){
  pops <- list(p1 = p1, p2 = p2, f1 = f1, f2 = f2)
  phenos <- list(p1 = c(), p2 = c(), f1 = c(), f2 = c())
  for(i in 1:4){
    add <- pops[[i]] - 1
    dom <- ifelse(pops[[i]]==1, 1, 0)
    phenos[[i]] <- apply(add, 2, function(x) sum(x*a)) + apply(dom, 2, function(x) sum(x*a*k))
  }

  v_g <- stats::var(phenos[[4]])
  v_e <- (v_g/H2) - v_g

  for(i in 1:4){
    phenos[[i]] <- stats::rnorm(n = length(phenos[[i]]), mean = 0, sd = sqrt(v_e))
  }

  return(phenos)
}
