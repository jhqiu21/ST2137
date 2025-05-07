# R Regression

- [Analysis of Model](#analysis-of-model)
- [Plot CI](#confidence-interval)
- [Residual Analysis](#residual-analysis)
- [Influential Points](#influential-points)


### Regression Model $Y\sim X_1 + X_2 + X_1X_2$
```R
M <- lm(y ~ x1 + x2 + x1 * x2, data = ...)
M <- lm(y ~ x1 + x2 + x1 : x2, data = ...)
```

Interpretation of Coefficients:

$$y_1 = \beta_0 + \beta_1 X_1 + \beta_2 I(X_2 = 1)$$

- For any fixed $X_2$, when $X_1$ increases by 1 unit, the $y$ will increase by $\beta_1$ unit

- For any fixed $X_1$, the $y$ of type 1 ($X_2=1$) is $\beta_2$ more than the one of type 0 ($X_2=0$)

$$y_2 = \beta_0 + \beta_1 X_1 + \beta_2 I(X_2 = 1) + \beta_3 X_1 \times I(X_2 = 1)$$

- For type 1 ($X_2=1$) when $X_1$ increases by 1 unit, $y$ will increase by ($\beta_1 + \beta_3$) unit. For type 0 ($X_2=0$) when $X_1$ increases by 1 unit, $y$ will increase by $\beta_1 unit.


Plot $Y\sim X1+X2$ where $X2$ is categorical variable
```R
bike2 <- read.csv("data/bike2.csv")
lm_reg_casual <- lm(registered ~ casual, data = bike2)
lm_reg_casual2 <- lm(registered ~ casual + workingday, data = bike2)
```
```R
plot(x=bike2$casual, y=bike2$registered, 
     col=ifelse(bike2$workingday == "yes", "salmon", "deepskyblue4"), #yes is red point, no is blue point
     main="Comparing fitted models", cex=0.8,
     xlab="Casual", ylab="Registered")
abline(lm_reg_casual, col="deepskyblue4", lty=2) # plot Y~X1 regression line
est_coef <- coef(lm_reg_casual2)
abline(est_coef[1], est_coef[2], col="deepskyblue4") # plot regression line of Y in non-workingday
abline(est_coef[1]+est_coef[3], est_coef[2], col="salmon") # plot regression line of Y in workingday
legend("bottomright", legend=c("lm_reg_casual", "lm_reg_causal2"), lty=c(1,2), cex=0.7)  # add legend
```


### Transformation of Response
```R
M1 <- lm(log(y) ~ x, data = ...)
M2 <- lm(sqrt(y) ~ x, data = ...)
```

### Analysis of Model

```R
concrete <- read.csv("data/concrete+slump+test/slump_test.data")
names(concrete)[c(1,11)] <- c("id", "Comp.Strength")
model <- lm(FLOW.cm. ~ Water, data=concrete)
```
**Explain Significance**
- t-test has test statistic t = XX which has null distribution of t(df, find in residual), and p-value of the test is then < 0.001.
- With a very small p-value, the data provide very strong evidence that (X/Model/..) is significant.
```R
summary(model)
```
- $R^2$: Model can explain XX% of the variation in the observed response 
```R
summary_out <- summary(model)
summary_out$r.squared
summary_out$adj.r.squared
```
```R
unname(coef(lm_sg_pop)) # coefficients estimates without column name
summary_out$coefficients[1,4] # p-value of beta 0
summary_out$coefficients[5,1] # p-value of beta 4
sum(summary_out$residuals^2) / df  # residual sum of square, df get from F test
summary_out$sigma^2
```

```R
anova(model)
```

#### Confidence Interval
```R
confint(model, level=.95)
confint(model, "Water", level=.95) # ci of target variable
```
**Plot Regression Line and CI**
```R
plot(concrete$Water, concrete$FLOW.cm., ylim=c(0, 100),
     xlab="Water", ylab="Flow", main="Confidence and Prediction Intervals")
abline(model, col="red")
```
1. [Use model to predicat](#use-model-to-predict) a set of points
2. Get the CI from `conf_intervals` and plot
```R
lines(new_df$Water, conf_intervals[,"lwr"], col="red", lty=2) # plot lower hand side
lines(new_df$Water, conf_intervals[,"upr"], col="red", lty=2) # plot upper hand side
legend("bottomright", legend=c("Fitted line", "Lower/Upper CI"), lty=c(1,2), col="red")
```

### Use Model to Predict
```R
new_df <- data.frame(Water = seq(160, 240, by = 5))
predict.value <- predict(model, new_df)
conf_intervals <- predict(model, new_df, interval="conf")
```

### Residual Analysis

```R
raw.res = M3$res     # raw residuals
SR = rstandard((M1)) # standard residuals
```

#### Histogram of SR
```R
hist(SR, breaks=20)
```
#### QQ plot of SR
- Both tails are longer/shorter than normal distributionand 
- SR follows normal districbution
- Model follows/violate normality assumption
```R
qqnorm(SR)
qqline(SR)
```
```R
qqnorm(SR,datax = TRUE, ylab = "Standardized Residuals of Model", 
       xlab = "Z scores", main = "QQ Plot", pch = 20)
qqline(SR,datax = TRUE, col = "red")
```
#### Hypothesis Test for SR
Check if SR normal distributed, either of below holds p < 0.05 indicate **Not Normal**
```R
shapiro.test(SR)
```
```R
ks.test(SR, "pnorm")
```
### SR vs Fitted Response

The plot of SR versus the fitted response shows the randomness of the SR within the range of -3 to 3 with no pattern nor trend.
```R
plot(M1$fitted.values, SR, xlab = "Fitted response", 
     ylab = "Standardized Residuals", main = "SR vs Fitted Response", pch = 20)
abline(h = 0, col = "red")
```
```R
opar <- par(mfrow=c(1,3))
plot(x=fitted(lm_flow_water_slag), r_s, main="Fitted")
```
```R
plot(x=concrete$Water, r_s, main="X1")
plot(x=concrete$Slag, r_s, main="X2")
```

### Raw Residual Plot
```R
plot(fitted(M1), raw.res)
abline(0,0, col='red')
```

### Outliers

```R
which(SR < -3 | SR > 3) # index of outliers
```
We may try to drop the influential point (87th point) and fit the model again to see how the coefficients change.

### Influential Points
```R
infl <- influence.measures(model)
summary(infl)
which(apply(infl$is.inf, 1, any))
```