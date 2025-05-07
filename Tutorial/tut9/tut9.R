locate <- read.table("data/locate.txt", header = TRUE)
library(lattice)
locate$location <- factor(locate$location, levels=c("R", "M", "F"))
dotplot(sales ~ location, locate)
model <- lm(sales ~ location, data=locate)
anova(model)

confint(model, level = 0.95)
# Bonferroni: maintain a level at m test, each test should be a/m level
confint(model, level = 1 - 0.05 / 2)


stud_perf <- read.table("data/student/student-mat.csv", sep=";",header=TRUE)
stud_perf2 <- stud_perf[stud_perf$Medu!=0,]
stud_perf2$Medu <- as.factor(stud_perf2$Medu)

remove_outliers <- function(x) {
  idx <- which(abs(x-median(x)) / mad(x) > 2.24)
  x[-idx] # remove idx row
}
tmp <- vector(mode = 'list', 4)
for (ii in 1:4) {
  tmp[[ii]] <- remove_outliers(stud_perf$G3[stud_perf$Medu == ii])
}
lens <- vapply(tmp, length, 2L)
stud_perf3 <- data.frame(G3 = unlist(tmp), Medu = as.factor(rep(1:4, times=lens)))
                         
lm_outliers_rm <- lm(G3 ~ Medu, data=stud_perf3)
anova(lm_outliers_rm)


c1 <- c(-1/3, -1/3, -1/3, 1)
lens
n_vals <- c(50, 87, 90, 125)
est_coef <- coef(lm_outliers_rm)
L <- sum(c1*c(0, est_coef[2:4]))
summary_out <- anova(lm_outliers_rm)
df <- summary_out$Df[2]
MSW <- summary_out$`Mean Sq`[2]
se1 <- sqrt(MSW * sum( c1^2 / n_vals ))
q1 <- qt(0.025, df, 0, lower.tail = FALSE)

lower_ci <- L - q1*se1
upper_ci <- L + q1*se1

cat("The 95% CI for the diff. between the two groups is (",
    format(lower_ci, digits = 2), ",", 
    format(upper_ci, digits = 2), ").", sep="")


# multiple comparison
TukeyHSD(aov(lm_outliers_rm), ordered = TRUE)
# pair (4,1), (4,2) are different

lm_model <- lm(G3 ~ Medu, data=stud_perf2)
TukeyHSD(aov(lm_model), ordered = TRUE)




