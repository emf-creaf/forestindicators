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
  verbose = TRUE
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

- verbose:

  A logical flag to provide information on progress

## Value

A data frame with the following columns:

- `id_stand` - Stand identifier.

- `date` - Date of indicator assessment.

- `...` - Additional columns with names equal to strings given in
  `indicators`.

## Details

Additional details...

## See also

[`available_indicators`](https://emf-creaf.github.io/forestindicators/reference/available_indicators.md),
[`show_information`](https://emf-creaf.github.io/forestindicators/reference/show_information.md)

## Examples

``` r
## Use functions show_information() and available_indicators() to learn
## the requested inputs

## Named lists with additional parameters needed for each indicator
add_params <- list(timber_harvest = list(province = 8),
                   density_dead_wood = list(max_tree_dbh = 20))

## Call indicator estimation
estimate_indicators(c("basal_area", "timber_harvest", "density_dead_wood"),
                    plant_dynamic_input = example_plant_dynamic_input,
                    timber_volume_function = forestindicators:::.ifn_volume_forestindicators,
                    additional_params = add_params,
                    verbose = TRUE)
#> ℹ Checking overall inputs
#> ℹ Checking inputs for 'timber_harvest'.
#> ✔ Checking inputs for 'timber_harvest'. [8ms]
#> 
#> ℹ Checking overall inputs
#> ✔ Checking overall inputs [25ms]
#> 
#> ℹ Processing 'timber_harvest'.
#> Error in estimate_indicators(c("basal_area", "timber_harvest", "density_dead_wood"),     plant_dynamic_input = example_plant_dynamic_input, timber_volume_function = forestindicators:::.ifn_volume_forestindicators,     additional_params = add_params, verbose = TRUE): object '.ifn_volume_forestindicators' not found
#> ✖ Processing 'timber_harvest'. [16ms]
#> 
```
