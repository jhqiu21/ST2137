setwd("~/Desktop/ST2137/src")
set.seed(2107)
m <- c()
for (i in c(1:50)) {
  Z <- rnorm(30, mean = 0, sd = 1)
  obs <- Z*exp(0.3*Z*Z/2)
  m[i] <- mean(obs, trim=0.1)
}
mean(m)
sd(m)

data <- c(2, 2, 3, 3, 3, 4, 4, 4, 100000, 100000)

mv_rule <- function(data) {
  x_bar <- mean(data)
  s <- sd(data)
  mv_outlier <- which((abs(data-x_bar)/s) > 2.24)
  return (mv_outlier)
}

# IQR---------------------------------------------------------------------------
upper <- quantile(data, 0.75)
lower <- quantile(data, 0.25)
iqr <- IQR(data)
outlier_iqr <- data[data < lower - 1.5 * iqr | data > upper + 1.5 * iqr]
# solution 2
iqr_rule <- function(data) {
  out <- boxplot(data, plot=FALSE)
  return (out$out)
}


# MAD Rule----------------------------------------------------------------------
mad_rule <- function(data) {
  outlier <- data[(abs(data-median(data))/(MAD(data)/0.6745)) > 2.24]
  return (outlier)
}


# student perf -----------------------------------------------------------------

# Q3Solution1
stud_perf <- read.csv("data/student/student-mat.csv", sep=";")
t_mean <- aggregate(G3 ~ Medu, data=stud_perf, FUN=mean, trim=0.1)
s_mean <- aggregate(G3 ~ Medu, data=stud_perf, FUN=mean)
w_mean <- aggregate(G3 ~ Medu, data=stud_perf, FUN=function(x){mean(Winsorize(x))})
all_means <- cbind(t_mean, s_mean[,2], w_mean[,2])
colnames(all_means) <- c("Medu", "Trim", "Sample", "Whinsorized")
all_means

# Q3Solution2
temp_fn <- function(x) {
  c(
    "raw"=mean(x),
    "trim"=mean(x, trim=0.1),
    "win"=mean(Winsorize(x))
  )
}
aggregate(G3 ~ Medu, data = stud_perf, FUN = temp_fn)


mv_stud <- aggregate(G3 ~ Medu, data=stud_perf, FUN=mv_rule)
iqr_stud <- aggregate(G3 ~ Medu, data=stud_perf, FUN=iqr_rule)
mad_stud <- aggregate(G3 ~ Medu, data=stud_perf, FUN=mad_rule)


return_outlier <- function(data) {
  method1 <- mv_rule(data)
  method2 <- iqr_rule(data)
  method3 <- mad_rule(data)
  list("method 1" = method1, "method 2" = method2, "method 3"= method3)
}

tapply(stud_perf$G3, stud_perf$Medu, return_outlier)



