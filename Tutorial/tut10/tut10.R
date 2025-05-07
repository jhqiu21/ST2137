crab <- read.table("data/crab.txt", header=TRUE)
# two version
m1 <- lm(weight ~ width * as.factor(spine), data=crab)
m1 <- lm(weight ~ width + as.factor(spine) + width:as.factor(spine), data=crab)
summary_out <- summary(m1)

# important
summary_out$coefficients[1,4] # p-value of beta 0
summary_out$coefficients[5,1] # p-value of beta 4
sum(summary_out$residuals^2)  # residual sum of square
summary_out$sigma^2
summary_out$adj.r.squared

new_data <- data.frame(width = 27, spine = factor(1, levels=c(1,2,3)))
predict(m1, newdata = new_data)

library(lattice)
library(MASS)
cars2 <- Cars93[Cars93$Cylinders != "rotary",]
boxplot(MPG.city ~ Cylinders, data=cars2)
bwplot(MPG.city ~ Cylinders, data=cars2)

anova_cars <- aov(MPG.city ~ Cylinders, data=cars2)
summary(anova_cars)
# There is a statistically significant difference in MPG.city across the different cylinder groups.

cars2$Cylinders <- as.integer(cars2$Cylinders)
model <- lm(MPG.city ~ Cylinders, data=cars2)
summary(model)

pop <- read.csv("data/sg_population.csv")
plot(pop$Data.Series, pop$Total.Population)

model <- lm(log(7e6/Total.Population - 1) ~ Data.Series, data=pop)
summary_out <- summary(model)
a <- exp(summary_out$coefficients[1,1])
b <- -summary_out$coefficients[2,1]
new.point <- data.frame(Data.Series = c(2024:2050))
predict.val <- predict(model, newdata=new.point, interval="conf")
pop.val <- 7e6 / (exp(predict.val) + 1)
plot(pop$Data.Series, pop$Total.Population, 
     xlim=c(1950, 2050), ylim=c(1e06, 7.5e06))
lines(new.point$Data.Series, pop.val[,1], col="red")
lines(new.point$Data.Series, pop.val[,2], col="red", lty=2)
lines(new.point$Data.Series, pop.val[,3], col="red", lty=2)







