stud_perf <- read.csv("data/student/student-mat.csv", sep=";")
# Generate summary statistics for G1 scores, conditioned on Medu.
aggregate(G1 ~ Medu, data=stud_perf, FUN=summary)
opar <- par(mfrow=c(1,2))
bwplot(G1 ~ Medu, horizontal = FALSE, data=stud_perf)
bwplot(G3 ~ Medu, horizontal = FALSE, data=stud_perf)
par(opar)

# famrel and goout 
tab1 <- table(stud_perf$famrel, stud_perf$goout)
chisq.test(tab1)
# warning


# odd ratios between variables nursery and higher.
library(DescTools)
tab <- table(stud_perf$nursery, stud_perf$higher)
output <- OddsRatio(tab, conf.level = .90)
output[1] # -> odds ratio
output[2] # -> lwr.ci
output[-1] # -> lwr.ci upr.ci 
cat("The 90% confidence interval is (", output[2], ", ", output[3], ")")

# 
library(lattice)
x <- matrix(c(762,327,468,484,239,477), ncol=3, byrow=TRUE)
dimnames(x) <- list(c("female", "male"), 
                    c("Dem", "Ind", "Rep"))
political_tab <- as.table(x)
chisq.test(political_tab)

# since p < 0.05 reject H0, hence two variable are not independent to each other





