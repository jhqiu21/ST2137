setwd("~/Desktop/ST2137/src")
# Question 12
set.seed(21434)

oneSample <- function() {
  sum = 0
  N = 0
  while (sum < 1) {
    sum = runif(1, 0, 1) + sum
    N = 1 + N
  }
  (N)
}

n = 4672
samples = sapply(rep(0, n), function(x) oneSample())
N_bar = mean(samples)
lwr = N_bar - pnorm(0.975) * (sd(samples) / sqrt(n))
upr = N_bar + pnorm(0.975) * (sd(samples) / sqrt(n))
cat("95%-CI is (", lwr, ",", upr, ")", sep="")


# Question 13
data = read.csv("data/taiwan_dataset.csv")
library(lattice)
# dotplot(price ~ num_stores, data)
xyplot(price ~ num_stores, data)
which.max(data$price) # 271
data2 <- data[-271, ]
data2$num_stores <- as.factor(data2$num_stores)
anova1 <- aov(price ~ num_stores, data = data2)
summary(anova1)
aggregate(price ~ num_stores, data = data2, sd)
r1 <- residuals(anova1)
qqnorm(r1, main = "QQ plot of residuals")
qqline(r1)








# Question 14
box_muller <- function(n) {
  U1 <- runif(n, 0, 1)
  U2 <- runif(n, 0, 1)
  Z1 <- sqrt(-2 * log(U1)) * cos(2 * pi * U2)
  Z2 <- sqrt(-2 * log(U1)) * sin(2 * pi * U2)
  c(Z1, Z2)
}
samples <- box_muller(30)
shapiro.test(samples)

set.seed(123)
n_size <- 30
alpha <- 0.1
output <- rep(0, 1000)
for(i in 1:1000){
  X <- box_muller(n_size)
  test_out <- ks.test(X, "pnorm")$p.value
  if(test_out < alpha){
    output[i] <- 1
  } else {
    output[i] <- 0
  }
}
# Report CI
p_est <- mean(output)
lower_ci <- p_est - 1.96*sqrt(p_est*(1-p_est)/1000)
upper_ci <- p_est + 1.96*sqrt(p_est*(1-p_est)/1000)
c(lower_ci, upper_ci)


# Question 27

sim_inventory <- function(nsim, npapers, alpha=0.05) {
  #set.seed(2141)
  n <- nsim
  X <- rgamma(n, 100, rate=1/100)
  hX <- ifelse(X >= npapers, npapers, floor(X) + (npapers - floor(X)) * (-0.25))
  s <- sd(hX)
  q1 <- qnorm(1-alpha/2)
  CI <- c(mean(hX) - q1*s/sqrt(n), mean(hX) + q1*s/sqrt(n))
  return(c(mean(hX), CI))
}

# Run the simulation for various values of C
set.seed(2002)
nsim <- 1000
c_vals <- seq(9000, 13000, by=100)
sim_output <- sapply(c_vals, sim_inventory, nsim=nsim, alpha=0.05)

plot(x=c_vals, y=sim_output[1,], type='l', xlab='Number of newspapers', 
     ylab='Expected profit', main='Expected profit vs number of newspapers',
     ylim=c(8500, 10000))
lines(x=c_vals, y=sim_output[2,], col='red', lty=2)
lines(x=c_vals, y=sim_output[3,], col='red', lty=2)















