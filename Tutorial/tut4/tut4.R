data <- read.csv("../../src/data/student/student-por.csv", sep = ";")
df <- data.frame(data)
df$address <- as.factor(df$address)
df$paid <- as.factor(df$paid)
df2 <- data.frame("address" = df$address, "paid" = df$paid)
ct <- table(df2)
chisq.test(ct)

prop_ct <- prop.table(ct,margin=1)


df$LG <- as.factor(cut(df$G3, breaks=c(-1, 10, 12, 15, 18, 20), 
                       labels=c('F', 'D', 'C', 'B', 'A')))


likert_vars <- c("famrel", "freetime", "goout", 
                 "Dalc", "Walc", "health")

for (v in likert_vars) {
  table_var <- table(df[[v]], df$LG)
  chisq.test(table_var)
}

alc_fam <- table(data.frame("Dalc"=as.factor(df$Dalc), 
                            "Walc"=as.factor(df$Walc)))

mosaicplot(alc_fam, shade=TRUE)

mi <- function(x, y) {
  joint_table <- table(x, y) / length(x)  # P(X, Y)
  px <- table(x) / length(x)              # P(X)
  py <- table(y) / length(y)              # P(Y)
  
  mi <- 0
  for (i in rownames(joint_table)) {
    for (j in colnames(joint_table)) {
      pxy <- joint_table[i, j]
      if (pxy > 0) {  # Avoid log(0)
        mi <- mi + pxy * log(pxy / (px[i] * py[j]))
      }
    }
  }
  return(mi)
}

mi(df$address, df$paid)
