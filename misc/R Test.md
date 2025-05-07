## R-Test

- [Normal Assumption Check](#normal-assumption-check)
- [Parametric Independent t-Test](#t-test)
- [Parametric Pair t-Test](#pair)
- [Non-Parametric Independent t-Test](#wilcoxon-rank-sum)
- [Non-Parametric Pair t-Test](#wilcoxon-sign-test)

### Normal Assumption Check

#### Equal Variance
**Rule of Thumb:** If the larger s.d is more than twice the smaller one, than we should not use the equal variance form of the test.
```R
aggregate(viscera ~ gender, data=abl, sd)
```

#### Skewed
```R
aggregate(viscera ~ gender, data=abl, Skew, method=1)
```

#### Kurtosis
- Positive kurtosis implies that the tails are “fatter” than those of a Normal.
- Negative kurtosis indicate that the tails are “thinner” than those of a Normal.
```R
aggregate(viscera ~ gender, data=abl, Kurt, method=1)
```

#### QQ Plot for Normality
```R
library(lattice)
histogram(~viscera | gender, data=abl, type="count")
qqnorm(y, main="Female Abalones");  qqline(y)
qqnorm(x, main="Male Abalones");  qqline(x)
```

#### Hypothesis tests for Normality
$$H_0: \text{Data follows Normal Distribution}$$
$$H_0: \text{Data dose not follow Normal Distribution}$$

```R
shapiro.test(x)
```

You may use following function to check normality during exam.
```R
check_normality <- function(x) {
  res <- shapiro.test(x)
  if (res$p.value < 0.05) {
    print("Data dose NOT follow normal distribution")
  } else {
    print("Data follows normal distribution") 
  }
}
check_normality(x)
```

### Parametric Tests
#### t-Test
Assumes that the data originate from a **Normal distribution**.
- $H_0: \mu_X = \mu_Y$ / The population means of the two groups are equal.
- $H_1: \mu_X \neq \mu_Y$ / The population means of the two groups are not equal.
```R
data <- read.csv("data/abalone_sub.csv")
x <- data$viscera[data$gender == "M"]
y <- data$viscera[data$gender == "F"]

t.test(x, y, var.equal=TRUE)
```

#### Pair

- $D_i = X_i - Y_i$
- $H_0: \mu_D = 0$ / The mean difference between the paired observations is zero.
- $H_1: \mu_D \neq 0$ / The mean difference between the paired observations is not zero.

```R
data <- read.csv("data/health_promo_hr.csv")
before <- data$baseline
after <- data$after5
t.test(before, after, paired=TRUE)
```

### Non-parametric Tests

If the distributional assumptions of the t-test are not met

#### Wilcoxon Rank Sum
- Independent 2-sample test
- Both $n_1$ and $n_2$ are at least 10
- Observations (not the ranks) come from an underlying **continuous distribution**

$H_0:$ The distribution of group 1 is in same location of the distribution of group 2.

$H_1:$ The distribution of group 1 is a location shift of the distribution of group 2.

```R
wilcox.test(x, y)
```

#### Wilcoxon Sign Test

- Paired Samples Test
- If the number of non-zero $D_i$ ’s is at least 16, then the test statistic $W$ follows a $N(0,1)$ distribution approximately.
- $D_i = X_i - Y_i$

- $H_0: \text{median of } D_i = 0$ / The median of the differences between the paired observations is zero.
- $H_1: \text{median of } D_i \neq 0$ / The median of the differences between the paired observations is not zero.
- `exact` version of the test cannot be used when there are ties. i.e. There exist 0 in $D$.
```R
exact_check <- function(x, y) {
  len <- length(which((x-y)==0))
  if (len == 0) {
    print("The exact parameter should set to be FALSE")
  } else {
    print("The exact parameter should set to be TRUE or Omit")
  }
}
```
```R
wilcox.test(before, after, paired = TRUE, exact = FALSE)
```
- If all data are non-zero
```R
wilcox.test(D,alternative = "greater")
```


## ANOVA

- [Dot Plot](#dot-plot)
- [One-Way](#one-way-analysis-of-variance)
- [Comparing Specific Groups](#comparing-specific-groups)
- [General Comparison of Groups](#general-comparison-of-groups)
- [Bonferroni Correction](#bonferroni-correction)
- [Multiple Comparisons](#multiple-comparisons)

### Dot Plot
```R
locate_df <- read.table("data/locate.txt", header=TRUE)
locate_df$location <- factor(locate_df$location, levels=c("R", "M", "F"))
dotplot(sales ~ location, data = locate_df, cex=1.2, main="Sales by Aisle Location")
```

### One-Way Analysis of Variance

- Set the reference level to be type A $\Leftrightarrow$ The coefficient of type A is zero in the model. 

```R
data <- read.csv("data/antibio.csv")
u_levels <- sort(unique(data$type))
data$type <- factor(data$type, levels=u_levels[c(2, 1, 3, 4, 5, 6)])
```
```R
M1 <- lm(org ~ type, data=heifers)
anova(M1)
```
```R
anova_model <- aov(org ~ type, data)
summary(anova_model)
```


Check ANOVA Assumptions
- The observations are **independent** of each other.
- The **errors** are Normally distributed.
- The variance within each group is the same.



```R
r1 <- residuals(M1)
hist(r1)
qqnorm(r1); qqline(r1)
shapiro.test(r1)
```

### Comparing specific groups

```R
est_coef <- coef(M1)  # coefficients of linear model
est1  <- unname(est_coef[3])  # coefficients without column name
```
Construct 95% Confidence Interval 
$$SE=\sqrt{MS_W \left( \frac{1}{n_{i_1}} + \frac{1}{n_{i_2}} \right) }$$
$$100(1- \alpha)\%-\text{CI} = (\overline{Y_{i_1}} - \overline{Y_{i_2}}) \pm t_{n-k, \alpha/2}  \times SE$$
```R
summary_out <- anova(M1)
MSW <- summary_out$`Mean Sq`[2]
df <- summary_out$Df[2]
q1 <- qt(0.025, df, 0, lower.tail = FALSE)

lower_ci <- est1 - q1*sqrt(MSW * (1/6 + 1/6))
upper_ci <- est1 + q1*sqrt(MSW * (1/6 + 1/6))

cat("The 95% CI for the diff. between Enrofloxacin and Control is (",
    format(lower_ci, digits = 3), ",", 
    format(upper_ci, digits = 3), ").", sep="")
```

### General Comparison of Groups
Comparison of a collection of $l_1$ groups with another collection of $l_2$ groups

1. Compute the estimate of the contrast:
$$ L = \sum_{i=1}^k c_i \overline{Y_i} \text{ where } \sum_{i=1}^k c_i=0$$
2. Compute the standard error of the above estimator:
$$ SE = \sqrt{MS_W \sum_{i=1}^k \frac{c_i^2}{n_i} } $$
3. Compute the $100(1- \alpha)%$ confidence interval as:
$$ L \pm t_{n-k, \alpha/2}  \times SE $$

```R
c1 <- c(-1, 0.5, 0.5)  # weight vector
n_vals <- c(6, 6, 6)  # number of observations in each group
MSW <- summary_out$`Mean Sq`[2]
df <- summary_out$Df[2]

L <- sum(c1*est_coef[3:5])  # construct estimate L
se1 <- sqrt(MSW * sum( c1^2 / n_vals ))  # compute SE
q1 <- qt(0.025, df, 0, lower.tail = FALSE)

lower_ci <- L - q1*se1
upper_ci <- L + q1*se1

cat("The 95% CI for the diff. between the two groups is (",
    format(lower_ci, digits = 2), ",", 
    format(upper_ci, digits = 2), ").", sep="")
```

### Bonferroni Correction

Set confidential level to be $(1 - \alpha / m)$
```R
anova_mod <- lm(sales ~ location, data=locate_df)
confint(anova_mod, level = 1-0.05/2)
```



### Multiple Comparisons
#### TukeyHSD

- Correcting for multiple comparisons
- Construct confidence intervals for **all** pairwise comparisons
- **Shorter** confidence intervals than a Bonferroni correction for all pairwise comparisons.

$$H_0: \mu_X = \mu_Y$$

```R
TukeyHSD(aov(M1), ordered = TRUE)
```

#### Kruskal-Wallis Procedure

- If the assumptions of the ANOVA procedure are not met
- Generalisation of the Wilcoxon Rank-Sum test for 2 independent samples.
- This test should only be used if $n_i \geq 5$ for all groups.

$H_0:$ All groups follow the same distribution

$H_1:$ At least one of the groups’ distribution differs from another by a location shift.

```R
kruskal.test(heifers$org, heifers$type)
```

