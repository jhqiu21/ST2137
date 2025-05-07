# Question 13
taiwan <- read.csv("data/taiwan_dataset.csv")
library(lattice)
xyplot(price ~ num_stores, data=taiwan)
which(taiwan$price > 100)
taiwan2 <- taiwan[-271,]
taiwan2$num_stores <- factor(taiwan2$num_stores)
# F-test for comparing the means of the 11 groups.
taiwan_model <- lm(price ~ num_stores, data=taiwan2)
anova(taiwan_model)
# use the empirical rule for assessing homogeneity of variances
aggregate(price ~ num_stores, data = taiwan2, sd)
# hence the rule of thumb holds
r1 <- residuals(taiwan_model)
hist(r1)
qqnorm(r1); qqline(r1)
shapiro.test(r1)
# residual holds assumption of normality
# Estimate the contrast comparing the two groups identified in the question.
c1 <- c(rep(1/5, 5), rep(-1/6, 6))
n_vals <- unname(c(table(taiwan2$num_stores)))
summary_out <- anova(taiwan_model)
MSW <- summary_out$`Mean Sq`[2]
df <- summary_out$Df[2]
est <- c(0, unname(coef(taiwan_model))[2:11])
est_coef <- c(0, coef(taiwan_model)[-1])
L <- sum(c1*est_coef)  # construct estimate L
se1 <- sqrt(MSW * sum( c1^2 / n_vals ))  # compute SE
q1 <- qt(0.025, df, 0, lower.tail = FALSE)

lower_ci <- L - q1*se1
upper_ci <- L + q1*se1

cat("The 95% CI for the diff. between the two groups is (",
    format(lower_ci, digits = 2), ",", 
    format(upper_ci, digits = 2), ").", sep="")

# Question 14
box_muller <- function(x) {
  U1 <- runif(x)
  U2 <- runif(x)
  Z1 <- sqrt(-2 * log(U1)) * cos(2 * pi * U2)
  Z2 <- sqrt(-2 * log(U1)) * sin(2 * pi * U2)
  return (c(Z1, Z2))
}

# Use your function in a simulation study (with sample sizes equals to 30) 
# to assess if the Shapiro-Wilk test will indeed reject the observations 
# from the above algorithm 10% of the time, when testing at 
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

# mean 10,000 and variance 1,000,000.


X <- rgamma(n, 100, rate=1/100)








# Question 28
taiwan_outlier_removed <- read.csv("data/taiwan_outlier_removed.csv")
price <- taiwan_outlier_removed$price
ldist <- taiwan_outlier_removed$ldist
num_stores <- taiwan_outlier_removed$num_stores
model <- lm(price ~ ldist + num_stores, data=taiwan_outlier_removed)
new_df <- data.frame(ldist = log(c(2175, 965)), num_stores = c(5,2))
predict(model, new_df, interval="prediction")
infl <- influence.measures(model)
which.max(infl$infmat[, "dfb.nm_s"])
xyplot(price ~ ldist | num_stores, as.table=TRUE, data=taiwan2, layout=c(4,3))



















