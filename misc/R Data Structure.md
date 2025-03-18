# R programming cheatsheet

- [Basic](#basic-syntax)
- [Vector](#vector)
- [List](#list)
- [Sample](#sample)
- [Sequence](#sequence)
- [Replication](#replication)
- [Matrix](#matrix)
- [Factor](#factor)
- [Dataframe](#dataframe)

## Basic-Syntax
### Loop
```R
while(x<=10) {
  x  
}
```
```R
for(x in 1:10){ # 1 2 3 4 5 6 7 8 9 10
  x
}
```
### Function
```R
f <- function(x) {
  2 * sin(x)
}
f(2)
```

## Vector 
### Create Vector
```R
v1 <- c(1, 2, 3)
v2 <- 1:4 # 1 2 3 4
```
### Name the veator
```R
v <- c(1, 2, 3, 4, 5)
# Assign days as names of poker_vector
names(v) <- c("A", "B", "C", "D", "E")
```
Output
```
A B C D E 
1 2 3 4 5 
```

### Algebric Operation

```R
A_vector <- c(1, 2, 3)
B_vector <- c(4, 5, 6)
total_vector <- A_vector + B_vector
```
Sum of the vectors only depend on index, instead of name. For example
```R
A <- c(1, 2, 3, 4, 5)
B <- c(2, 4, 6, 8, 10)
nameA <- c("A", "B", "C", "D", "E")
nameB <- c("F", "A", "B", "D", "C")
names(A) <- nameA
names(B) <- nameB

result <- A + B
```
- Return the sum of A and B by index. 
- Different of name at same index will not throw out an error. 
- Result Vector will use the name of first operand
```
A  B  C  D  E 
3  6  9 12 15 
```
### Sum of Vector
```R
v <- c(140, -50, 20, -120, 240)
total <- sum(v)
```
returns sum of all values in the vector.

### Vector Selection
#### Select by Index
```R
v <- c(140, -50, 20, -120, 240)
selection <- v[c(2, 3, 4)] # this is not slicing!
```
returns 2nd, 3rd and 4th element in `v`
#### Select by condition
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
v <- c(-1, 1, 2, 0, -3, 5)
c <- v > 0 
c # c(FALSE, TRUE, TRUE, FALSE, FALSE,TRUE)
```
returns a boolean vector for condition `poker_vector > 0`
### Sort the vector
#### `sort()`
```R
sort(v)
```
#### Sort by position
```R
a <- c(9,8,7,7,5,2,8,2,1,7)
order(a) # returns the "sorted index"
a[order(a)] # reorder the previous vector
```

## List
### Create List
Syntax: 
- `my_list <- list(comp1, comp2 ...)`
- `list(name1=v1, name2=v2, ...)`
```R
v <- c(1, 2, 3)
mat <- matrix(1:4, nrow = 2)

l <- list(v, mat, 1)
list_with_name <- list("vec"=vec, "mat"=mat, "int"=1)
```

### Name List Components
```R
names(l) <- c("vec", "mat", "integer")
```
### Select
#### Select Entry
Return a list in target `index` / `name`
```R
tmp <- list_with_name["mat"]
typeof(tmp) # -> list
```

#### Select Value
The following are equivalent, return the value in target `index` / `name`
```R
list_with_name[["mat"]] # ! double brackets
list_with_name$mat
```
## Sequence
### Create sequence
```R
seq(from, to, by, length.out)  
seq(from=2, to=10, by=2) # 2  4  6  8 10
seq(from=2, to=10, length = 5) # 2  4  6  8 10
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

## Replication

### Replication in Vector
```R
rep(1, 5) # 1 1 1 1 1
rep(c(1,2,3), 3) # 1 2 3 1 2 3 1 2 3
rep(c(6,3),c(2,4)) # 6 6 3 3 3 3
```
### Replication in List
```R
rep(list(1,2,3), 3) # list(1, 2, 3, 1, 2, 3, 1, 2, 3)
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
### Total
```R
total <- sum(my_matrix)
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
#### Select first 5 items in the "G3" column
```R
stud_perf[1:5,"G3"] 
```
#### Select "G2" column and "G3" column
```R
stud_perf[,c("G2","G3")]
```
### Using boolean vector to select rows, returns the rows whose index is TRUE in the boolean vector
```R
# rings_vector = c(FALSE, TRUE, FALSE, ....)
planets_df[rings_vector,]
```
#### Select items meet the certain condition
```R
subset(my_df, subset = some_condition)
```
```R
df[df$Gender == "M" & df$CA2 > 85, ] # (vectorised) AND
df[df$Gender == "M" | df$CA2 > 85, ] # (vectorised) OR
```
### Sort
```R
positions <- order(df$G3)
df[positions, ] # Sort df by G3
df[rev(positions), ] # Sort in reversed order
```
Output: Note that the index will not change
```
   G2 G3
1   6  6
2   5  6
8   5  6
3   8 10
5  10 10
7  12 11
^ index do not change!
```