#devtools::use_package("glmnet") #already run
#setwd("~/Desktop/rarhsmm")
require("Rcpp")
setwd("~/Desktop/myRpackage")
compileAttributes("rarhsmm_1.0.7")
setwd("~/Desktop/myRpackage/rarhsmm_1.0.7")
devtools::document()
devtools::load_all()
###############################################
devtools::use_build_ignore("cran-comments.md")
devtools::use_build_ignore("test.R")
devtools::check()
devtools::build()
devtools::build_win() #check windows
#upload to http://win-builder.r-project.org/ for additional checks
devtools::release("~/Desktop/myRpackage/rarhsmm_1.0.7")
###############################

multi <- multinomrand(1000,3,c(0.2,0.3,0.5),c(2,3,5))
mvrnorm(5,3,1)

tpm_init1 <- matrix(c(-0.4,0.1,0.1,0.1,0.1,
                      0.7,-1,0.1,0.1,0.1,
                      0.7,0.1,-1,0.1,0.1,
                      0.7,0.1,0.1,-1,0.1,
                      0.7,0.1,0.1,0.1,-1
),M,M,byrow=TRUE)
matrixexp(tpm_init1, 1)


prior <- c(0.2,0.4,0.4)
omega <- matrix(c(-0.3,0.2,0.1,0.125,-0.25,0.125,0.1,0.2,-0.3),3,3,byrow=TRUE)
mu <- list(0,2,5)
sigma <- list(matrix(1),matrix(1.5),matrix(2))
mod <- list(prior=prior, mu=mu, sigma=sigma, tpm=omega,m=3)
result <- hmm.sim.continuous(1000, mod, family="MVN")
head(cbind(result$timeindex,result$state,result$series),10)
y <- result$series
timeindex <- result$timeindex

mod_init <- list(prior=prior,mu=list(-1,1,4),
                 sigma=list(matrix(0.5),matrix(1),matrix(1.5)),
                 tpm=matrix(c(-0.25,0.18,0.07,0.1,-0.2,0.1,0.07,0.18,-0.25),3,3,byrow=TRUE))

fit <- hmmfit.continuous(y,NULL,NULL,3,timeindex,mod_init,"NORMAL","BFGS",
                         control=list(trace=1))
