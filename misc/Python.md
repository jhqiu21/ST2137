# Python Statistical Computing
## Array
### Array Comparison
1. Singal Condition
     ```python
     A = np.array([1, 2, 3, 4])
     B = np.array([2, 3, 1, 5])
     C = A < B # -> [True  True False  True]
     ```
2. Multiple conditions, using `np.logical_and()`, `np.logical_or()` and `np.logical_not()`
     ```python
     res = np.logical_and(A > 1, A < 5)
     ```
### Loop Array

### N-d Array
Use `np.nditer()`
```python
A = np.array([[1, 2],[3, 4],[5, 6]])
for x in np.nditer(A):
    print(x)
```
```
1
2
3
4
5
6
```



## Dictionary 
```python
dict = { "X": "x", "Y": "y", "Z": "z" }
```
### Add Element
1. `update()` method
     ```python
     dict.update({"M": "m"})
     ```
1. Assign directly
     ```python
     dict["W"] = "w"
     ```
### Remove Element
1. `pop()` method removes the item with the **specified key name**
     ```pyhton
     dict.pop("X") # remove the key X
     ```
1. `popitem()` method removes the last inserted item
     ```python
     dict = { "X": "x", "Y": "y", "Z": "z" }

     dict.update({"M": "m"})
     dict["W"] = "w"
     dict.popitem() # remove the last inserted item
     # {'X': 'x', 'Y': 'y', 'Z': 'z', 'M': 'm'}
     ```
1. `del` keyword removes the item with the **specified key name**
     ```python
     del dict["X"]
     ```

1. `clear()` keyword empties the dictionary
     ```python
     dict.clear()
     ```


### Modify Element


### Access Element

### Loop over dictionary
Use the `items()` method to loop over a dictionary:
```python
for key, value in dict.items() :
    ....
```



## Enumerate
```python
seq = ['one', 'two', 'three']
for i, element in enumerate(seq):
     print i, element

# 0 one
# 1 two
# 2 three
```


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

### Select Mutiple Rows with Multipe Column
```python
cars.loc[['IN', 'RU'], ['cars_per_cap', 'country']]
cars.iloc[[3, 4], [0, 1]]
```

### Filter

1. Filter rows: use `cond` to filter dataframe, returns all rows with `True` value
     ```python
     cond = cars['drives_right'] # Series of boolean values
     sel = cars[cond] # Returns all "True" rows

     cpc = cars['cars_per_cap']
     many_cars = cpc > 500
     car_maniac = cars[many_cars] # get All cars whose cpc > 500
     ```

### Loop over DataFrame
```python
for index, row in df.iterrows():
    print(index) # -> index of each row
    print(row) # -> the row object
```

### Map Function
```python
cars["COUNTRY"] = cars["country"].apply(str.upper)
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








