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
#>  [1] "cut_tree_basal_area"          "cut_tree_density"            
#>  [3] "dead_tree_basal_area"         "dead_tree_density"           
#>  [5] "density_dead_wood"            "dominant_tree_diameter"      
#>  [7] "dominant_tree_height"         "hart_becking_index"          
#>  [9] "live_tree_basal_area"         "live_tree_biomass_stock"     
#> [11] "live_tree_carbon_change_rate" "live_tree_carbon_stock"      
#> [13] "live_tree_density"            "live_tree_volume_stock"      
#> [15] "mean_tree_height"             "quadratic_mean_tree_diameter"
#> [17] "timber_harvest_carbon_rate"   "timber_harvest_volume"       
#> [19] "timber_harvest_volume_rate"  
```
