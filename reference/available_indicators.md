# Available indicators

Provides the set of indicators available for the supplied input data

## Usage

``` r
available_indicators(
  stand_static_input = NULL,
  stand_dynamic_input = NULL,
  plant_static_input = NULL,
  plant_dynamic_input = NULL
)
```

## Arguments

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

## Value

A character string with the set of indicators that can be estimated
given the supplied input data.

## See also

[`show_information`](https://emf-creaf.github.io/forestindicators/reference/show_information.md),
[`estimate_indicators`](https://emf-creaf.github.io/forestindicators/reference/estimate_indicators.md)

## Examples

``` r
available_indicators(plant_dynamic_input = example_plant_dynamic_input)
#>  [1] "carbon_stock"                 "cut_basal_area"              
#>  [3] "cut_tree_density"             "dead_basal_area"             
#>  [5] "dead_tree_density"            "density_dead_wood"           
#>  [7] "dominant_tree_diameter"       "dominant_tree_height"        
#>  [9] "hart_becking_index"           "live_basal_area"             
#> [11] "live_tree_density"            "mean_tree_height"            
#> [13] "quadratic_mean_tree_diameter" "timber_harvest"              
```
