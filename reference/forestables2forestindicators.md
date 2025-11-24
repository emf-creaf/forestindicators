# Wrapper function for structures obtained with forestables

Wrapper function for structures obtained with forestables

## Usage

``` r
forestables2forestindicators(
  x,
  country = "ES",
  version = "ifn2",
  type = "plant_dynamic_input"
)
```

## Arguments

- x:

  A data frame obtained with package forestables

- country:

  Country of the forest inventory (i.e. "ES", "FR" or "US")

- version:

  Spanish National Forest Inventory version (i.e. "ifn2", "ifn3" or
  "ifn4")

- type:

  A string of the input data frame required for forestindicators.

## Value

A data frame with data structure suitable for forestindicators
