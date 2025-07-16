utils::globalVariables(c("trait"))

#' Make Stacked Histogram
#'
#' @importFrom magrittr %>%
#' @param pheno Phenotype to plot
#' @param xlab Label for the x acis
#'
#' @returns A plot of stacked histogram
#' @export
#'
stacked_hist <- function(pheno, xlab){
    d <- LonCalGrowthAnalysis::phenotypes[,c(pheno, "line")]

    colnames(d) <- c("trait", "line")
    d %>%
    dplyr::filter(line != "F1") %>%
    dplyr::mutate(line = ifelse(line == "F2", "F2", "Parent"),
           line = factor(line, levels = c("Parent", "F2"))) %>%
    ggplot2::ggplot(ggplot2::aes(x = trait, fill = line)) +
    ggplot2::geom_histogram(bins = 20, color = "black") +
    ggplot2::scale_fill_manual(values = c("grey", "white")) +
    ggplot2::labs(x = xlab,
         y = "",
         fill = "") +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "inside",
          legend.position.inside = c(.75,.75),
          legend.direction = "horizontal",
          legend.box.background = ggplot2::element_rect(color = "black"))
}
