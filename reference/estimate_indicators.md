# Estimate forest indicators

Estimates forest indicators for a given set of forest stands during a
given set of dates of evaluation.

## Usage

``` r
estimate_indicators(
  indicators,
  stand_static_input = NULL,
  stand_dynamic_input = NULL,
  plant_static_input = NULL,
  plant_dynamic_input = NULL,
  timber_volume_function = NULL,
  plant_biomass_function = NULL,
  additional_params = list(),
  include_units = FALSE,
  progress = FALSE
)
```

## Arguments

- indicators:

  A character vector containing the indicators to be estimated.

- stand_static_input:

  A data frame (or
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) object)
  containing static stand variables. Minimum required column are
  `id_stand` (character).

- stand_dynamic_input:

  Optional data frame containing dynamic stand variables. Minimum
  required columns are `id_stand` (character) and `date`
  ([`Date`](https://rdrr.io/r/base/Dates.html)).

- plant_static_input:

  Optional data frame containing static plant variables. Minimum
  required columns are `id_stand` (character) and `plant_entity`
  (character).

- plant_dynamic_input:

  Optional data frame containing dynamic plant variables. Minimum
  required columns are `id_stand` (character), `plant_entity`
  (character) and `date` ([`Date`](https://rdrr.io/r/base/Dates.html)).

- timber_volume_function:

  Optional function supplied for timber volume calculation.

- plant_biomass_function:

  Optional function supplied for whole-plant biomass calculation.

- additional_params:

  Optional named list where each element is in turn a list of additional
  parameters required for internal indicator functions. The additional
  parameters of each indicator are found in table
  [`additional_parameters`](https://emf-creaf.github.io/forestindicators/reference/additional_parameters.md).

- include_units:

  A logical flag to include output units for indicators.

- progress:

  A logical flag to provide information on progress.

## Value

A [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with
the following columns:

- `id_stand` - Stand identifier.

- `date` - Date of indicator assessment.

- `...` - Additional columns with names equal to strings given in
  `indicators`.

## Details

If columns of the input data frames have defined units, the package will
check those against the units of the required variables

## See also

[`available_indicators`](https://emf-creaf.github.io/forestindicators/reference/available_indicators.md),
[`show_information`](https://emf-creaf.github.io/forestindicators/reference/show_information.md)

## Examples

``` r
## Use functions show_information() and available_indicators() to learn
## the requested inputs

## Call indicator estimation
estimate_indicators(c("live_tree_basal_area", "dead_tree_basal_area"),
                    plant_dynamic_input = example_plant_dynamic_input,
                    progress = TRUE)
#> ℹ Checking overall inputs
#> ℹ Checking inputs for 'live_tree_basal_area'.
#> ✔ Checking inputs for 'live_tree_basal_area'. [8ms]
#> 
#> ℹ Checking overall inputs
#> ✔ Checking overall inputs [25ms]
#> 
#> ℹ Processing 'live_tree_basal_area'.
#> ℹ Checking inputs for 'dead_tree_basal_area'.
#> ✔ Checking inputs for 'dead_tree_basal_area'. [7ms]
#> 
#> ℹ Processing 'live_tree_basal_area'.
#> ✔ Processing 'live_tree_basal_area'. [69ms]
#> 
#> ℹ Processing 'dead_tree_basal_area'.
#> ✔ Processing 'dead_tree_basal_area'. [28ms]
#> 
#> # A tibble: 7 × 4
#>   id_stand date       live_tree_basal_area dead_tree_basal_area
#>   <chr>    <date>                    <dbl>                <dbl>
#> 1 080001   2023-01-01                107.                NA    
#> 2 080001   2024-01-01                119.                NA    
#> 3 080001   2025-01-01                169.                25.1  
#> 4 080005   2023-01-01                162.                 6.94 
#> 5 080005   2024-01-01                 24.3                3.37 
#> 6 080005   2025-01-01                240.                 0.792
#> 7 080005   2025-03-01                 NA                  2.74 
```
