# Wrapper function for simulations with package medfate or medfateland

Wrapper function for simulations with package medfate or medfateland

## Usage

``` r
medfate2forestindicators(x, id_stand = NA, type = "plant_dynamic_input")
```

## Arguments

- x:

  An object issued from simulations with functions
  [`fordyn`](https://emf-creaf.github.io/medfate/reference/fordyn.html),
  [`fordyn_spatial`](https://emf-creaf.github.io/medfateland/reference/spwb_spatial.html),
  [`fordyn_scenario`](https://emf-creaf.github.io/medfateland/reference/fordyn_scenario.html)
  or
  [`fordyn_land`](https://emf-creaf.github.io/medfateland/reference/spwb_land.html)

- id_stand:

  A string identifying the forest stand (if `x` has been obtained using
  [`fordyn`](https://emf-creaf.github.io/medfate/reference/fordyn.html)).

- type:

  A string describing the input data frame for forestindicators.

## Value

A data frame with data structure suitable for forestindicators
