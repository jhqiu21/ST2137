# Question 1
set.seed(2137)
x <- runif(1000, 0, 1)
X <- exp(x^2)
mean(X)
z <- qnorm(0.975)
lower <- mean(X) - z * sd(X) / sqrt(1000)
upper <- mean(X) + z * sd(X) / sqrt(1000)
cat("95%-CI is (", lower, ",", upper, ")", sep="")
integrate(function(x) exp(x^2), 0, 1)
# Question 2
set.seed(2138)
oneSampleN <- function() {
  N <- 0
  sum <- 0
  while(sum <= 1) {
    N <- N+1
    sum <- sum + runif(1)
  }
  N
}
N <- 1000
sample <- sapply(1:N, function(x) oneSampleN())
sample_mean <- mean(sample)
z <- qnorm(0.975)
upper <- sample_mean + z * sd(sample) / sqrt(N)
lower <- sample_mean - z * sd(sample) / sqrt(N)
cat("95%-CI is (", lower, ",", upper, ")", sep="")

# Question 3
set.seed(100)
test_result <- function(n) {
  X <- rnorm(n, 0, 1)
  Y <- rnorm(n, 1.5, 1)
  p.value <- t.test(X, Y)$p.value
  if (p.value < 0.05) {
    return (1)
  } else {
    return (0)
  }
}

simulate <- function(x) {
  obs <- sapply(rep(x, 1000), function(x) test_result(x))
  mean(obs)
}

sample <- sapply(c(5:10), function(x) simulate(x))
plot(5:10, sample)
abline(h=0.8, col = "blue")

# Question 4
generate_one_game <- function() {
  X <- rnorm(1, 115.8, 11.2)
  Y <- rnorm(1, 109.5 + 0.7 * (10.6 / 11.2) * (X - 115.8), (1-0.7^2) * 10.6^2)
  if (X > Y) {
    return("denver")
  } else {
    return("miami")
  }
}
generate_one_series <- function() {
  sum_d <- 0
  sum_m <- 0
  while ((sum_d < 4) && (sum_m < 4)) {
    game_output <- generate_one_game()
    if(game_output == "denver") {
      sum_d <- sum_d + 1
    } else {
      sum_m <- sum_m + 1
    }
  }
  series_winner <- ifelse(sum_d > sum_m, 1, 0)
  n_games <- sum_d + sum_m
  output_vec <- c(series_winner, n_games)
  names(output_vec) <- c("series_winner", "n_games")
  output_vec
}

set.seed(2345)
t(vapply(1:1000, function(x) generate_one_series(), c(1.0, 2.9)))






















