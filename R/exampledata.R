#' Example dataset
#'
#' A simulated example dataset of IMAGE.
#' The variables are as follows:
#'
#' @format Contains the following objects:
#' \describe{
#'   \item{geno}{a data list containing 2 haplotypes.}
#'   \item{data}{a data list containing the methylated read counts and total read counts for each allele.}
#'   \item{K}{a genetic relationship matrix.}
#' }
#' @examples 
#' data(exampledata)
#' res=image(exampledata$geno,exampledata$data,exampledata$K)
"exampledata"