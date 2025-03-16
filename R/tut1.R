setwd("~/Desktop/ST2137/src")
data = read.csv("data/phones-2420.csv")
df1 <- data.frame(x=phones$year, y=phones$calls)
head(df1)
write.csv(df1, file="data/phones-2420.csv", row.names = FALSE)
NROW(df)

X = matrix(c(rep(1,24), df1$x), nrow = 24)
y = matrix(df1$y, nrow=24)
y
beta_hat=solve(t(X)%*%X)%*%t(X)%*%y
beta_hat
y_hat=X%*%solve(t(X)%*%X)%*%t(X)%*%y
y_hat

lm_output <- lm(y ~ x, data=df1)
lm_output

all_combn <- combn(24, 2)
all_combn
slope <- rep(0.0, 276)
for (i in 1:276) {
  y_vec <- df1$y[all_combn[,i]]
  x_vec <- df1$x[all_combn[,i]]
  slope[i] <- (y_vec[2] - y_vec[1]) / (x_vec[2] - x_vec[1])
}
slope_hat <- median(slope)
slope_hat
fit_intercept <- median(df1$y) - slope_hat * median(df1$x)
plot(x=phones$year, y=phones$calls, col="red", cex=1.2,
     xlab="Year", ylab="Calls (millions)")
abline(lm_output, col="blue")
abline(a=fit_intercept, b=fit_slope, col="green", lty=2)



library(jsonlite)
corrected_data <- read_json("data/phones.json", TRUE)
matched_rows <- match(corrected_data$year, df1$x)
df1$y[matched_rows] <- corrected_data$corrected_calls
df1
