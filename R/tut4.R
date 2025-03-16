setwd("~/Desktop/ST2137/src")
data = read.csv("data/student/student-mat.csv", sep=";")
df = data.frame(data)
tab = table(df$address, df$paid)
chisq_output <- chisq.test(tab)
chisq_output$p.value
barchart(tab, horizontal=FALSE, stack=FALSE)
barchart(tab/rowSums(tab), horizontal=FALSE)
# prop_tab is 0-indexed
prop_tab <- tab / rowSums(tab)
p1_hat <- prop_tab["R","yes"] # or prop_tab[0, 1]
p2_hat <- prop_tab["U","yes"] # or prop_tab[1, 1]
relative_risk <- p1_hat / p2_hat
OddsRatio(tab, conf.level = .95)
score = cut(df$G3, breaks=c(-1,10,12,15,18,20),
               labels=c("F","D","C","B","A"))
score
df$score=score
sum(df$score=="A")

#-------------------------------------------------------------------------------
# find tau-b
index1 <- which(names(df)=="famrel") # 24
index2 <- which(names(df)=="health") # 29
# note that all variables are ordinal -> we need to use kendall tau
for (i in (index1:index2)) {
  tmp_table = table(df[,c(i,34)])
  all_assocs = Desc(tmp_table, plotit=FALSE)[[1]]$assocs
  cat("Kendall Tau-b for", names(stud_perf)[i], ":\t", round(all_assocs[3,1], 3), "\n")
}
#-------------------------------------------------------------------------------

mosaicplot(table(df$Dalc, df$Walc),shade = TRUE, xlab="Dalc", ylab="Walc")
sum(df$Walc==4 & df$Dalc==2) # 22
sum(df$Walc==3 & df$Dalc==2) # 29

#-------------------------------------------------------------------------------
#calculate mi
mi3 <- function(x, y) {
  total <- length(x)
  MI <- 0
  
  xtab <- table(x)
  pX <- as.vector(xtab) / length(x)
  names(pX) <- names(xtab)
  
  ytab <- table(y)
  pY <- as.vector(ytab) / length(y)
  names(pY) <- names(ytab)
  
  for (i in unique(x)) {
    for (j in unique(y)) {
      pXY <- mean(x==i & y==j)
      if (pXY != 0) {
        MI = MI + pXY * log(pXY/(pX[i]*pY[j]))
      }
    }
  }
  return (MI)
}

mi3(df$address, df$paid)





