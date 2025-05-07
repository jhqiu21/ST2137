## Do not edit the following line:
leuk <- read.csv("data/leuk_surv_times.csv")
## Do not edit the line above.
## When I source your script, it should run without errors.
## Remember to clear your workspace and run your script once before submitting.
###############################################################################

## YOUR CODE HERE:
library(lattice)
# Question 1
df <- data.frame(leuk)
df$w <- df$logWBC - mean(df$logWBC)
df$lnY <- log(df$surv_time)
# Question 2
model <- lm(lnY ~ w, data=df)
summary_out <- summary(model)
model_1_r2 <- c(summary_out$adj.r.squared)
# Question 3
res <- influence.measures(model, infl = influence(model))$is.inf[,'dfb.w']
df$outlier <- ifelse(res==TRUE, 1, 0)
# Question 4
model2 <- lm(lnY ~ w + as.factor(outlier), data=df)
summary_out2 <- summary(model2)
model_2_r2 <- c(summary_out2$adj.r.squared)
# Question 5
plot(df$logWBC, df$surv_time, ylim=c(0, 150),
     xlab="logWBC", ylab="Survival time", main="80% confidence intervals")
x_seq <- seq(min(df$logWBC), max(df$logWBC), length.out = 100)
w_seq <- x_seq - mean(df$logWBC)
new.points <- data.frame( w = w_seq, outlier = factor(0, levels = c(0, 1)))
pred <- predict(model2, newdata = new.points, interval = "confidence", level = 0.8)
lines(x_seq, exp(pred[, "fit"]), col = "blue", lty = 2)
lines(x_seq, exp(pred[, "lwr"]), col = "red", lty = 2)
lines(x_seq, exp(pred[, "upr"]), col = "red", lty = 2)

