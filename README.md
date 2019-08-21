# IMAGE
![IMAGE](https://github.com/fanyue322/fanyue322.github.io/blob/master/LOGO.jpg "IMAGE logo")  
IMAGE is implemented as an open source R package for mQTL mapping in sequencing-based methylation studies. IMAGE properly accounts for the count nature of bisulfite sequencing data and incorporates allele-specific methylation patterns from heterozygous individuals to enable more powerful mQTL discovery. 

IMAGE jointly accounts for both allele-specific methylation information from heterozygous individuals and non-allele-specific methylation information across all individuals, enabling powerful ASM-assisted mQTL mapping. In addition, IMAGE relies on an over-dispersed binomial mixed model to directly model count data, which naturally accounts for sample non-independence resulting from individual relatedness, population stratification, or batch effects that are commonly observed in sequencing studies.IMAGE can identify 50%-64% more mQTL than existing approaches.

## Cite 

Fan, Y., Vilgalys, T. P., Sun, S., Peng, Q., Tung, J., & Zhou, X. (2019). High-powered detection of genetic effects on DNA methylation using integrated methylation QTL mapping and allele-specific analysis. bioRxiv, 615039.

Details in [here](https://fanyue322.github.io/about.html)

# Installation
IMAGE is implemented as an R package, which can be installed from either GitHub or CRAN.

#### 1. Install from GitHub
```
library(devtools)
install_github("3211895/IMAGE")
```
#### 2. Install from CRAN
```
install.packages('IMAGE')
```
Details in [here](https://fanyue322.github.io/install.html)
# Usage
The main function is image. You can find the instructions and an example by '?image'.

##Example
```
data(ExampleData)
geno <- ExampleData$geno
K <- ExampleData$K
data <- ExampleData$data
res=image(geno,data,K)
```
An example of the outputs IMAGE produces:
```
data(example_results)
```
A toy example for testing purposes only:
```
geno <- list()
geno$hap1 = matrix(sample(c(0,1),25, replace = TRUE, prob = c(0.6,0.4)),
                    nrow = 5, ncol = 5)
geno$hap2 = matrix(sample(c(0,1),25, replace = TRUE, prob = c(0.6,0.4)),
                    nrow = 5, ncol = 5)

data <- list()
data$r = matrix(sample(0:50,25, replace = TRUE), nrow = 5, ncol = 5)
data$y = matrix(sample(0:50,25, replace = TRUE), nrow = 5, ncol = 5)
data$r1 = matrix(sample(0:50,25, replace = TRUE), nrow = 5, ncol = 5)
data$r2 = matrix(sample(0:50,25, replace = TRUE), nrow = 5, ncol = 5)
data$y1 = matrix(sample(0:50,25, replace = TRUE), nrow = 5, ncol = 5)
data$y2 = matrix(sample(0:50,25, replace = TRUE), nrow = 5, ncol = 5)

K = matrix(runif(25,-0.1,0.1), nrow = 5, ncol = 5)

res=image(geno,data,K)
```
To normalize the pvalues:
```
p<-res[,5]
chisq <- qchisq(1-p,1)
lambda=median(chisq)/qchisq(0.5,1)
chisq=chisq/lambda
pvalue=pchisq( chisq, 1, lower.tail = F)
```

## Code for experiments
[Simulation](https://github.com/fanyue322/IMAGEreproduce)

[Real data](https://github.com/fanyue322/IMAGEreproduce/tree/master/Realdata)

Details in [here](https://fanyue322.github.io/index.html)
# Results reproduced
All the results from all methods used in the paper can be reproduced at https://github.com/fanyue322/IMAGEreproduce

## Our group

 <http://www.xzlab.org>.
