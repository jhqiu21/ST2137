# R Data Processing

## Read/Write Data
### Table
#### Header Exist
```R
data1 <- read.table("data/crab.txt", header=TRUE)
                                     # prevent setting the header as first row
head(data1)
```
#### Header Non-exist
```R
varnames <- c("Subject", "Gender", "CA1", "CA2", "HW")
data <- read.table("data/ex_1.txt", header = FALSE, # read from the first row of table
                    col.names = varnames) # set the header
```
### CSV
```R
data3 <- read.csv("data/ex_1_comma.txt",  header = FALSE)
data3 <- read.csv("data/ex_1_comma.txt",  header = TRUE)
```
### JSON
```R
library(jsonlite)
read_json(....)
```
### `sink()`
```R
sink("data/datasink_ex1.txt") # turn the sink on
x <- 0            
test <- TRUE 

while(test) {
  x <- x+1 
  test <- isTRUE(x<6)  
  cat(x^2, test, "\n") # This will be written to the file.
}
sink() # turn the sink off
```
## `apply()`
### `apply()`
`apply(X, MARGIN, FUN, simplify=TURE)`

- Margin: 1 -> row, 2 -> column

```R
X <- matrix(1:9, nrow=3)
apply(X, 1, mean) # -> return row mean (4, 5, 6)
apply(X, 2, mean) # -> return column mean (2, 5, 8)
```

### `lapply()`
```R
l <- c(1, 2, 3, 4)
lapply(l, function(x) x + 1) # -> list(2, 3, 4, 5)
```

### `sapply(object, Func)`
```R
df <- data.frame(x=c(1,2,3,4,5,6), y=c(3,2,4,2,34,5)) 
sapply(df, max) 
>
 x  y 
 6 34 
```

### `tapply(object, index, func)`

- index: determines the factor vector that helps us distinguish the data.

```R
tapply(stud_perf$G3, stud_perf$address, mean)
>
        R         U 
 9.511364 10.674267 
```

## Dataframe
### List all unique number 
```R
unique(heart_failure$DEATH_EVENT)
```
```python
unique_values = heart_failure["DEATH_EVENT"].unique()
```

### Correct some rows: `match()`
```R
matched_rows <- match(corrected_data$A, df$A)
df1$y[matched_rows] <- corrected_data$A
```
Correct column A in `df`

### Test Exists: `%in%`
```R
c(4.7) %in% df1$y # -> False, since LHS is vector, RHS is a dataframe
data.frame(4.7) %in% df1$y # -> TRUE, since both side is df and 4.7 is in the df1
```

### Get Frequency
Use `table()`
```R
table(df$x) # -> return freq number of each value
prop.table(table(df$x)) # -> return property of each value
```

### Classify using `cut()`
The following example classify `x` in `df` to $(-1,3], (3,6], (6,8]$ and labels them to C, B, A
```R
cut(df$x, c(-1, 3, 6, 8), labels=c('C','B','A'))
```