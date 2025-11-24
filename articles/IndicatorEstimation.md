# Indicator estimation procedures

## Introduction

In this vignette, you will learn:

1.  How to format your data for indicator estimation.
2.  How to discover which indicator functions are available, their data
    requirements and additional parameters.
3.  How to perform the estimation of multiple indicators at once.

## Data frame inputs

Data inputs for the estimation of indicators are data frames. Not all
indicators require the same inputs, and the data frames can be of four
different kinds, depending on:

- Whether they describe *stand-level* vs. *plant-level* data
- Whether they contain *static* vs. *dynamic* data

The following subsections provide examples of the four different data
frames. A single indicator may only need data of one kind
(e.g. plant-level dynamic data), but when calculating several indicators
at once, one may end-up supplying more than one data frame.

### Stand-level static data

This data frame contains **STAND-level** information that **DOES NOT
change through time**, such as topographic features, the area
represented, etc.

The actual columns will depend on the indicator to be calculated, but at
least a column `id_stand` (character) should be defined to identify
stands. An example of stand-level static data frame is the following:

``` r
example_stand_static_input
#>   id_stand  area slope_degree
#> 1   080001 662.3          3.5
#> 2   080002 329.3          0.9
#> 3   080003 565.7          3.2
#> 4   080004 161.2          7.4
#> 5   080005 589.7          7.9
#> 6   080006 461.2          7.3
#> 7   080007 589.5          1.6
#> 8   080008 428.3          1.6
#> 9   080009 580.2          3.1
```

### Stand-level dynamic data

This data frame contains **STAND-level** information that **DOES change
through time**, such as temperature, precipitation, the stand leaf area
index, canopy cover, etc.

The actual columns will depend on the indicator to be calculated, but at
least columns `id_stand` (character) and `date` (Date) should be defined
to identify stands and time points, respectively. An example of
stand-level dynamic data frame is the following:

``` r
example_stand_dynamic_input
#>    id_stand       date mean_precipitation canopy_cover
#> 1    080001 2025-01-01              541.0         62.8
#> 2    080002 2025-01-01              750.6          0.9
#> 3    080003 2025-01-01              173.5         21.0
#> 4    080004 2025-01-01               71.7         62.5
#> 5    080005 2025-01-01              755.7          2.5
#> 6    080006 2025-01-01              464.0         12.1
#> 7    080007 2025-01-01              219.7         51.9
#> 8    080008 2025-01-01              649.8         37.2
#> 9    080009 2025-01-01              351.4         50.8
#> 10   080001 2025-02-01              134.2         17.3
#> 11   080002 2025-02-01              870.5         69.2
#> 12   080003 2025-02-01               30.2         78.0
#> 13   080004 2025-02-01              417.5         41.3
#> 14   080005 2025-02-01               13.5          1.2
#> 15   080006 2025-02-01              655.9         19.8
#> 16   080007 2025-02-01              231.4         83.0
#> 17   080008 2025-02-01                9.3         16.8
#> 18   080009 2025-02-01              113.0         61.2
#> 19   080001 2025-03-01              547.0         66.5
#> 20   080002 2025-03-01              252.4         74.7
#> 21   080003 2025-03-01              635.1         19.0
#> 22   080004 2025-03-01              429.0         10.1
#> 23   080005 2025-03-01              547.3         11.8
#> 24   080006 2025-03-01              353.1         56.1
#> 25   080007 2025-03-01              362.2         44.4
#> 26   080008 2025-03-01              442.3         84.2
#> 27   080009 2025-03-01              373.7         14.3
```

### Plant-level static data

This data frame contains **PLANT-level** information that **DOES NOT
change through time**, such as taxonomy, traits, etc.

The actual columns will depend on the indicator to be calculated, but at
least a columns `id_stand` (character) and `plant_entity` (character)
should be defined to identify stands and plants, respectively. An
example of plant-level static data frame is the following:

``` r
example_plant_static_input
#>    id_stand     plant_entity beautiness
#> 1    080001 Pinus halepensis       0.00
#> 2    080002 Pinus halepensis       0.22
#> 3    080003 Pinus sylvestris       0.13
#> 4    080004 Pinus sylvestris       0.07
#> 5    080005     Quercus ilex       0.18
#> 6    080006     Quercus ilex       0.14
#> 7    080007     Quercus ilex       0.01
#> 8    080008    Quercus suber       0.47
#> 9    080009    Quercus suber       0.54
#> 10   080001      Pinus nigra       0.43
#> 11   080002      Pinus nigra       0.05
#> 12   080005 Pinus halepensis       0.53
#> 13   080006 Pinus halepensis       0.09
```

### Plant-level dynamic data

This data frame contains **PLANT-level** information that **DOES change
through time**, such as dbh, height, cover, etc.

The actual columns will depend on the indicator to be calculated, but at
least a columns `id_stand` (character), `plant_entity` (character) and
`date` (Date) should be defined to identify stands and plants,
respectively. An example of plant-level dynamic data frame is the
following:

``` r
example_plant_dynamic_input
#>    id_stand     plant_entity       date state  dbh    h   n
#> 1    080001 Pinus halepensis 2023-01-01  live 52.0 17.9  62
#> 2    080001 Pinus halepensis 2023-01-01  live  9.1 16.5 604
#> 3    080001      Pinus nigra 2023-01-01  live 39.8  5.9 654
#> 4    080001      Pinus nigra 2023-01-01  live  7.0  8.2 334
#> 5    080001      Pinus nigra 2023-01-01  live 25.0 20.9 168
#> 6    080001 Pinus halepensis 2024-01-01  live 19.6  4.5 529
#> 7    080001 Pinus halepensis 2024-01-01  live 40.1 21.2 634
#> 8    080001      Pinus nigra 2024-01-01  live 12.9  6.9 313
#> 9    080001      Pinus nigra 2024-01-01  live 19.6  4.0 372
#> 10   080001      Pinus nigra 2024-01-01  live 46.8 13.1  43
#> 11   080001 Pinus halepensis 2025-01-01  live 33.1  4.7 327
#> 12   080001 Pinus halepensis 2025-01-01  live 25.0 19.0 793
#> 13   080001      Pinus nigra 2025-01-01  live 41.2 14.8  42
#> 14   080001      Pinus nigra 2025-01-01  live 51.9  7.7 189
#> 15   080001      Pinus nigra 2025-01-01  live 35.8 14.0 558
#> 16   080005     Quercus ilex 2023-01-01  live 51.2 13.6 655
#> 17   080005     Quercus ilex 2023-01-01  live 32.5 11.2 303
#> 18   080005 Pinus halepensis 2023-01-01  live  9.5  3.3 353
#> 19   080005     Quercus ilex 2024-01-01  live 12.4 22.1 241
#> 20   080005     Quercus ilex 2024-01-01  live 21.8 11.4 322
#> 21   080005 Pinus halepensis 2024-01-01  live 36.4 15.5  90
#> 22   080005     Quercus ilex 2025-01-01  live 33.6  8.6 257
#> 23   080005     Quercus ilex 2025-01-01  live 21.8 11.9 224
#> 24   080005 Pinus halepensis 2025-01-01  live 49.2 21.6 841
#> 25   080005 Pinus halepensis 2025-01-01  live 31.5 17.7 627
#> 26   080001 Pinus halepensis 2023-01-01   cut 43.6  3.6 112
#> 27   080001 Pinus halepensis 2023-01-01   cut 54.6 17.0  96
#> 28   080001      Pinus nigra 2023-01-01   cut 25.7  4.7  17
#> 29   080001 Pinus halepensis 2024-01-01   cut 40.9 12.1  37
#> 30   080001      Pinus nigra 2025-01-01   cut 36.0 14.4 193
#> 31   080005     Quercus ilex 2023-01-01   cut 36.0 15.4 118
#> 32   080005 Pinus halepensis 2023-01-01   cut 38.6 11.6 178
#> 33   080005     Quercus ilex 2024-01-01   cut  9.7  4.9  47
#> 34   080005 Pinus halepensis 2025-01-01   cut 50.4 15.5 143
#> 35   080001 Pinus halepensis 2025-01-01  dead 47.1 13.3   8
#> 36   080001      Pinus nigra 2025-01-01  dead 48.6  0.2  90
#> 37   080001      Pinus nigra 2025-01-01  dead 37.5 17.8  45
#> 38   080001      Pinus nigra 2025-01-01  dead 21.6 13.7  57
#> 39   080005     Quercus ilex 2023-01-01  dead 42.2  1.8  47
#> 40   080005     Quercus ilex 2023-01-01  dead  6.4 17.6  96
#> 41   080005 Pinus halepensis 2023-01-01  dead 15.6  7.4  19
#> 42   080005 Pinus halepensis 2024-01-01  dead 24.6 10.2  71
#> 43   080005     Quercus ilex 2025-03-01  dead 19.8 16.9  89
#> 44   080005     Quercus ilex 2025-01-01  dead 10.3 13.1  95
```

## Indicators

### Indicator definition table

All the information regarding which indicators are included in the
package and their requirements can be found in the data table
`indicator_definition`. For each indicator, it includes:

- Indicator name
- Method of estimation
- Interpretation
- Output units
- Person responsible of its implementation in the package, who is to be
  contacted in case of issues/doubts.
- Variable names required for its estimation (grouped by input data
  frame)

### Variable definition table

The type and units of all input variables can be found in table
`variable_definition`.

### Indicator functions

Each indicator is implemented in the package as an **internal
function**, maintained by the responsible person. This functions is not
directly accessible to the user, but is called via
[`estimate_indicators()`](https://emf-creaf.github.io/forestindicators/reference/estimate_indicators.md)
(see below).

### Additional parameters

The estimation of indicators may require other information in addition
to the input data frame. Table `additional_parameters` contains the
description of additional parameters for those functions that require
them. The way these parameters are specified is described below.

## Indicator estimation procedure

The general procedure for the estimation of forest indicators follows
three main steps, which we illustrate in the following subsections:

### Step 1: Choose target indicators and examine their requirements

The first step is to decide which indicators are to be estimated. The
list of all indicators is given in table `indicator_definition`.
Additionally, you can examine the names of the indicators in the package
that could be estimated with your data by calling function
[`available_indicators()`](https://emf-creaf.github.io/forestindicators/reference/available_indicators.md):

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
#> [17] "timber_harvest"               "timber_harvest_carbon_rate"
```

Note that if variable names (or variable units) are incorrectly
specified, then the available indicator list may be shorter than
expected.

Say we decide to estimate the *timber harvest volume* (i.e. indicator
`"timber_harvest"`) and the *basal area of living trees* (i.e. indicator
`"live_tree_basal_area"`). We may need to check which data inputs are
required, their units, etc. We can find this information using function
[`show_information()`](https://emf-creaf.github.io/forestindicators/reference/show_information.md),
for example:

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
```

### Step 2: Assemble inputs and define values for additional parameters

Once the requested format and content of inputs is know, it is the
responsibility of the user to build the necessary data frames to be used
as inputs. Variable names and types should follow the guidelines of
[`show_information()`](https://emf-creaf.github.io/forestindicators/reference/show_information.md).
Variable units can be specified using package **units** (and in this
case unit correspondence will be checked), but they are not compulsory.
In our case, we will use `example_plant_dynamic_input` that already
contains the necessary data for the estimation of the two indicators.

We will normally need to define additional parameters to fine-tune the
estimation of indicators, For that, we define a **named list** where
each element corresponds to a different indicator and, in turn, contains
a named list of parameters. In our case:

``` r
params <- list(timber_harvest = list(province = 8),
               live_tree_basal_area = list(min_tree_dbh = 5))
```

### Step 3: Call general estimation function

Once we have our inputs ready, the indicators are estimated by calling
function
[`estimate_indicators()`](https://emf-creaf.github.io/forestindicators/reference/estimate_indicators.md)
as follows:

``` r
res <- estimate_indicators(indicators = c("timber_harvest", "live_tree_basal_area"),
                           plant_dynamic_input = example_plant_dynamic_input,
                           timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                           additional_params = params)
```

Note that `"timber_harvest"` requires specifying the function to be used
to calculate timber volumes, i.e. `timber_volume_function`, for which in
our case we use a predefined function from package
[**IFNallometry**](https://emf-creaf.github.io/IFNallometry/).

The result of the estimation is the following:

``` r
res
#> # A tibble: 6 × 4
#>   id_stand date       timber_harvest live_tree_basal_area
#>   <chr>    <date>              <dbl>                <dbl>
#> 1 080001   2023-01-01         153.                  108. 
#> 2 080001   2024-01-01          20.5                 119. 
#> 3 080001   2025-01-01         126.                  169. 
#> 4 080005   2023-01-01         138.                  162. 
#> 5 080005   2024-01-01           2.04                 24.3
#> 6 080005   2025-01-01         148.                  240.
```

When calling `estimate_indicators`, we can force the inclusion of
indicator units in the output tibble:

``` r
estimate_indicators(indicators = c("timber_harvest", "live_tree_basal_area"),
                    plant_dynamic_input = example_plant_dynamic_input,
                    timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                    additional_params = params,
                    include_units = TRUE)
#> # A tibble: 6 × 4
#>   id_stand date       timber_harvest live_tree_basal_area
#>   <chr>    <date>           [m^3/ha]             [m^2/ha]
#> 1 080001   2023-01-01         153.                  108. 
#> 2 080001   2024-01-01          20.5                 119. 
#> 3 080001   2025-01-01         126.                  169. 
#> 4 080005   2023-01-01         138.                  162. 
#> 5 080005   2024-01-01           2.04                 24.3
#> 6 080005   2025-01-01         148.                  240.
```

## Real example with data from package forestables

Let us now present a more real example case. We will use forest
inventory example data generated from package
[**forestables**](https://emf-creaf.github.io/forestables/). This data
set includes data for forest plots in Barcelona province in three
Spanish forest inventory surveys (IFN2, IFN3 and IFN4):

``` r
library(forestables)
#> Loading required package: data.table
#> Loading required package: dtplyr
ifn_output_example
#> # A tibble: 8,997 × 24
#>    id_unique_code    year plot  coordx coordy coord_sys   crs  elev aspect slope
#>    <chr>            <int> <chr>  <dbl>  <dbl> <chr>     <dbl> <dbl>  <dbl> <dbl>
#>  1 08_0001_NN_A1_A1  1990 0001  402000 4.68e6 ED50      23031  1900     NA    NA
#>  2 08_0002_NN_A1_A1  1990 0002  400000 4.68e6 ED50      23031  1700     NA    NA
#>  3 08_0003_NN_A1_A1  1990 0003  401000 4.68e6 ED50      23031  1700     NA    NA
#>  4 08_0004_NN_A1_A1  1990 0004  402000 4.68e6 ED50      23031  1400     NA    NA
#>  5 08_0005_NN_A1_A1  1990 0005  400000 4.68e6 ED50      23031  1300     NA    NA
#>  6 08_0006_NN_A1_A1  1990 0006  397000 4.68e6 ED50      23031  1700     NA    NA
#>  7 08_0007_NN_A1_xx  1990 0007  399000 4.68e6 ED50      23031  1400     NA    NA
#>  8 08_0008_NN_A1_xx  1990 0008  401000 4.68e6 ED50      23031  1100     NA    NA
#>  9 08_0009_NN_A1_xx  1990 0009  402000 4.68e6 ED50      23031  1100     52    NA
#> 10 08_0010_NN_A1_xx  1990 0010  394000 4.68e6 ED50      23031  1500     NA    NA
#> # ℹ 8,987 more rows
#> # ℹ 14 more variables: country <chr>, version <chr>, class <chr>,
#> #   subclass <chr>, province_code <chr>, province_name_original <chr>,
#> #   ca_name_original <chr>, sheet_ntm <chr>, huso <dbl>, slope_mean <chr>,
#> #   type <int>, tree <list>, understory <list>, regen <list>
```

### Reshaping data for forestindicators

A wrapper function, called
[`forestables2forestindicators()`](https://emf-creaf.github.io/forestindicators/reference/forestables2forestindicators.md)
has been included to transform **forestables** output objects into data
frames suitable for **forestindicators**. We start by reshaping data
from IFN2:

``` r
x_ifn2 <- forestables2forestindicators(ifn_output_example, version = "ifn2")
x_ifn2
#> # A tibble: 47,480 × 10
#>    id_stand       date       province plant_entity     n   dbh     h cubing_form
#>    <chr>          <date>        <dbl> <chr>        <dbl> <dbl> <dbl> <chr>      
#>  1 08_0001_NN_A1… 1990-01-01        8 Pinus uncin…  31.8  18.9   7.5 2          
#>  2 08_0001_NN_A1… 1990-01-01        8 Pinus uncin…  14.1  29.2   7.5 2          
#>  3 08_0001_NN_A1… 1990-01-01        8 Pinus uncin…  14.1  23.9   9.5 2          
#>  4 08_0001_NN_A1… 1990-01-01        8 Pinus uncin…  14.1  23.7   7   5          
#>  5 08_0001_NN_A1… 1990-01-01        8 Pinus uncin…  14.1  32.7   8   2          
#>  6 08_0001_NN_A1… 1990-01-01        8 Pinus uncin…  31.8  13.7   8   2          
#>  7 08_0001_NN_A1… 1990-01-01        8 Pinus uncin…  31.8  15.7   8   2          
#>  8 08_0001_NN_A1… 1990-01-01        8 Pinus uncin… 127.    7.7   4.5 3          
#>  9 08_0001_NN_A1… 1990-01-01        8 Pinus uncin…  14.1  26.1  10   2          
#> 10 08_0001_NN_A1… 1990-01-01        8 Pinus uncin…  31.8  20.3   9   2          
#> # ℹ 47,470 more rows
#> # ℹ 2 more variables: quality_wood <chr>, state <chr>
```

### Estimating indicators for a single inventory survey

We now determine the indicators that can be evaluated with this data
set:

``` r
available_indicators(plant_dynamic_input = x_ifn2)
#>  [1] "cut_tree_basal_area"          "cut_tree_density"            
#>  [3] "dead_tree_basal_area"         "dead_tree_density"           
#>  [5] "density_dead_wood"            "dominant_tree_diameter"      
#>  [7] "dominant_tree_height"         "hart_becking_index"          
#>  [9] "live_tree_basal_area"         "live_tree_biomass_stock"     
#> [11] "live_tree_carbon_change_rate" "live_tree_carbon_stock"      
#> [13] "live_tree_density"            "live_tree_volume_stock"      
#> [15] "mean_tree_height"             "quadratic_mean_tree_diameter"
#> [17] "timber_harvest"               "timber_harvest_carbon_rate"
```

And finally make a call to
[`estimate_indicators()`](https://emf-creaf.github.io/forestindicators/reference/estimate_indicators.md)
with the desired indicators:

``` r
estimate_indicators(c("live_tree_density", 
                      "live_tree_basal_area",
                      "mean_tree_height",
                      "dominant_tree_height", 
                      "dominant_tree_diameter",
                      "quadratic_mean_tree_diameter",
                      "hart_becking_index"), 
                    plant_dynamic_input = x_ifn2, 
                    include_units = TRUE)
#> # A tibble: 2,972 × 9
#>    id_stand   date       live_tree_density live_tree_basal_area mean_tree_height
#>    <chr>      <date>                [1/ha]             [m^2/ha]              [m]
#>  1 08_0001_N… 1990-01-01              460.                12.9              7.32
#>  2 08_0002_N… 1990-01-01              230.                16.9             11.0 
#>  3 08_0003_N… 1990-01-01              221.                 5.82             6.33
#>  4 08_0004_N… 1990-01-01              138.                 4.64             8.09
#>  5 08_0005_N… 1990-01-01              391.                12.1              8.11
#>  6 08_0006_N… 1990-01-01              351.                25.2             10.3 
#>  7 08_0007_N… 1990-01-01              807.                34.4              9.81
#>  8 08_0008_N… 1990-01-01              446.                 6.27             5.04
#>  9 08_0009_N… 1990-01-01             1107.                15.0              5.78
#> 10 08_0010_N… 1990-01-01              532.                15.7              8.95
#> # ℹ 2,962 more rows
#> # ℹ 4 more variables: dominant_tree_height [m], dominant_tree_diameter [cm],
#> #   quadratic_mean_tree_diameter [cm], hart_becking_index [%]
```

### Estimating change rates between inventory surveys

Here we illustrate the calculation of rates in carbon stock of living
trees, between two consecutive forest inventories: IFN2-IFN3. We first
reshape IFN3 as we did with IFN2:

``` r
x_ifn3 <- forestables2forestindicators(ifn_output_example, version = "ifn3")
```

We then filter common forest plots and merge the result into a single
data frame:

``` r
x_ifn2_filt <- x_ifn2 |>
  dplyr::filter(id_stand %in% x_ifn3$id_stand)
x_ifn3_filt <- x_ifn3 |>
  dplyr::filter(id_stand %in% x_ifn2$id_stand)
x_ifn23 <- dplyr::bind_rows(x_ifn2_filt, x_ifn3_filt)
```

Finally, we can use
[`estimate_indicators()`](https://emf-creaf.github.io/forestindicators/reference/estimate_indicators.md)
to estimate carbon stocks in IFN2 and IFN3, as well as the rates of
biomass change due to changes in living stock:

``` r
estimate_indicators(c("live_tree_carbon_stock",
                      "live_tree_carbon_change_rate"), 
                    plant_dynamic_input = x_ifn23, 
                    plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                    include_units = TRUE)
#> ! 48 negative stem biomass values truncated to zero for taxon 41 with model 1.
#> ! 3 negative stem biomass values truncated to zero for taxon 41 with model 1.
#> ! 48 negative stem biomass values truncated to zero for taxon 41 with model 1.
#> ! 3 negative stem biomass values truncated to zero for taxon 41 with model 1.
#> # A tibble: 5,249 × 4
#>    id_stand         date       live_tree_carbon_stock live_tree_carbon_change_…¹
#>    <chr>            <date>                     [t/ha]                [t/(ha*yr)]
#>  1 08_0001_NN_A1_A1 1990-01-01                  148.                      NA    
#>  2 08_0001_NN_A1_A1 2001-01-01                  245.                       8.83 
#>  3 08_0002_NN_A1_A1 1990-01-01                  187.                      NA    
#>  4 08_0002_NN_A1_A1 2001-01-01                  193.                       0.553
#>  5 08_0003_NN_A1_A1 1990-01-01                   64.4                     NA    
#>  6 08_0003_NN_A1_A1 2001-01-01                  155.                       8.20 
#>  7 08_0004_NN_A1_A1 1990-01-01                   43.2                     NA    
#>  8 08_0004_NN_A1_A1 2001-01-01                   25.3                     -1.63 
#>  9 08_0005_NN_A1_A1 1990-01-01                  177.                      NA    
#> 10 08_0005_NN_A1_A1 2001-01-01                  225.                       4.35 
#> # ℹ 5,239 more rows
#> # ℹ abbreviated name: ¹​live_tree_carbon_change_rate
```
