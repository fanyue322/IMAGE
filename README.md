# IMAGE
IMAGE is implemented as an open source R package for mQTL mapping in sequencing-based methylation studies. IMAGE properly accounts for the count nature of bisulfite sequencing data and incorporates allele-specific methylation patterns from heterozygous individuals to enable more powerful mQTL discovery. 

IMAGE jointly accounts for both allele-specific methylation information from heterozygous individuals and non-allele-specific methylation information across all individuals, enabling powerful ASM-assisted mQTL mapping. In addition, IMAGE relies on an over-dispersed binomial mixed model to directly model count data, which naturally accounts for sample non-independence resulting from individual relatedness, population stratification, or batch effects that are commonly observed in sequencing studies.IMAGE can identify 50%-64% more mQTL than existing approaches.

## Cite 

Fan, Y., Vilgalys, T. P., Sun, S., Peng, Q., Tung, J., & Zhou, X. (2019). High-powered detection of genetic effects on DNA methylation using integrated methylation QTL mapping and allele-specific analysis. bioRxiv, 615039.

##Our group

 <http://www.xzlab.org>.
Details in [here](https://fanyue322.github.io/about.html)

# Installation
It is easy to install the development version of IMAGE package using the 'devtools' package.
```
library(devtools)
install_github("3211895/IMAGE")
```
Details in [here](https://fanyue322.github.io/install.html)
# Usage
The main function is image. You can find the instructions and an example by '?image'.

Example:
```
data(ExampleData)
res=image(geno,data,K)
```
Details in [here](https://fanyue322.github.io/index.html)
# Results reproduced
All the results from all methods used in the paper can be reproduced at https://github.com/fanyue322/IMAGEreproduce


