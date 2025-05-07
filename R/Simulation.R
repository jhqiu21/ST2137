setwd("~/Desktop/ST2137/src")
set.seed(2139)

X <- runif(50000, 0, 1) # 50000 obs from uniform(0,1)
Y <- rgamma(50, 2, 3) # 50 obs from Gamma(2,3)
W <- rpois(50, 1.3) # 50 obs from Pois(1.3)
Z <- rbinom(50, size=2, 0.3) # 50 obs from Binom(2, 0.3)

hX <- exp(2*X)
(mc_est <- mean(hX))

output_vec <- rep(0, length=100)
n <- 20
lambda <- 0.5
for(i in 1:length(output_vec)) {
  X <- rpois(15, .5)
  Xbar <- mean(X)
  s <- sd(X)
  t <- qt(0.975, n-1)
  CI <- c(Xbar - t*s/sqrt(n), Xbar + t*s/sqrt(n))
  if(CI[1] < lambda & CI[2] > lambda) {
    output_vec[i] <- 1
  }
}
mean(output_vec)



generate_one_test <- function(n=100) {
  X <- rnorm(n)
  Y <- rnorm(n)
  t_test <- t.test(X, Y,var.equal = TRUE)
  # extract the p-value from the t_test
  if(t_test$p.value < 0.10) 
    return(1L) 
  else 
    return(0L)
}

set.seed(11)
output_vec <- vapply(1:2000, 
                     function(x) generate_one_test(), 
                     1L)
mean(output_vec)


# R code to estimate the expected daily profit
set.seed(2141)
n <- 10000
X <- rgamma(n, 100, rate=1/100)
hX <- ifelse(X >= 11000, 11000, floor(X) + (11000 - floor(X)) * (-0.25))
mean(hX)

# 90% CI for the mean
s <- sd(hX)
q1 <- qnorm(0.95)
CI <- c(mean(hX) - q1*s/sqrt(n), mean(hX) + q1*s/sqrt(n))
cat("The 90% CI for the mean is (", format(CI[1], digits=2, nsmall=2), ", ", 
    format(CI[2], digits=2, nsmall=2), ").\n", sep="")



abl <- read.csv("data/abalone_sub.csv")
x <- abl$viscera[abl$gender == "M"]
y <- abl$viscera[abl$gender == "F"]
generate_one_perm <- function(x, y) {
  n1 <- length(x)
  n2 <- length(y)
  xy <- c(x,y)
  xy_sample <- sample(xy)
  d1 <- mean(xy_sample[1:n1]) - mean(xy_sample[-(1:n1)])
  d1
}
sampled_diff <- replicate(2000, generate_one_perm(x,y))
hist(sampled_diff)

library(boot)
library(MASS)
stat_fn <- function(d, i) {
  b <- mean(d[i], trim=0.1)
  b
}
boot_out <- boot(chem, stat_fn, R = 1999, stype="i")
# Returns two types of bootstrap intervals:
boot.ci(boot.out = boot_out, type=c("perc", "bca"))

