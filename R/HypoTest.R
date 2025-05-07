# Paramatric Test

# Independent Samples Test
abl <- read.csv("data/abalone_sub.csv")
x <- abl$viscera[abl$gender == "M"]
y <- abl$viscera[abl$gender == "F"]

t.test(x, y, var.equal=TRUE)

# Plot histogram and QQ plot to test normality
library(lattice)
histogram(~viscera | gender, data=abl, type="count")
qqnorm(y, main="Female Abalones");  qqline(y)
qqnorm(x, main="Male Abalones");  qqline(x)

# Compare sd using Rule of Thumb
aggregate(viscera ~ gender, data=abl, sd)

# Hypothesis tests for Normality
shapiro.test(x)


check_normality <- function(x) {
  res <- shapiro.test(x)
  if (res$p.value < 0.05) {
    print("Data dose NOT follow normal distribution")
  } else {
    print("Data follows normal distribution") 
  }
}
check_normality(x)

# Pair hypo test
data <- read.csv("data/health_promo_hr.csv")
before <- data$baseline
after <- data$after5
t.test(before, after, paired=TRUE)

# Non parametric test
wilcox.test(x, y)
wilcox.test(before, after, paired = TRUE, exact = FALSE)
