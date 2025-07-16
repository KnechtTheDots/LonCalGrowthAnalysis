
utils::globalVariables(c("line", "phenotype", "mu", "prop",
                         "grp", "upr", "lwr"))

#' Plots estimates of phenotypic means for parental, F1, and F2 crosses
#'
#' @importFrom ggplot2 aes
#' @param data Simulated cross data from `pheno_sim`
#'
#' @returns A plot of the mean and 95% CI of the mean of simulated crosses.
#' @export
#'
plot_lines <- function(data){

  se <- function(x){
    stats::sd(x)/sqrt(length(x))
  }

  mu <- as.vector(sapply(data, mean))
  upr <- mu + as.vector(sapply(data, function(x) 1.96*se(x)))
  lwr <- mu - as.vector(sapply(data, function(x) 1.96*se(x)))

  data.frame(line = c("p1", "p2", "f1", "f2"),
             mu, upr, lwr,
             prop = c(0, 1, .49, .51),
             grp = c("a", "a", "b", "c")) |>
    ggplot2::ggplot(aes(x = prop, y = mu, group = grp, color = line)) +
    ggplot2::labs(x = "Proportion Parent 2",
                  y = "Phenotype",
                  color = "") +
    ggplot2::geom_line() +
    ggplot2::geom_errorbar(aes(x = prop, ymax = upr, ymin = lwr),
                           width = 0, linewidth = 1) +
    ggplot2::geom_point(size = 2.5) +
    ggplot2::scale_color_manual(values = c("blue", "red", "black", "black")) +
    ggplot2::theme_minimal()

}
