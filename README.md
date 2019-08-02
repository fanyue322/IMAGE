# IMAGE
mQTL mapping in bisulfite sequencing studies by fitting a binomial mixed model, incorporating allelic-specific methylation pattern. Details in [Simulation](https://github.com/fanyue322/IMAGEreproduce)

# Installation
It is easy to install the development version of IMAGE package using the 'devtools' package.
```
library(devtools)
install_github("3211895/IMAGE")
```
# Usage
The main function is image. You can find the instructions and an example by '?image'.

Example:
```
data(ExampleData)
res=image(geno,data,K)
```
# Results reproduced
All the results from all methods used in the paper can be reproduced at https://github.com/fanyue322/IMAGEreproduce


