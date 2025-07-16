
#' Simulate Parents for Crosses
#'
#' @description
#' This function simulates parents from potentially diverged populations to make crosses with. It assumes that the parental populations are in Hardy-Weinberg and Linkage equilibrium and generates two parents from each of two populations.
#'
#'
#' @param frq1 Vector of allele frequencies for loci in the 1st parental population
#' @param frq2 Vector of allele frequencies for loci in the 2nd parental population
#' @param n_loc Number of loci being simulated
#'
#' @returns A list of matrices. Each matrix contains a row for each locus and a column for each chromosome in the parent.
#'
#' @rdname parent_sim
#' @export
#'
parent_sim <- function(frq1, frq2, n_loc){
  p1_1 <- p1_2 <- p2_1 <- p2_2 <- matrix(nrow = n_loc, ncol = 2)
  for(i in 1:2){
    p1_1[,i] <- stats::rbinom(n_loc, 1, frq1)
    p1_2[,i] <- stats::rbinom(n_loc, 1, frq1)
    p2_1[,i] <- stats::rbinom(n_loc, 1, frq2)
    p2_2[,i] <- stats::rbinom(n_loc, 1, frq2)
  }
  return(list(p1_1 = p1_1, p1_2 = p1_2, p2_1 = p2_1, p2_2 = p2_2))
}


#' Makes parents for crosses.
#'
#' @description
#' This takes in a set of parents and generates an offspring simulating recombination.
#'
#'
#' @param p1 Matrix with parent 1 genotypes, rows are loci and columns are the 2 chromosomes
#' @param p2 Matrix with parent 2 genotypes, rows are loci and columns are the 2 chromosomes
#' @param r Recombination rate between adjacent loci.
#'
#' @returns A matrix of genotypes for the resulting offspring. Rows are loci and there are 2 columns for chromosomes.
#' @export
#'
make_cross_parents <- function(p1, p2, r = .5){
  offspring <- matrix(nrow = nrow(p1), ncol = 2)
  chrom1 <- sample(1:2)
  chrom2 <- sample(1:2)
  for(i in 1:nrow(p1)){
    offspring[i,] <- c(p1[i,chrom1[1]], p2[i,chrom2[1]])
    if(stats::runif(1) < r){
      chrom1 <- rev(chrom1)
    }
    if(stats::runif(1) < r){
      chrom2 <- rev(chrom2)
    }
  }
  return(offspring)
}

#' Generate a set of offspring from a cross.
#'
#' @param p1 Matrix of parent 1 genotypes
#' @param p2 Matrix of parent 2 genotypes
#' @param r Recombination rate between adjacent loci
#' @param n_off Number of offspring to be generated
#'
#' @returns A matrix of offspring genotypes, rows are loci and columns are individuals.
#' @export
#'
cross_sim <- function(p1, p2, r = .5, n_off){
  offspring <- matrix(nrow = nrow(p1), ncol = n_off)
  for(j in 1:n_off){
    chrom1 <- sample(1:2)
    chrom2 <- sample(1:2)
    for(i in 1:nrow(p1)){
      offspring[i,j] <- p1[i,chrom1[1]] + p2[i,chrom2[1]]
      if(stats::runif(1) < r){
        chrom1 <- rev(chrom1)
      }
      if(stats::runif(1) < r){
        chrom2 <- rev(chrom2)
      }
    }
  }
  return(offspring)
}
