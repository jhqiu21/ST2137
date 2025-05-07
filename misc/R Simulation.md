## R-Simulation

- [Generate RVs](#generate-observations)
- [WorkFlow](#workflow)
- [Monte-Carlo Integration](#monte-carlo-integration)
- [CI](#confidence-intervals)
- [Type I Error](#type-i-error)

### Set Random Seeds
```R
set.seed(2138)
```

### Generate Observations

- Norm(mean, sd^2): `rnorm(num, mean, sd)`
- Uniform(a,b): `runif(num, a, b)`
- Gamma(alpha, lambda): `rgamma(num, alpha, lambda)`
- Possion(lambda): `rpois(num, lambda)`
- Binominal(n,p): `rbinom(num, size=n, p)`

```R
V <- rnorm(50, 0, 10)         # 50 obs from N(0,100)
W <- runif(50, 0, 1)          # 50 obs from uniform(0,1)
X <- rgamma(50, 2, 3)         # 50 obs from Gamma(2,3)
Y <- rpois(50, 1.3)           # 50 obs from Pois(1.3)
Z <- rbinom(50, size=2, 0.3)  # 50 obs from Binom(2, 0.3)
```

### WorkFlow
- Generate RVs
- Write `oneSample()` simulation function
```R
oneSample <- function() {
  ...
  return (...)
}
```
- Repeat simulation n times
```R
samples <- sapply(rep(0, n), function(x) oneSample())
```
- Get the `mean()` and `sd()` value and construct CI
```R
X_bar <- mean(samples)
SD <- sd(samples)
z = qnorm(0.975)
upper_ci = X_bar + z * SD / sqrt(n)
lower_ci = X_bar - z * SD / sqrt(n)
cat("Confidential Interval is (", lower_ci, ",", upper_ci, ")", sep="")
```
- use `vapply()` if the function returns a vector 
```R
vapply(1:1000, function(x) generate_one_series(), c(1.0, 2.9))
```




### Monte-Carlo Integration
$$E(h(X))= \int_{-\infty}^{\infty} h(x) f(x) \text{d}x
$$
where $f(x)$ is a pdf, $X \sim f$

```R
set.seed(2138)
X <- runif(50000, 0, 1)
hX <- exp(2*X)
mc_est <- mean(hX)
```

### Confidence Intervals
$$
\bar{X} \pm t_{0.025} s/\sqrt{n}
$$
Check if it still works if the data is from an asymmetric distribution: $Pois(0.5)$.

```R
set.seed(2139)
output_vec <- rep(0, length=100)
n <- 20
lambda <- 0.5
for(i in 1:length(output_vec)) {
  X <- rpois(n, .5)
  Xbar <- mean(X)
  s <- sd(X)
  t <- qt(0.975, n-1)
  CI <- c(Xbar - t*s/sqrt(n), Xbar + t*s/sqrt(n))
  if(CI[1] < lambda & CI[2] > lambda) {
    output_vec[i] <- 1
  }
}
mean(output_vec)
```

### Type I Error

Check if we falsely reject the null hypothesis 10% of the time if we perform it at 10% significance level

```R
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
```