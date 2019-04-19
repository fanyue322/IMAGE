# IMAGE
mQTL mapping in bisulfite sequencing studies by fitting a binomial mixed model, incorporating allelic-specific methylation pattern.

# Installation
It is easy to install the development version of MethylQTL package using the 'devtools' package.
```
library(devtools)
install_github("3211895/IMAGE")
```
# Usage
The main function is image. You can find the instructions and an example by '?IMAGE'.

Example:
```
data(ExampleData)
res=image(geno,data,K)
```

