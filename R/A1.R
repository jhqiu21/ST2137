data <- readLines("~/Desktop/ST2137/Assignment/A1/data/aircraft_failure.txt")
l <- strsplit(data, " ")
aircraft <- c()
failure_times <- c()
for (i in 1:10) {
  aircraft <- append(aircraft, rep(i, length(l[[i]])))
  failure_times <- append(failure_times, as.integer(l[[i]]))
}
df <- data.frame('aircraft'=aircraft, 'failure_times' = failure_times)

histogram(~failure_times | aircraft, data=df, as.table=TRUE, xlab='failure_times',
          ylab = 'Percent of Total', main='Histograms for Each Aircraft')

mom_gamma <- function(data) {
  x_bar <- mean(data)
  x_sq_bar <- mean(data^2)
  var <- x_sq_bar - x_bar^2
  beta <- var / x_bar
  alpha <- x_bar^2 / var
  return (c("alpha"=alpha, "beta"=beta))
}

ac1 <- df$failure_times[df$aircraft == 1]
mom_gamma(ac1)

auto_corr <- function(data) {
  head <- data[1:length(data)-1]
  tail <- data[2:length(data)]
  corr <- cor(head, tail)
  return (corr)
}

ac_vec <- c()
for (i in 1:10) {
  corr <- auto_corr(df$failure_times[df$aircraft==i])
  ac_vec[i] = corr
}










