#q1
df1 = data.frame(
  x = c(50, 51, 52, 53, 54, 55),
  y = c(4.4, 4.7, 4.7, 5.9, 6.6, 7.3)
)

#q2
write.csv(df1, "~/Desktop/ST2137/src/data/phones-2420.csv")

#load the data
library(MASS)
data(phones)

#q3
phones_df = data.frame(year=phones$year, calls=phones$calls)
as.data.frame(phones) # another method to create data frame

# number of rows
NROW(phones_df) # try to use upper case version to avoid NULL value
dim(phones_df) # 24 2

# observations between 100 and 200 million calls
# which(phones$calls>100 & phones$calls<200) -> vector
length(which(phones_df$calls>100 & phones_df$calls<200))
subset(phones_df, calls > 100 & calls < 200) # another solution

# largest 3
sort(phones_df$calls, decreasing=TRUE)[1:3]

# smallest 3
sort(phones_df$calls)[1:3]

# In which year was the largest number of calls made?
phones_df$year[which.max(phones_df$calls)] # solution 1
phones_df[phones_df$calls == max(phones_df$calls), ]

#q4
X <- cbind(1, phones$year)
y <- matrix(phones$calls, ncol = 1)
beta_hat = (solve(t(X)%*%X)) %*% t(X) %*% y
y_hat = X %*% beta_hat

#q5
lm_output <- lm(y ~ x, data=df1)
typeof(lm_output)
lm_output

#q6

all_combn = combn(24, 2)
all_slopes = rep(0.0, length=276)
for (i in 1:276) {
  y_vec = phones_df$calls[all_combn[,i]]
  x_vec = phones_df$year[all_combn[,i]]
  all_slopes[i] = (y_vec[2] - y_vec[1]) / (x_vec[2] - x_vec[1])
}
fit_slope = median(all_slopes)
fit_intercept = median(phones_df$calls) - median(phones_df$year) * fit_slope

#q7
library(jsonlite)
corrected_data <- read_json("~/Desktop/ST2137/src/data/phones.json", TRUE)
# match returns the index 
index_array = match(corrected_data$year, phones_df$year)

# for loop -> not optimal
for (i in length(index_array)) {
  index = index_array[i]
  phones_df[index,]$calls = corrected_data[i]$corrected_calls
}

# solution
phones_df$calls[index_array] = corrected_data$corrected_calls

