setwd("~/Desktop/ST2137/src")
library(lattice)
data <- read.table("data/wip.txt", header=TRUE)
stud <- read.csv("data/student/student-mat.csv", sep=";")
studf <- data.frame(stud)
wip <- data.frame(data)
concrete <- read.csv("data/concrete+slump+test/slump_test.data")

# Question 1
bwplot(time ~ plant, horizontal = FALSE, data=wip)

# Question 7
a <- paste("aaaa")
a

b <- cat("bbbb")
b

c <- sink("console") # returns NULL
sink()
c

d <- print("ddddd")
d

# Question 10
histogram(~time | plant, breaks=seq(0, 30, by=5), data=wip, type="density")
0.12 * 5 + 0.01 * 5

# Question 14
liverpool <- read.csv("/Users/qiujinhang/Desktop/ST2137/Tutorial/tut2/liverpool_2223_season.csv")
range_gf <- range(liverpool$GF)       
gf_vals <- range_gf[1]:range_gf[2]          # get the range of the GF value
gf_tbl <- rep(0, length=length(gf_vals))    # initialize gf table with 0 for each distinct gf value
names(gf_tbl) <- gf_vals                    

tmp_table <- table(liverpool$GF)            # set up a temporary table for gf value to record the number of observation
gf_tbl[names(tmp_table)] <- tmp_table       # set the value 

barplot(gf_tbl)

barplot(table(liverpool$GF))

# Question 15
f <- function(x) sin(x) - x / 2 - 0.1
result <- uniroot(f, lower=0, upper = 0.5, tol=1e-9)$root
result <- uniroot(f, c(0,0.5), tol=1e-9)$root

print(result)

f_sol <- function(x) {
  sin(x) - x/2 - 0.1
}
output <- uniroot(f_sol, c(0, 0.5))
print(output$root)

print(output$root == result)


# Question 17
hist(concrete$Fine.Aggr.)
density(concrete$Fine.Aggr.)
densityplot(concrete$Fine.Aggr., bw=10)
densityplot(concrete$Fine.Aggr., bw=100)

# Question 18
mat <-  matrix(c(3, 1, 1, 3), nrow=2)
tab18 <- as.table(y)
fisher.test(tab18)
choose(rowSums(mat)[1],mat[1,1]) * choose(rowSums(mat)[2],mat[2,1]) / choose(sum(mat), mat[1,1]+mat[2,1])


# Question 21
prop1 <- sum(studf$guardian=='mother' & studf$address=='R') / NROW(stud)

address_guardian <- table(studf$address, studf$guardian) 
N <- sum(address_guardian) 
prop1_sol <- address_guardian["R", "mother"]/N 

print(prop1 == prop1_sol)

tab <- table(studf$address, studf$guardian)
chisq_output <- chisq.test(tab)
chisq_output
prop2 <- chisq_output$expected['R', 'mother'] / sum(rowSums(chisq_output$expected))
prop2_sol <- chisq.test(tab)$expected[1,2]/N 

print(prop2 - prop2_sol)


# Question 22
tab_rural <- table(studf[studf$address=='R', c("sex", "romantic")])
tab_urban <- table(studf[studf$address=='U', c("sex", "romantic")])
or_r <- OddsRatio(tab_rural,.95)
or_u <- OddsRatio(tab_urban,.95)
output <- list(rural = list(or = or_r[1], ci = or_r[-1]),  
               urban = list(or = or_u[1], ci = or_u[-1])) 





