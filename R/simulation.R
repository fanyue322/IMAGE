library(Matrix)
library(MASS)

SimuGeno<-function(n,m,genotype)
{
  geno <- list()
  geno[[1]]<-matrix(0,nrow=n,ncol=m)
  geno[[2]]<-matrix(0,nrow=n,ncol=m)
  for(i in 1:m)
  {
    genotype_i=genotype[i,]
    idx1=which(genotype_i==1)
    idx2=which(genotype_i==2)
    geno1=rep(0,n)
    geno2=rep(0,n)
    geno1[idx2]=1
    geno2[idx2]=1
    rtmp=1
    for(j in idx1)
    {
      rtmp=runif(1,0,1)
      if(rtmp>0.5)
      {
        geno1[j]=1
      }else{
        geno2[j]=1
      }
    }
    geno[[1]][,i]<-geno1
    geno[[2]][,i]<-geno2
  }
  names(geno) <- c('hap1', 'hap2')
  return(geno)
}

cal_K<-function(n,m,geno)
{
  genotype=t(geno$hap1)+t(geno$hap2)
  N=nrow(genotype)
  geno=matrix(0,ncol=n,nrow=N)
  for(i in 1:N)
  {
    idx=which(genotype[i,]!=-9)
    geno_mean=mean(genotype[i,idx])
    tmp=genotype[i,]
    if(length(idx)!=n)
    {
      tmp[-idx]=geno_mean
    }
    tmp=tmp-geno_mean
    tmp=tmp/sd(tmp)*sqrt(n/(n-1))
    geno[i,]=tmp
  }
  K=matrix(0,nrow=n,ncol=n)
  N=nrow(geno)
  cout=0
  for(i in 1:N)
  {
    if(length(which(is.na(geno[i,])))==0)
    {
      K=K+ geno[i,]%*%t(geno[i,])
      cout=cout+1
    }
  }
  
  K=K/N
  return(K)
}


logit <- function(x) {
  log(x/(1-x))
}

logistic <- function(x) {
  exp(x)/(exp(x)+1)
}

SimuRead <- function(geno, m1, m2, NBsize, MeanTR, K=NULL,
                     h=0, rho=0, pve=0.1, sigma=1, mu=0.5,
                     FixTR=FALSE, EvenSP=FALSE) {
  m <- m1 + m2
  n <- nrow(geno[[1]])
  g1 <- scale(geno[[1]], scale=FALSE)
  g2 <- scale(geno[[2]], scale=FALSE)
  
  # Simulate total read counts
  total <- sapply(1:m, function(i) {
    rnbinom(n=n, size=NBsize, mu=MeanTR)
  })
  if (FixTR != FALSE) {
    total <- matrix(FixTR, nrow=n, ncol=m)
  }
  data = list()
  data[[1]] <- total
  data[[2]] <- 0
  
  # r1
  data[[3]] <- apply(total, 2, function(x) {
    qj <- rbeta(n=n, shape1=10, shape2=10)
    r1 <- sapply(x, function(r) rbinom(n=1, size=r, prob=qj))
    return(r1)
  })
  #r2
  data[[4]] <- total - data[[3]]

  if (EvenSP == TRUE) {
    data[[3]] <- apply(total, 2, function(x) {
      r1 <- sapply(x, function(r) round(r*0.5))
      return(r1)
    })
    data[[4]] <- total - data[[3]]
  }
  
  ### Simulate methylated read counts
  asm = c(rep(1, m1), rep(0, m2))
  
  Sigma = matrix(rho*(1-pve-h)*sigma, nrow=2, ncol=2)
  diag(Sigma) <- rep((1-pve-h)*sigma, 2)
  err = mvrnorm(n=n*m, mu=c(0, 0), Sigma=Sigma)
  error = list(hap1 = matrix(err[, 1], nrow=n, ncol=m),
               hap2 = matrix(err[, 2], nrow=n, ncol=m))
  
  if (!is.null(K)) {
    # Genetic correlation
    K <- h*sigma*(K)
    g <- mvrnorm(n=m, mu=rep(0, n), Sigma=K)
    
    error[[1]] <- error[[1]] + t(g)
    error[[2]] <- error[[2]] + t(g)
  }
  
  beta <- sapply(1:m, function(i) {
    b <- sqrt(pve*sigma/(max(var(g1[, i]),var(g2[, i]))))
    return(c(mu, b*asm[i]))
  })
  
  # y1
  data[[5]] <- sapply(1:m, function(i) {
    pi1 <- logistic( logit(mu) + g1[, i] * beta[2, i] + error[[1]][, i])
    return(sapply(1:n, function(j) {
      return(rbinom(1, data[[3]][j, i], pi1[j]))
    }) )
  })
  # y2
  data[[6]] <- sapply(1:m, function(i) {
    pi2 <- logistic( logit(mu) + g2[, i] * beta[2, i] + error[[2]][, i])
    return(sapply(1:n, function(j) {
      return(rbinom(1, data[[4]][j, i], pi2[j]))
    }) )
  })
  
  data[[2]] <- data[[5]] + data[[6]]
  
  names(data) <- c('r', 'y', 'r1', 'r2', 'y1', 'y2')
  return(data)
}

###############Simulation Data###################################

  m1=1000
  m2=9000
  m=m1+m2 
  
  n=100 ######sample size
  
  h=0.3#######heritability
  rho=0#######proportion of total environmental variance that is shared between two alleles
  TR=20#######expected per-site total read 
  mu=0.5######average methylation ratio 
  sigma=0.7###over-dispersion variance 
  pve=0.1#####SNP effect size 
  
  
  geno <- SimuGeno(n, m=m, genotype)
  #########
  K<-cal_K(n,m,geno)
  ##########
  h=(1+rho)*h/(2+(rho-1)*h)
 
  
  ### Simulate reads count
  data <- SimuRead(geno, m1=m1, m2=m2, NBsize=3, MeanTR=TR,
                   K = K, h=h,
                   rho=rho, pve=pve, sigma=sigma, mu=mu,
                   FixTR=FALSE)


