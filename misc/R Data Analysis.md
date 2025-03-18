# Plotting

**Quantitative Data**

- [Numerical](#numerical)
- [Histogram](#histogram)
- [Density Plot](#density)
- [Box Plot](#box)
- [QQ Plot](#qq-plot) (Quantile-Quantile plot)
- [Scatterplot Matrices](#scatterplot-matrices)
- [Correlation Plot](#correlation-plot)

**Categorical Data**

- [Continuency Table](#continuency-table)
- [Bar Chart](#bar-chart)
- [Conditional Density Plots](#conditional-density-plots)
- [Chi Square Test](#chi-square-test)
- [Fish Test](#fisher-test)

**Robust Statistics**
- [Robust](#robust)


## Numerical
```R
summary(df$x)    # -> numerical summary
sum(is.na(df$x)) # -> number of N.A in x column
```
### `aggregate(var ~ groupby_var, data, FUN=function_to_apply)`
```R
aggregate(G3 ~ Medu, data=stud_pref, FUN=summary)
```
### `table(df$x)`
```R
table(stud_perf$G3)
```

## Histogram

```R
hist(stud_perf$G3)
```
- Response variable: `G3` - quantitative
- Explanatory variable: `Medu` - ordinal
```R
histogram(~G3 | Medu, data=stud_perf, type="density", as.table=TRUE)

histogram(~G3 | Medu, data=stud_perf, type="count", as.table=TRUE, 
                      xlab='Medu', ylab='G3 Count', main='Histogram')
```

## Density
```R
densityplot(~G3, groups=Medu, data=stud_perf, auto.key = TRUE, bw = 1.5)
```
- `auto.key`: Generate legend to distinct different groups
- `bw`: brandwidth of the kernel density, $\uparrow \Rightarrow$ more fluent 

## Box

### `bwplot()`
- Y: Response variable - `G3`
- X: Explanatory variable - `goout`
```R
bwplot(G3 ~ goout, horizontal = FALSE, data=stud_perf)
```

### `boxplot()`
```R
res <- boxplot(G3 ~ goout, horizontal = FALSE, data=stud_perf)
res$out # -> outliers
```

## QQ-Plot
```R
qqnorm(concrete$Comp.Strength)
qqline(concrete$Comp.Strength)
```

## Scatterplot-Matrices
```R
col_to_use <- c("G1", "G2", "G3")
pairs(stud_perf[, col_to_use], panel = panel.smooth)
```

## Correlation-Plot
```R
library(psych)
col_to_use <- c("G1", "G2", "G3")
corPlot(cor(df[, col_to_use]), cex=0.8, show.legend = FALSE)
```

## Continuency-Table

### Create Mannually
```R
x <- matrix(c(762,327,468,484,239,477), ncol=3, byrow=TRUE)
dimnames(x) <- list(c("female", "male"), c("Dem", "Ind", "Rep")) # list(rowName, colName)
tab <- as.table(x)
```
### Create from Data
```R
tab1 <- table(df$x, df$y)
tab2 <- table(df[df$address == "U", c("sex", "romantic")])
```

### Create Property Table
```R
prop_tab <- tab / rowSums(tab)
```

### Select Entry
```R
p1_hat <- prop_tab["R","yes"] # or prop_tab[0, 1]
```

## Bar-Chart
```R
barchart(tab/rowSums(tab), horizontal = FALSE, stack = TRUE, auto.key=TRUE)
```

## Conditional-Density-Plots
Rreflects how the probability of an event varies with the quantitative explanatory variable.
- `DEATH_EVENT`: Categorical Variable
- `age`: Quantitative Variable - explanatory
```R
spineplot(as.factor(DEATH_EVENT) ~ age, data=heart_failure)
cdplot(as.factor(DEATH_EVENT) ~ age, data = heart_failure) # continuous
```

## Chi-Square-Test

$$H_0: \text{The two variables are independent}$$
$$H_1: \text{The two variables are not independent}$$

Set Significance level $5\%$

- If $p-\text{value} < 0.05$, Reject $H_0$, The two variables are not independent.
- If $p-\text{value} > 0.05$, not enough evidence to reject $H_0$, The two variables are independent.

```R
chisq_output <- chisq.test(chest_tab)
chisq_output
chisq_output$pvalue
chisq_output$expected
chisq_output$stdres
```

## Fisher-Test
```R
matrix(c(3, 1, 2, 3), nrow=2, byrow=TRUE) 
dimnames(y) <- list(c("r1", "r2"), c("c1", "c2")) # list(rowName, colName)
tab <- as.table(y)
fisher.test(tab) 
out <- fisher.test(tab)
out$p.value
out$estimate # -> odds ratio
```

## Odds Ratio
```R
OddsRatio(tab, conf.level = .95)
```
Output
```
odds ratio     lwr.ci     upr.ci 
 1.3534040  0.8626023  2.1234612
```
```R
output <- OddsRatio(tab, conf.level = .95)
output[1] # -> odds ratio
output[2] # -> lwr.ci
output[-1] # -> lwr.ci upr.ci 
```

## Kendal-Tau
```R
x <- matrix(c(1, 3, 10, 6,
              2, 3, 10, 7,
              1, 6, 14, 12,
              0, 1,  9, 11), ncol=4, byrow=TRUE)
dimnames(x) <- list(c("<15,000", "15,000-25,000", "25,000-40,000", ">40,000"), 
                    c("Very Dissat.", "Little Dissat.", "Mod. Sat.", 
                      "Very Sat."))
tab <- as.table(x)

output <- Desc(x, plotit = FALSE, verbose = 3)
output[[1]]$assocs
```

## Robust

### Trimed Mean
```R
mean(chem)
mean(chem, trim=0.1)
```
### Winsorize Mean
```R
vals <- quantile(chem, probs=c(0.05, 0.95))
win_sample <- Winsorize(chem, vals)
mean(win_sample)
```
### MAD
$$\hat{\sigma} = \frac{1}{0.6745} MAD(X)$$
```R
sd(chem)
mad(chem)/0.6745
```
### IQR 
$$\hat{\sigma} = \frac{1}{1.35} IQR $$
```R
IQR(chem)/1.35
```