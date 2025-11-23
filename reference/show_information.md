# Describe an individual indicator

Prompts information in to the console regarding the definition, units
and data requirements for a given forest indicator.

## Usage

``` r
show_information(indicator)
```

## Arguments

- indicator:

  Character string of the indicator to be described.

## Value

The function returns console output only.

## See also

[`available_indicators`](https://emf-creaf.github.io/forestindicators/reference/available_indicators.md),
[`estimate_indicators`](https://emf-creaf.github.io/forestindicators/reference/estimate_indicators.md)

## Examples

``` r
show_information("timber_harvest")
#> A) DEFINITION
#> 
#>    Name:  timber_harvest 
#>    Estimation:  Allometric volume relationships 
#>    Interpretation:  Volume over bark of harvested wood 
#>    Output units:  m3/ha 
#> 
#> 
#> B) DATA INPUTS
#> 
#> B.1) Stand-level static data: <NONE>
#> B.2) Stand-level dynamic data: <NONE>
#> B.3) Plant-level static data: <NONE>
#> B.4) Plant-level dynamic data:
#> 
#>      variable      type units
#>           dbh   numeric    cm
#>             h   numeric     m
#>             n   numeric  ha-1
#>  plant_entity character  <NA>
#>         state character  <NA>
#>                                                   description
#>                                     diameter at breast height
#>                                                        height
#>                                                       density
#>                   name or code? of the tree, shrub, … species
#>  state of the cohort, tree, … can be 'live', 'cut', or 'dead'
#> 
#> 
#> C) ADDITIONAL PARAMETERS
#> 
#>         parameter default_value
#>      min_tree_dbh           7.5
#>      max_tree_dbh          <NA>
#>  targeted_species          <NA>
#>  excluded_species          <NA>
#>                                                                description
#>  Minimum  tree diameter to be included in the estimation of harvest volume
#>  Maximum  tree diameter to be included in the estimation of harvest volume
#>               Tree species included in the calculation of harvested volume
#>           Tree species not included in the calculation of harvested volume
#> 
#> 
```
