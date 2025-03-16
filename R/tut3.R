setwd("~/Desktop/ST2137/src")
data = read.csv("data/student/student-mat.csv", sep=";")
df = data.frame(data)
col_to_use <- c("G1", "G2", "G3")
corPlot(cor(df[, col_to_use]), cex=0.8, show.legend=FALSE)
grade_score <- c(df$G1, df$G2, df$G3)
grade_type <- rep(c("first", "second", "third"), each=395)
df1 <- data.frame(grade_type=grade_type, grade_score=grade_score)
histogram(~grade_score | grade_type, data=df1, density=TRUE, as.table=TRUE)
summary(df$absences)
box_res <- boxplot(df$absences)
box_res$out
df[df$absences >= min(box_res$out),]
df[df$absences %in% box_res$out,]


data2 <- read.csv("data/er_arrivals.csv")
df2 <- data.frame(data2)
Yk <- df2$num_arrivals
Xk <- table(Yk)
k <- names(Xk)
k <- as.integer(k)
Xk <- as.vector(Xk)
N <- length(Yk)
Phik <- log(factorial(k) * Xk / N)
lm_output <- lm(Phik ~ k)
slope <- lm_output$coefficients['k']
lam_hat <- exp(slope) #-intercept
plot(Phik ~ k)
abline(a=-lm_hat, b=slope)
text(1.8, -1.3, labels=expression(hat(lambda) == "0.56"))
lam_hat_mean <- mean(Yk)
lam_hat_slope <- lam_hat
cat("Estimate from mean is ", sprintf("%.2f", lam_hat_mean), ".\n",
    "Estimate from slope is ", sprintf("%.2f", lam_hat_slope), ".\n", sep="")
