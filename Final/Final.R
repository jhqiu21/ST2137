setwd("~/Desktop/ST2137/src")
library(lattice)
library(DescTools)
stud_perf <- read.csv("data/student/student-mat.csv", sep=';')
taiwan <- read.csv("data/taiwan_dataset.csv")
head(stud_perf)


# Question 9

x <- matrix(c(1,3,10,6,2,3,10,7,1,6,14,12,0,1,9,11), ncol=4, byrow=TRUE)
dimnames(x) <- list(c("a", "b", "c", "d"), c("e", "f", "g", "h"))
tab <- as.table(x)
output <- Desc(x, plotit=FALSE, verbose=3)
output[1]$associations[1,3]
output[[1]][['assocs']][3,1]
output[[1]]$associations[3,1]
output[1][['assocs']][1,3]


# Question 10
concrete <- read.csv("data/concrete+slump+test/slump_test.data")
names(concrete)[c(1,11)] <- c("id", "Comp.Strength") 
model <- lm(Comp.Strength ~ Cement + Slag + Fly.ash + Water + SP + Coarse.Aggr., data=concrete)
summary(model)
# Adjusted R-squared:  0.8883 

r_s0 = rstandard(model)
plot(x=concrete$Fine.Aggr., r_s0)
# Here we try to plot residual plot against the new variable, it did not show a Linear trend
# which indicate it may be not statistically significant enough
# By trying to include this variable in the model, we can see the p-value of it from summary
# which is > 0.05, indicating that Fine.Aggr. is not significant in the model, which is redundant
model2 <- lm(Comp.Strength ~ Cement + Slag + Fly.ash + Water + SP + Coarse.Aggr. + Fine.Aggr., data=concrete)
summary(model2)


infl <- influence.measures(model)
summary(infl)
which(apply(infl$is.inf, 1, any))
# Three most influential points is 8,14,49
u = 8
v = 14
w = 49

water <- concrete[c(u, v, w), 'Water']
ecdf(water)

bike2 <- read.csv("data/bike2.csv")
weathersit <- bike2$weathersit
mnth <- as.factor(bike2$mnth)
boxplot(weathersit ~ mnth)
xyplot(weathersit | mnth, as.table=TRUE, data=bike2, layout=c(4,3))


pairs(bike2[, weathersit], panel = panel.smooth)


hist(table(weathersit, mnth))

fisher.test(table(weathersit, mnth)) 
tab <- table(weathersit, mnth)
Desc(tab, plotit = FALSE, verbose = 3)

barchart(tab, horizontal = FALSE, stack = FALSE, auto.key=TRUE)

