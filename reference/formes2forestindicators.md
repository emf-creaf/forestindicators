# Wrapper function for simulations with package FORMES

Wrapper function for simulations with package FORMES

## Usage

``` r
formes2forestindicators(x, initial_year = NA, type = "plant_dynamic_input")
```

## Arguments

- x:

  An object issued from simulations with functions `IFNscenario`,
  `run_formes_scenario`.

- initial_year:

  A numeric value of the initial year (step 0 of the simulation)

- type:

  A string describing the input data frame for forestindicators.

## Value

A data frame with data structure suitable for forestindicators
