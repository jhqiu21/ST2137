weeklies <- read.table("data/weeklies.txt", sep=",", header=TRUE)

check_normality <- function(x) {
  res <- shapiro.test(x)
  if (res$p.value < 0.05) {
    print("Data dose NOT follow normal distribution")
  } else {
    print("Data follows normal distribution") 
  }
}
check_normality(weeklies$current)
check_normality(weeklies$lastyear)

current <- weeklies$current
lastyear <- weeklies$lastyear

weeklies_t_test <- t.test(current, lastyear, paired = TRUE, conf.level = 0.9)
cat("The 90% CI is (", format(weeklies_t_test$conf.int, digits=3), ").", sep="")
# since p > 0.1, not enough evidence to reject H0, hence we can 
# that mean difference in advertising expenditure is not significantly 
# different from 0

diff_vec = current - lastyear
hist(diff_vec, breaks=5)
qqnorm(diff_vec)
qqline(diff_vec)
shapiro.test(diff_vec)
# since p-value > 0.05 not enough evidence to reject H0, then the distribution 
# of different is normal

library(DescTools)

Skew(diff_vec, method=1)
get_skewness <- function(x) {
  x_bar <- mean(x)
  n <- length(x)
  dist <- x - x_bar
  g1 <- (sum(dist^3) / n) / (sum(dist^2)/n)^(3/2)
  (g1)
}
get_skewness(diff_vec)

Kurt(diff_vec, method=1)
get_kurtosis <- function(x) {
  x_bar <- mean(x)
  n <- length(x)
  dist <- x - x_bar
  g2 <- (sum(dist^4)/n) / (sum(dist^2)/n)^2 - 3
  (g2)
}
get_kurtosis(diff_vec)

h1 <- function(x) {
  Q1 <- quantile(x, 0.25)
  Q2 <- median(x)
  Q3 <- quantile(x, 0.75)
  res <- (Q3 + Q1 - 2 * Q2) / (Q3 - Q1)
  unname(res)
}
h1(diff_vec)


data <- read.table("data/machine.txt", header=TRUE)
old <- data[data$machine=='O', "strength"]
new <- data[data$machine=='N', "strength"]

check_normality(old)
check_normality(new)
# normality assumption holds
sd(old)
sd(new)
# sd are equal

t.test(old, new, var.equal = TRUE)
# p < 0.05, reject H0, therefore mean of old is less than new 
# purchasing director should buy this machine

flex <- read.table("data/flextime.txt", header=TRUE)
# dependent parameter
before <- flex$before
after <- flex$after

exact_check <- function(x, y) {
  len <- length(which((x-y)==0))
  if (len == 0) {
    print("The exact parameter should set to be FALSE")
  } else {
    print("The exact parameter should set to be TRUE or Omit")
  }
}
exact_check(before, after)


wilcox.test(after, before, paired = TRUE, alternative = "greater")
wilcox.test(after - before, alternative = "greater")
# p-value = 0.01906 < 0.05, reject H0
# the median of poplation is greater than 0, hence success in 5% significant level

df1 <- data.frame("values"=before, "id"='before')
df2 <- data.frame("values"=after, "id"='after')
flex2 <- stack(flex, select=-employee)










