
concrete <- read.csv("data/concrete+slump+test/slump_test.data")
names(concrete)[c(1,11)] <- c("id", "Comp.Strength")
model <- lm(FLOW.cm. ~ Water, data=concrete)
summary(model)
anova(model)
confint(model, level=.95)
confint(model, "Water", level=.95) # ci of target variable

new_df <- data.frame(Water = seq(160, 240, by = 5))
predict.value <- predict(model, new_df)
conf_intervals <- predict(model, new_df, interval="conf")

plot(concrete$Water, concrete$FLOW.cm., ylim=c(0, 100),
     xlab="Water", ylab="Flow", main="Confidence and Prediction Intervals")
abline(model, col="red")
lines(new_df$Water, conf_intervals[,"lwr"], col="red", lty=2)
lines(new_df$Water, conf_intervals[,"upr"], col="red", lty=2)
legend("bottomright", legend=c("Fitted line", "Lower/Upper CI"), 
       lty=c(1,2), col="red")


bike2 <- read.csv("data/bike2.csv")
lm_reg_casual <- lm(registered ~ casual, data = bike2)
lm_reg_casual2 <- lm(registered ~ casual + workingday, data = bike2)
plot(x=bike2$casual, y=bike2$registered, 
     col=ifelse(bike2$workingday == "yes", "salmon", "deepskyblue4"),
     main="Comparing fitted models", cex=0.8,
     xlab="Casual", ylab="Registered")
abline(lm_reg_casual, col="deepskyblue4", lty=2)
est_coef <- coef(lm_reg_casual2)
abline(est_coef[1], est_coef[2], col="deepskyblue4")
abline(est_coef[1]+est_coef[3], est_coef[2], col="salmon")
legend("bottomright", legend=c("lm_reg_casual", "lm_reg_causal2"),
       lty=c(1,2), cex=0.7)

r_s = rstandard(model)
opar <- par(mfrow=c(1,3))
plot(x=fitted(model), r_s, main="Fitted")
plot(x=concrete$Water, r_s, main="X1")
plot(x=concrete$Slag, r_s, main="X2")
par(opar)


C = cooks.distance(model)  
which(C > 1)


infl <- influence.measures(model)
summary(infl)
which(apply(infl$is.inf, 1, any))
