# R programming cheatsheet

## Catalog

- [Vector](#vector)
- [List](#List)
- [Sequence](#Sequence)
- [Matrix](#Matrix)
- [Factor](#Factor)
- [Dataframe](#Dataframe)

## Basic Syntax




## Vector 

### Name the veator

```R
poker_vector <- c(140, -50, 20, -120, 240)

# Assign days as names of poker_vector
names(poker_vector) <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
```
Output
```
poker_vector
Monday   Tuesday Wednesday  Thursday    Friday 
    140       -50        20      -120       240 
```

### Algebric Operation

```R
A_vector <- c(1, 2, 3)
B_vector <- c(4, 5, 6)
total_vector <- A_vector + B_vector
```
Sum of the vectors only depend on index, instead of name. For example
```R
A <- c(140, -50, 20, -120, 240)
B <- c(-24, -50, 100, -350, 10)
Day1 <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
Day2 <- c("Sunday", "Tuesday", "Wednesday", "Thursday", "Friday")
names(A) <- Day1
names(B) <- Day2

total_daily <- A + B
```
will return the sum of A and B by index. In other words, the different of name at index 1 will not throw out an error.

### Sum of Vector
```R
v <- c(140, -50, 20, -120, 240)
total <- sum(v)
```
returns sum of all values in the vector.

### Vector Selection
```R
v <- c(140, -50, 20, -120, 240)
selection <- v[c(2, 3, 4)] # this is not slicing!
```
returns 2nd, 3rd and 4th element in `v`

```R
v <- c(1, 2, 3, 4, 5)
cond <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
s <- v[cond]
```
returns sub-vector of `v` at the index of `TRUE` in `cond`
### Vector Slicing
```R
slicing <- v[2:5]
```
returns 2nd to 5th element of the vector.
### Broadcast
```R
selection_vector <- poker_vector > 0
selection_vector 
```
returns a boolean vector for condition `poker_vector > 0`


## List
### Create List
Syntax: `my_list <- list(comp1, comp2 ...)`
```R
# Vector with numerics from 1 up to 10
my_vector <- 1:10 
# Matrix with numerics from 1 up to 9
my_matrix <- matrix(1:9, ncol = 3)
# First 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]
# Construct list with these different elements:
my_list <- list(my_vector, my_matrix, my_df)
```
Create List with Name of each component
`list(name1=v1, name2=v2, ...)`
```R
shining_list <- list(moviename = mov, actors = act, reviews = rev)
```

### Name List Components
```R
names(my_list) <- c("vec", "mat", "df")
```

### Select
The following are equivalent
```R
shining_list[["actors"]]
shining_list$actors
```
## Sequence
### Create sequence
```R
seq(from, to, by, length.out)  
```

## Sample

```R
sample(x, size, replace = FALSE, prob = NULL)
```
Takes a sample of the specified size from the elements of x using either with or without replacement.

```R
sample(c("male", "female"), size=6, TRUE)
# -> [1] "male"   "male"   "male"   "male"   "female" "male"  
```



## Matrix
### Create a Matrix
```R
matrix(1:9, byrow = TRUE, nrow = 3)
# Create by row             Create by column
#      [,1] [,2] [,3]           [,1] [,2] [,3]
# [1,]    1    2    3      [1,]    1    4    7
# [2,]    4    5    6      [2,]    2    5    8
# [3,]    7    8    9      [3,]    3    6    9
```
```R
A <- c(1, 2)
B <- c(3, 4)
C <- c(5, 6)
comb <- c(A, B, C)
matrixA <- matrix(comb, nrow=3)
matrixB <- matrix(comb, nrow=6)

```
```MD
     [,1] [,2]
[1,]    1    4
[2,]    2    5
[3,]    3    6
```
```MD
     [,1]
[1,]    1
[2,]    2
[3,]    3
[4,]    4
[5,]    5
[6,]    6
```
### Name the row and column
```R
# Vectors region and titles, used for naming
region <- c("US", "non-US")
titles <- c("X", "Y", "Z")

# Name the columns with region
colnames(matrixA) <- region
# Name the rows with titles
rownames(matrixA) <- titles
# Name both rows and columns
dimnames(matrix) <- list(c("M", "F"), c("Y", "N"))
```

### Algebric Opertions
#### Row Sum: returns a vector of sum of each row of the matrix
```R
total_row <- rowSums(my_matrix)
```
#### Column Sum
```R
total_col <- colSums(my_matrix)
```
#### Transpose: 
```R
t(X)
```
#### Inverse: 
```R
solve(X)
```
#### Multiply
```R
X %*% y
```
### Adding a column/Row
```R
D <- c(3, 4, 5)
new_matrix <- cbind(matrixA, D)
```
```MD
     [,1] [,2] [,3]
[1,]    1    4    3
[2,]    2    5    4
[3,]    3    6    5
```


```R
D <- c(8, 9)
new_matrix <- rbind(matrixA, D)
```
```MD
     [,1] [,2]
[1,]    1    4
[2,]    2    5
[3,]    3    6
[4,]    8    9
```
## Factor
### Convert vector to factor
```R
factor_vec <- factor(v)
```
```R
temperature_vector <- c("High", "Low", "High","Low", "Medium") 
factor_temperature_vector <- factor(temperature_vector, order = TRUE, levels = c("Low", "Medium", "High"))
# [1] High   Low    High   Low    Medium
# Levels: Low < Medium < High
```
### Set Factor Level
```R
# "M", "F", "F", "M", "M"
levels(factor_survey_vector) <- c("Female", "Male")
```
### Ordered Factor
```R
da1 <- temperature_vector[1]
da2 <- temperature_vector[2]
da2 < da1 # returns FALSE 
```

## Dataframe
### Create Data Frame
```R
df <- data.frame(v1, v2, v3, v4, v5)
df2 <- data.frame(Patient = 1:6,
                  Gender = mf_sample, 
                  Pain = pain_sample) # create df with name
```
Create data frame using multiple vectors
### Head/Tail
```R
head(df)
tail(df)
```
### Statistics
```R
NROW(df) # -> total number of data
sum(df$x > 100, df$x < 200) # -> number of bservations whose x between 100 and 200
head(sort(df$x), n) # smallest n elements based on x
tail(sort(df$x), n) # largest n elements based on x
```

### Structure
```R
str(mtcars)
```
Use `str()` to investigate the stucture of the data frame.

### Selection
Select first 5 items in the "diameter" column
```R
planets_df[1:5,"diameter"]
```
Using boolean vector to select rows, returns the rows whose index is TRUE in the boolean vector
```R
# rings_vector = c(FALSE, TRUE, FALSE, ....)
planets_df[rings_vector,]
```
Select items meet the certain condition
```R
subset(my_df, subset = some_condition)
```
### Sort
```R
order(a) # returns the "sorted index"
a[order(a)] # reorder the previous vector
```
Sort the data frame
```R
positions <- order(planets_df$diameter) 
planets_df[positions, ] # Use positions to sort planets_df
```



## Data Processing

### List all unique number 
```R
unique(heart_failure$DEATH_EVENT)
```
```python
unique_values = heart_failure["DEATH_EVENT"].unique()
```

### Read/Write Data

#### JSON
```R
library(jsonlite)
read_json(....)
```