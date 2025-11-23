# Defining new indicators

## Introduction

Package **forestindicators** is meant to provide a flexible framework
into which implement the estimation of multiple forest metrics. This
implies a *collaborative work* leading to the progressive extension of
the set of metrics included. In this vignette, you will learn how to
contribute with new indicators.

## Elements in the description of indicators

All the information regarding which indicators are included in the
package and their requirements can be found in the data table
`indicator_definition`. For each indicator, it includes:

- Name
- Method of estimation
- Interpretation
- Output units
- Person responsible of its implementation in the package, who is to be
  contacted in case of issues/doubts.
- Variable names required for its estimation (grouped by input data
  frame)

Variables cited in `indicator_definition` are defined in the data table
`variable_definition`, which includes for each variable its level
(*plant* or *stand*), type (*numeric* or *character*), units and
description.

## Indicator functions

Each indicator has a corresponding *internal function* in the package,
with the same name, but starting with a dot (`.`). All indicator
functions have a common set of parameters, corresponding to the four
different input data frames. The functions can also require ancillary
functions to calculate biomass or volumes via allometric equations.
Finally, the functions can have additional parameters, which are
described in data table `additional_parameters`.

## How to define new indicators?

The inclusion of new indicators involves several tasks, which may not be
executed sequentially, but all of them should be completed.

### Task 0. Fork (or re-synchronize) `forestindicators`

In order to define new indicators, you need to *fork* the GitHub
repository to your user. With this, you will be able to perform
developments without interfering with the main repository. If this is
not the first time you contribute, the forked repository will exist, but
you will need to *re-synchronize* to get the latest updates since your
last contribution.

### Task 1. Update of indicator, variable and additional parameter tables

#### Indicator description

The new indicator needs to be described in data table
`indicator_definition`, providing at minimum:

- Indicator name, using multiple words separated by `_`, if necessary.
- Valid output units, if not unit less.
- Person responsible of its implementation in the package, who is to be
  contacted in case of issues/doubts.
- Variable names required for its estimation (see below).

Other fields (interpretation and description) are also strongly
encouraged. The indicator naming should be in lower case and words
separated by underscores.

#### Variables

Variable names should be in lower case with words separated by
underscores. For each variable, it is important to identify to which
input data group the required variables belongs (i.e. *stand-level*
vs. *plant-level* or *static* vs. *dynamic*). Note that a given variable
name can only belong to one group. If new variables need to be defined,
you should modify the data table `variable_definition`, providing for
each variable its type, units and description.

#### Additional parameters

Apart from the data frame inputs, some indicators will require
additional parameters. These should be described in data table
`additional_parameters`. Note that during the package building
procedure, there is a check between parameter names in
`additional_parameters` and the implementation of internal indicator
functions (see below).

### Task 2. Implementation of internal indicator functions

As stated above, each indicator has a corresponding *internal function*
in the package, with the same name, but starting with a dot (`.`). This
function implements the estimation procedure described in the indicator
definition. The general structure of the internal function will be:

``` r
.[indicator name] <- function(stand_static_input = NULL,
                              stand_dynamic_input = NULL,
                              plant_static_input = NULL,
                              plant_dynamic_input = NULL,
                              # [additional param 1],
                              # [additional param n],
                              ...){
}
```

The three dots (i.e. `...`) are used to ignore additional parameters
passed by function
[`estimate_indicators()`](https://emf-creaf.github.io/forestindicators/reference/estimate_indicators.md).
This has the advantage of allowing the omission of data input parameters
that are not to be used. As an example we show here the internal
function for the estimation of dominant tree height, which only requires
one data frame, `stand_dynamic_input`, and has one additional parameter:

``` r
forestindicators:::.dominant_tree_height
#> function(plant_dynamic_input = NULL,
#>                                 min_tree_dbh = 7.5, ...) {
#>   if(!min_tree_dbh >= 0) cli::cli_abort("'min_tree_dbh' should be a numeric positive value")
#> 
#>   ## Filter plant_dynamic_input by state
#>   plant_input <- plant_dynamic_input |>
#>     dplyr::filter(state == "live")
#> 
#>   df <- plant_input |>
#>     dplyr::group_by(id_stand, date) |>
#>     dplyr::summarise(dominant_tree_height = .dth(n, h, dbh, min_tree_dbh = min_tree_dbh))
#> 
#>   ## Return the output data frame
#>   res <- df |> dplyr::select(id_stand, date, dominant_tree_height)
#>   return(res)
#> }
#> <bytecode: 0x56a900d45560>
#> <environment: namespace:forestindicators>
```

### Task 3. Write tests to check functionality

Along with the implementation of the indicator internal function, it is
good practice to include tests in the package to ensure that the
function works and has the intended behavior. Tests should be written
following the guidelines of package **test_that**.

### Task 4. Checks and pull request

When the other tasks are finished, you should reload package data and be
sure that the package passes formal checks. If so, you can then push
changes to your GitHub repository and then make a pull request to the
main repository. The package maintainers should then revise the changes
and approve or not the package modifications.
