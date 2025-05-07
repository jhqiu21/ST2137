###########################################
#         ST2137 Midterm R Script         #
###########################################
setwd("~/Desktop/ST2137/src/data")
library(lattice)
library(psych)
library(DescTools)

#-------------------------------------------------------------------------------

data = read.csv('liverpool_2223_season.csv')
data[,-(1:3)]
data[data$GF > data$GA, c('GF', 'GA')]
# Q5
hawker_ctr_raw <- list(list(2, 
                            list('STREETNAME'=c("Commonweath Drive"), 
                                       'POSTALCODE'=c("141001")),
                       list('STREETNAME'=c("Kensington Park Road"), 
                                  'POSTALCODE'=c("557269"))
                       
                       ))



# Q
stud_perf <- read.table("student/student-mat.csv", 
                        sep=";", 
                        header=TRUE)
df = data.frame(stud_perf)
df$G3
func <- function(data, a) {
  v <- c(data, 2 * a - data)
  d <- v[v > a]
  x <- c(d, d)
  histogram(x, type="density", bw=1.5, endpoints=c(-10, 25), xlab=names(data))
}

func(df$G3, 0)



