setwd("~/Desktop/ST2137/src")
data <- read.csv("data/antibio.csv")
u_levels <- sort(unique(data$type))
data$type <- factor(data$type, levels=u_levels[c(2, 1, 3, 4, 5, 6)])
M1 <- lm(org ~ type, data=heifers)
anova(M1)
summary(M1)
r1 <- residuals(M1)
hist(r1)
qqnorm(r1); qqline(r1)

summary_out <- anova(M1)
est_coef <- coef(M1)
est1  <- unname(est_coef[3]) # coefficient for Enrofloxacin
MSW <- summary_out$`Mean Sq`[2]
df <- summary_out$Df[2]
q1 <- qt(0.025, df, 0, lower.tail = FALSE)

lower_ci <- est1 - q1*sqrt(MSW * (1/6 + 1/6))
upper_ci <- est1 + q1*sqrt(MSW * (1/6 + 1/6))
cat("The 95% CI for the diff. between Enrofloxacin and Control is (",
    format(lower_ci, digits = 3), ",", 
    format(upper_ci, digits = 3), ").", sep="")


c1 <- c(-1, 0.5, 0.5)
n_vals <- c(6, 6, 6)
L <- sum(c1*est_coef[3:5]) # -Enro. + 0.5 * Iver + 0.5 * Fenb

MSW <- summary_out$`Mean Sq`[2]
df <- summary_out$Df[2]
se1 <- sqrt(MSW * sum( c1^2 / n_vals ) )

q1 <- qt(0.025, df, 0, lower.tail = FALSE)

lower_ci <- L - q1*se1
upper_ci <- L + q1*se1
cat("The 95% CI for the diff. between the two groups is (",
    format(lower_ci, digits = 2), ",", 
    format(upper_ci, digits = 2), ").", sep="")
