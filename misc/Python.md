# Python Statistical Computing

## Dictionary 

### Add Element


### Remove Element


### Modify Element


### Get Element






## Dataframe

### Select columns
```python
cars['cars_per_cap']  # returns pandas series
cars[['cars_per_cap']] # returns pandas dataframe
```
Using `loc` or `iloc`
```python
cars.loc[:, 'country'] # select column 'country'
cars.iloc[:, 1] # select the first column

# select multiple column
cars.loc[:, ['country','drives_right']] 
cars.iloc[:, [1, 2]] 
```

### Select Row
Consider DataFrame
```
     cars_per_cap        country  drives_right
US            809  United States          True
AUS           731      Australia         False
JPN           588          Japan         False
IN             18          India         False
RU            200         Russia          True
MOR            70        Morocco          True
EG             45          Egypt          True

```

```python
cars.loc['RU'] # -> pandas.Series
cars.iloc[4]   # -> pandas.Series

cars.loc[['RU']] # -> pandas.DataFrame
cars.iloc[[4]]   # -> pandas.DataFrame
```
Select Mutiple Rows
```python
cars.loc[['RU', 'AUS']] 
cars.iloc[[4, 1]]
```

## Select Mutiple Rows with Multipe Column
```python
cars.loc[['IN', 'RU'], ['cars_per_cap', 'country']]
cars.iloc[[3, 4], [0, 1]]
```

## Line diagram
```python
import matplotlib.pyplot as plt
plt.plot(x,y)
plt.show()
```

## Scatter Plot
```python
import matplotlib.pyplot as plt
plt.scatter(x,y)
plt.show()
```








