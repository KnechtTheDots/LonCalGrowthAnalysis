#' Seedling Phenotypic Data
#'
#' Data set of phenotypes for *Mimulus aurantiacus* var *longiflorus* x *Mimulus aurantiacus* var *calycinus* crosses.
#'
#' @format ## `phenotypes`
#' A data frame with `r nrow(phenotypes)` rows (seedlings) and `r ncol(phenotypes)` columns (phenotypes):
#' \describe{
#'   \item{day_4}{Seedling leaf area (mm^2) 1 day after germination}
#'   \item{day_17}{Seedling leaf area (mm^2) 14 days after germination}
#'   \item{rgr}{Relative growth rate from day 4 to day 17, i.e. the change in log(area) between these timepoints}
#'   \item{height}{Height (cm) measured ~4 months after germination}
#'   \item{line}{cross type, i.e. intraparental *longiflorus* (LON), intraparental *calycinus* (CAL), F1 or F2 hybrids}
#' }
#' @source Not yet published.
"phenotypes"
