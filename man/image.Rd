\name{image}
\alias{image}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Methylation quantitative trait locus mapping assisted with allelic specific methylation pattern for bisulfite sequencing studies.
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
mQTL mapping in bisulfite sequencing studies by fitting a binomial mixed model, incorporating allelic-specific methylation pattern.
}
\usage{
image <- function(geno,data,K,Covariates=NULL,numCore=1,fit.maxiter=500,fit.tol=1e-5,verbose=TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
 \item{geno}{
%%     ~~Describe \code{geno} here~~
a data list containing the genotype data.
}
  \item{data}{
%%     ~~Describe \code{data} here~~
a data list containing the methylation data.
}
  \item{K}{
%%     ~~Describe \code{K} here~~
a known kinship matrix. This matrix should be a positive semi-definite matrix with dimensions equal to the samplie size.
}
  \item{Covariates}{
%%     ~~Describe \code{Covariates} here~~
a matrix containing the covariates subject to adjustment (Default = NULL).
}
  \item{numCore}{
%%     ~~Describe \code{numCore} here~~
a positive integer specifying the number of cores for parallel computing (default = 1).
}
  \item{fit.maxiter}{
%%     ~~Describe \code{numCore} here~~
a positive integer specifying the maximum number of iterations when fitting the generalized linear mixed model (default = 500).
}
  \item{fit.maxiter}{
%%     ~~Describe \code{numCore} here~~
a positive number specifying tolerance, the difference threshold for parameter estimates below which iterations should be stopped (default = 1e-5).
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
  \item{loc}{ordinal number of SNP-CpG pair being analyzed}
  \item{numIDV}{number of observations of SNP-CpG pair being analyzed}
  \item{beta}{the fixed effect parameter estimate for the predictor of interest.}
  \item{se_beta}{the standard deviation of fixed effect.}
  \item{pvalue}{P value for the fixed effect, based on the wald test.}
  \item{h2}{heritability of the transformed rate.}
  \item{sigma2}{total variance component.}
  \item{converged}{a logical indicator for convergence.}
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{

data(ExampleData)
res=image(geno,data,K)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
