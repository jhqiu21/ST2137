## R Data Processing

### Dataframe

#### Correct some rows: `match()`
```R
matched_rows <- match(corrected_data$A, df$A)
df1$y[matched_rows] <- corrected_data$A
```
Correct column A in `df`

#### Test Exists: `%in%`
```R
c(4.7) %in% df1$y # -> False, since LHS is vector, RHS is a dataframe
data.frame(4.7) %in% df1$y # -> TRUE, since both side is df and 4.7 is in the df1
```

