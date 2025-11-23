
# Indicators of forest stands

<!-- badges: start -->

[![R-CMD-check](https://github.com/emf-creaf/forestindicators/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/emf-creaf/forestindicators/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Introduction

Package **forestindicators** is meant to assist the estimation of
indicators (metrics) for forest stands, either derived from forest
inventory data or forest model simulations. Most often, those indicators
will estimate the provision of forest ecosystem services, but the
package can be understood more generally as a platform to estimate
forest metrics.

## Installation

Package **forestindicators** can be installed from GitHub using:

``` r
remotes::install_github("emf-creaf/forestindicators")
```

## Examples

### Step 1: Choose target indicators and examine their requirements

The first step is to decide which indicators are to be estimated. You
can examine the names of the indicators in the package that could be
estimated with your data by calling function `available_indicators()`:

``` r
library(forestindicators)
available_indicators(plant_dynamic_input = example_plant_dynamic_input)
#>  [1] "cut_tree_basal_area"          "cut_tree_density"            
#>  [3] "dead_tree_basal_area"         "dead_tree_density"           
#>  [5] "density_dead_wood"            "dominant_tree_diameter"      
#>  [7] "dominant_tree_height"         "hart_becking_index"          
#>  [9] "live_tree_basal_area"         "live_tree_biomass_stock"     
#> [11] "live_tree_carbon_stock"       "live_tree_density"           
#> [13] "live_tree_volume_stock"       "mean_tree_height"            
#> [15] "quadratic_mean_tree_diameter" "timber_harvest"
```

We may need to check which data inputs are required, their units, etc.
for a particular indicator. We can find this information using function
`show_information()`, for example:

``` r
show_information("live_tree_basal_area")
#> A) DEFINITION
#> 
#>    Name:  live_tree_basal_area 
#>    Estimation:  The sum of tree sections weighted by tree density of living trees larger than a pre-specified minimum parameter 
#>    Interpretation:  Basal area of the stand, focusing of living trees 
#>    Output units:  m2/ha 
#> 
#> 
#> B) DATA INPUTS
#> 
#> B.1) Stand-level static data: <NONE>
#> B.2) Stand-level dynamic data: <NONE>
#> B.3) Plant-level static data: <NONE>
#> B.4) Plant-level dynamic data:
#> 
#>  variable      type units
#>       dbh   numeric    cm
#>         n   numeric  ha-1
#>     state character  <NA>
#>                                                   description
#>                                     diameter at breast height
#>                                                       density
#>  state of the cohort, tree, … can be 'live', 'cut', or 'dead'
#> 
#> 
#> C) ADDITIONAL PARAMETERS
#> 
#>     parameter default_value
#>  min_tree_dbh           7.5
#>                                                                          description
#>  Minimum  tree diameter to be included in the estimation of basal area of live trees
```

### Step 2: Assemble inputs and define values for additional parameters

Once the requested format and content of inputs is know, it is the
responsibility of the user to build the necessary data frames to be used
as inputs. We will normally need to define additional parameters to
fine-tune the estimation of indicators, For that, we define a **named
list** where each element corresponds to a different indicator and, in
turn, contains a named list of parameters:

``` r
params <- list(live_tree_basal_area = list(min_dbh = 8),
               live_tree_density = list(min_dbh = 8))
```

### Step 3: Call general estimation function

Once we have our inputs ready, the indicators are estimated by calling
function `estimate_indicators()` as follows:

``` r
res <- estimate_indicators(indicators = c("live_tree_basal_area", "live_tree_density"),
                           plant_dynamic_input = example_plant_dynamic_input,
                           additional_params = params,
                           include_units = TRUE,
                           verbose = FALSE)
```

The result of the estimation is the following:

``` r
res
#> # A tibble: 6 × 4
#>   id_stand date       live_tree_basal_area live_tree_density
#>   <chr>    <date>                 [m^2/ha]            [1/ha]
#> 1 080001   2025-01-01                306.               3282
#> 2 080001   2025-02-01                292.               3000
#> 3 080001   2025-03-01                226.               2285
#> 4 080005   2025-01-01                 79.3              1489
#> 5 080005   2025-02-01                171.               2249
#> 6 080005   2025-03-01                151.               1885
```

## Documentation and training

Two *vignettes* are included
[here](https://emf-creaf.github.io/forestindicators/articles/)
illustrate:

1.  How to use the R package to estimate indicators
2.  How to define new indicators.

## Volume/biomass allometric functions

Some of the indicators require the use of allometric relationships for
*volume* or *biomass* estimation. Users of **forestindicators** can
define their own functions for volume/biomass estimation and provide
them to calls of `estimate_indicators()`. Alternatively, they can resort
on additional packages and write wrapper functions. Even though it is
not a strict requirement for **forestindicators**, applications of the
package within Spain will be most useful if package
[**IFNallometry**](https://emf-creaf.github.io/IFNallometry/index.html)
is available, because it contains wrapper functions for *volume* or
*biomass* estimation, which can be readily used when calculating forest
indicators. Package **IFNallometry** is also installed from GitHub
using:

``` r
remotes::install_github("emf-creaf/IFNallometry")
```

## Authorship

Package **forestindicators** is developed and maintained by the
[*Ecosystem Modelling Facility*](https://emf.creaf.cat) unit at
[*CREAF*](https://www.creaf.cat/) (in Spain) and the *Landscape
Modelling Group* at [*CTFC*](https://www.ctfc.cat/) (in Spain).

<img src="man/figures/institution_logos.png" width="50%" style="display: block; margin: auto;" />

## Funding

- **Research project**: Improving the modelling of key forest dynamic
  processes to forecast long-term changes in Mediterranean forests under
  climate change (IMPROMED). **Financial Entity**: Ministerio de Ciencia
  e Innovación (PID2023-152644NB-I00). **Duration from**: 01/09/2024
  **to**: 31/08/2025. **PI**: Miquel De Cáceres/Josep Mª Espelta.
