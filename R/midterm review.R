setwd("~/Desktop/ST2137/src")
library(lattice)
library(psych)
library(DescTools)

stud_perf <- read.table("data/student/student-mat.csv", 
                        sep=";", 
                        header=TRUE)
concrete <- read.csv("data/concrete+slump+test/slump_test.data")
names(concrete)[c(1,11)] <- c("id", "Comp.Strength")

data_path <- file.path("data", "heart+failure+clinical+records", 
                       "heart_failure_clinical_records_dataset.csv")
heart_failure <- read.csv(data_path)

sum(is.na(stud_perf$G3))
round(aggregate(G3 ~ Medu, data = stud_perf, FUN=summary), 2)
table(stud_perf$Medu)

hist(stud_perf$G3)
histogram(~G3 | Medu, data=stud_perf, type="density", as.table=TRUE)

densityplot(~G3, groups=Medu, data=stud_perf, auto.key = TRUE, bw = 1.5)

bwplot(G3 ~ goout, horizontal = FALSE, data=stud_perf)

qqnorm(concrete$Comp.Strength)
qqline(concrete$Comp.Strength)

col_to_use <- c("Cement", "Slag", "Comp.Strength", 
                "Water", "SLUMP.cm.", "FLOW.cm.")
pairs(concrete[, col_to_use], panel = panel.smooth)

corPlot(cor(concrete[, col_to_use]), cex=0.8, show.legend=FALSE)

# continuency table
x <- matrix(c(762,327,468,484,239,477), ncol=3, byrow=TRUE)
dimnames(x) <- list(c("female", "male"), 
                    c("Dem", "Ind", "Rep"))
political_tab <- as.table(x)
barchart(political_tab/rowSums(political_tab), 
         horizontal = FALSE, auto.key=TRUE)

spineplot(as.factor(DEATH_EVENT) ~ age, data=heart_failure)
cdplot(as.factor(DEATH_EVENT) ~ age, data = heart_failure)
mosaicplot(political_tab, shade=TRUE)
# chi-square test
x <- matrix(c(46, 37, 474, 516), nrow=2)
dimnames(x) <- list(c("male", "female"), c("pain", "no pain"))
chest_tab <- as.table(x)
"""
       pain  no pain
male     46     474
female   37     516

"""
chisq_output <- chisq.test(chest_tab)
chisq_output
chisq_output$expected
chisq_output$stdres

y <-  matrix(c(3, 1, 1, 3), nrow=2)
dimnames(y) <- list(c("claritin", "placebo"), c("nervous", "not nervous"))
claritin_tab <- as.table(y)
fisher.test(claritin_tab)
# chisq.test(claritin_tab) is incorrect

OddsRatio(chest_tab, conf.level = .95)

x <- matrix(c(1, 3, 10, 6,
              2, 3, 10, 7,
              1, 6, 14, 12,
              0, 1,  9, 11), ncol=4, byrow=TRUE)
dimnames(x) <- list(c("<15,000", "15,000-25,000", "25,000-40,000", ">40,000"), 
                    c("Very Dissat.", "Little Dissat.", "Mod. Sat.", 
                      "Very Sat."))
us_svy_tab <- as.table(x)

output <- Desc(x, plotit = FALSE, verbose = 3)
output[[1]]$assocs

#robust stats
library("MASS")
hist(chem, breaks = 20)
mean(chem)
mean(chem, trim=0.1)
vals <- quantile(chem, probs=c(0.05, 0.95))
win_sample <- Winsorize(chem, vals)
mean(win_sample)
sd(chem)
mad(chem)/0.6745
IQR(chem)/1.35










