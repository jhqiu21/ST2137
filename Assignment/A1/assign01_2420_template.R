## Do not edit lines 4 and 5 below.
## You may decide not to use readLines(), but the path to the data file must
## remain as it is:
path_to_dat <- "data/aircraft_failure.txt"
tmp <- readLines(path_to_dat, warn = FALSE)
## Do not edit the lines above.
###############################################################################

## YOUR CODE HERE:

## QUESTION 1
list = strsplit(tmp, " ")
ftimes_df <- do.call(rbind, lapply(seq_along(list), function(i) {
  data.frame(aircraft = i, failure_times = as.numeric(unlist(list[[i]])))
}))

## QUESTION 2
library(lattice)
histogram(~failure_times | aircraft, data=ftimes_df,
          layout = c(5, 2),
          as.table=TRUE,
          main = "Failure Times Distribution by Aircraft",
          xlab = "Failure Times",
          ylab = "Frequency")

## QUESTION 3
mom_gamma <- function(data) {
  xbar = mean(data)
  sx2 = var(data)
  alpha_hat = (xbar^2) / sx2
  beta_hat = sx2 / xbar
  return (list(alpha = alpha_hat, beta = beta_hat))
}

ac1 <- ftimes_df$failure_times[ftimes_df$aircraft == 1]
mom_gamma(ac1)

## QUESTION 4
ac_vec <- numeric(10)
for (i in 1:10) {
  x <- ftimes_df$failure_times[ftimes_df$aircraft == i]
  if (length(x) > 1) {
    ac_vec[i] <- cor(x[-length(x)], x[-1])
  } else {
    ac_vec[i] <- NULL
  }
}
ac_vec








