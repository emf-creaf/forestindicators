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
#>   id_stand  area slope
#> 1   080001  14.3   5.1
#> 2   080002 362.6   3.1
#> 3   080003 319.6   8.9
#> 4   080004 635.2   4.4
#> 5   080005 774.8   8.9
#> 6   080006 166.6   5.3
#> 7   080007 368.0   4.7
#> 8   080008 945.9   4.3
#> 9   080009 548.9   1.4
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
#> 1    080001 2025-01-01              353.2          8.4
#> 2    080002 2025-01-01              355.1         63.2
#> 3    080003 2025-01-01              377.0         68.9
#> 4    080004 2025-01-01              836.6         24.8
#> 5    080005 2025-01-01              742.4         45.4
#> 6    080006 2025-01-01              405.7         12.7
#> 7    080007 2025-01-01              103.3         96.3
#> 8    080008 2025-01-01              561.8          1.6
#> 9    080009 2025-01-01              522.1         10.6
#> 10   080001 2025-02-01              383.2         22.5
#> 11   080002 2025-02-01              511.2         85.9
#> 12   080003 2025-02-01              552.0         61.7
#> 13   080004 2025-02-01              813.3         32.9
#> 14   080005 2025-02-01              368.0         50.7
#> 15   080006 2025-02-01              436.1         30.2
#> 16   080007 2025-02-01              867.9         51.0
#> 17   080008 2025-02-01              304.6         85.8
#> 18   080009 2025-02-01              349.1         67.8
#> 19   080001 2025-03-01               46.3         44.1
#> 20   080002 2025-03-01              335.6         33.1
#> 21   080003 2025-03-01              509.6         96.3
#> 22   080004 2025-03-01              824.6         59.1
#> 23   080005 2025-03-01              607.5         76.7
#> 24   080006 2025-03-01              554.8         57.4
#> 25   080007 2025-03-01              710.4         43.8
#> 26   080008 2025-03-01              111.7         17.6
#> 27   080009 2025-03-01              623.2         12.1
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
#> 1    080001 Pinus halepensis       0.26
#> 2    080002 Pinus halepensis       0.03
#> 3    080003 Pinus sylvestris       0.28
#> 4    080004 Pinus sylvestris       0.02
#> 5    080005     Quercus ilex       0.52
#> 6    080006     Quercus ilex       0.36
#> 7    080007     Quercus ilex       0.51
#> 8    080008    Quercus suber       0.08
#> 9    080009    Quercus suber       0.98
#> 10   080001      Pinus nigra       0.62
#> 11   080002      Pinus nigra       0.42
#> 12   080005 Pinus halepensis       0.72
#> 13   080006 Pinus halepensis       0.43
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
#> 1    080001 Pinus halepensis 2025-01-01  live 18.3 22.3 352
#> 2    080001 Pinus halepensis 2025-01-01  live 36.5 18.8 891
#> 3    080001      Pinus nigra 2025-01-01  live 51.1  5.3 644
#> 4    080001      Pinus nigra 2025-01-01  live 36.9 18.4 543
#> 5    080001      Pinus nigra 2025-01-01  live 13.9 13.3 852
#> 6    080001 Pinus halepensis 2025-02-01  live 49.1 17.1 698
#> 7    080001 Pinus halepensis 2025-02-01  live 24.4  3.2 885
#> 8    080001      Pinus nigra 2025-02-01  live 12.0 10.1 454
#> 9    080001      Pinus nigra 2025-02-01  live 45.3 20.6 312
#> 10   080001      Pinus nigra 2025-02-01  live 35.1 22.5 651
#> 11   080001 Pinus halepensis 2025-03-01  live 49.8 13.6 424
#> 12   080001 Pinus halepensis 2025-03-01  live 22.7  4.6 506
#> 13   080001      Pinus nigra 2025-03-01  live 36.9  6.4  59
#> 14   080001      Pinus nigra 2025-03-01  live  9.1 15.5 445
#> 15   080001      Pinus nigra 2025-03-01  live 41.2  9.6 851
#> 16   080005     Quercus ilex 2025-01-01  live 22.4 18.1 491
#> 17   080005     Quercus ilex 2025-01-01  live  8.3  5.8 565
#> 18   080005 Pinus halepensis 2025-01-01  live 40.9 11.7 433
#> 19   080005     Quercus ilex 2025-02-01  live 44.8 22.7 576
#> 20   080005     Quercus ilex 2025-02-01  live 33.1 13.1 769
#> 21   080005 Pinus halepensis 2025-02-01  live 13.9 21.3 904
#> 22   080005     Quercus ilex 2025-03-01  live 27.4 22.5 118
#> 23   080005     Quercus ilex 2025-03-01  live 19.5 18.6 818
#> 24   080005 Pinus halepensis 2025-03-01  live 50.0 12.0 592
#> 25   080005 Pinus halepensis 2025-03-01  live 11.2 12.5 357
#> 26   080001 Pinus halepensis 2025-01-01   cut 43.9 18.3  21
#> 27   080001 Pinus halepensis 2025-01-01   cut 41.4  3.5 166
#> 28   080001      Pinus nigra 2025-01-01   cut 29.1 18.9   0
#> 29   080001 Pinus halepensis 2025-02-01   cut 49.4  5.8  73
#> 30   080001      Pinus nigra 2025-03-01   cut 13.0 20.0 194
#> 31   080005     Quercus ilex 2025-01-01   cut 17.2 20.6 147
#> 32   080005 Pinus halepensis 2025-01-01   cut 10.0  4.3 200
#> 33   080005     Quercus ilex 2025-02-01   cut 44.1  7.1  22
#> 34   080005 Pinus halepensis 2025-03-01   cut 45.7 11.8  17
#> 35   080001 Pinus halepensis 2025-03-01  dead 26.1 13.3  81
#> 36   080001      Pinus nigra 2025-03-01  dead 36.2 11.0  82
#> 37   080001      Pinus nigra 2025-03-01  dead 49.6  6.9  72
#> 38   080001      Pinus nigra 2025-03-01  dead 40.5 10.9  33
#> 39   080005     Quercus ilex 2025-01-01  dead 25.9  7.7   8
#> 40   080005     Quercus ilex 2025-01-01  dead 18.7 13.4  75
#> 41   080005 Pinus halepensis 2025-01-01  dead 16.7 18.0  97
#> 42   080005 Pinus halepensis 2025-02-01  dead 31.0  4.6  43
#> 43   080005     Quercus ilex 2025-03-01  dead 35.1  2.5  74
#> 44   080005     Quercus ilex 2025-03-01  dead  7.1  7.6  69
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
#> [11] "live_tree_carbon_stock"       "live_tree_density"           
#> [13] "mean_tree_height"             "quadratic_mean_tree_diameter"
#> [15] "timber_harvest"
```

Say we decide to estimate the *timber harvest volume* (i.e. indicator
`"timber_harvest"`) and the *density of dead wood* (i.e. indicator
`"density_dead_wood"`).

We may need to check which data inputs are required, their units, etc.
We can find this information using function
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
#>      variable      type   units
#>           dbh   numeric      cm
#>             h   numeric       m
#>             n   numeric ind./ha
#>  plant_entity character       -
#>         state character       -
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
#>                                                                           description
#>             Minimum  tree diameter to be included in the estimation of harvest volume
#>  Maximum  tree diameter to be included in the estimation of density of harvest volume
#>                          Tree species included in the calculation of harvested volume
#>                      Tree species not included in the calculation of harvested volume
```

### Step 2: Assemble inputs and define values for additional parameters

Once the requested format and content of inputs is know, it is the
responsibility of the user to build the necessary data frames to be used
as inputs. In our case, we will use `example_plant_dynamic_input` that
already contains the necessary data for the estimation of the two
indicators.

We will normally need to define additional parameters to fine-tune the
estimation of indicators, For that, we define a **named list** where
each element corresponds to a different indicator and, in turn, contains
a named list of parameters. In our case:

``` r
params <- list(timber_harvest = list(province = 8),
               density_dead_wood = list(max_tree_dbh = 20))
```

### Step 3: Call general estimation function

Once we have our inputs ready, the indicators are estimated by calling
function
[`estimate_indicators()`](https://emf-creaf.github.io/forestindicators/reference/estimate_indicators.md)
as follows:

``` r
res <- estimate_indicators(indicators = c("timber_harvest", "density_dead_wood"),
                           plant_dynamic_input = example_plant_dynamic_input,
                           timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                           additional_params = params)
#> ℹ Checking overall inputs
#> ℹ Checking inputs for 'timber_harvest'.
#> ✔ Checking inputs for 'timber_harvest'. [5ms]
#> 
#> ℹ Checking overall inputs✔ Checking overall inputs [30ms]
#> 
#> ℹ Processing 'timber_harvest'.
#> ℹ Checking inputs for 'density_dead_wood'.
#> ✔ Checking inputs for 'density_dead_wood'. [10ms]
#> 
#> ℹ Processing 'timber_harvest'.✔ Processing 'timber_harvest'. [150ms]
#> 
#> ℹ Processing 'density_dead_wood'.
#> ✔ Processing 'density_dead_wood'. [25ms]
```

Note that `"timber_harvest"` requires specifying the function to be used
to calculate timber volumes, i.e. `timber_volume_function`, for which in
our case we use a predefined package function.

The result of the estimation is the following:

``` r
res
#> # A tibble: 6 × 4
#>   id_stand date       timber_harvest density_dead_wood
#>   <chr>    <date>              <dbl>             <dbl>
#> 1 080001   2025-01-01          51.9                187
#> 2 080001   2025-02-01          29.2                 73
#> 3 080001   2025-03-01          25.6                 NA
#> 4 080005   2025-01-01          34.4                 NA
#> 5 080005   2025-02-01           6.98                22
#> 6 080005   2025-03-01          11.3                 17
```

## Example with data from forestables

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

``` r
ifn4_example <- ifn_output_example|>
  dplyr::filter(version == "ifn4")
```

``` r
x <- ifn4_example |>
  dplyr::select(id_unique_code, year, province_code, tree) |>
  tidyr::unnest(cols = tree) |>
  dplyr::select("id_unique_code", "year", "province_code", "sp_name", "density_factor", "dbh", "height", "tree_ifn4") |>
  dplyr::mutate(province_code = as.numeric(province_code)) |>
  dplyr::mutate(year = as.Date(paste0(year, "-01-01"))) |>
  dplyr::rename(id_stand = id_unique_code, 
                province = province_code,
                date = year,
                n = density_factor, 
                h = height, 
                plant_entity = sp_name) |>
  dplyr::mutate(state = "live") |>
  dplyr::filter(!is.na(n)) |>
  dplyr::select(-tree_ifn4)
```

``` r
summary(x)
#>    id_stand              date               province plant_entity      
#>  Length:33682       Min.   :2014-01-01   Min.   :8   Length:33682      
#>  Class :character   1st Qu.:2014-01-01   1st Qu.:8   Class :character  
#>  Mode  :character   Median :2015-01-01   Median :8   Mode  :character  
#>                     Mean   :2014-11-08   Mean   :8                     
#>                     3rd Qu.:2015-01-01   3rd Qu.:8                     
#>                     Max.   :2016-01-01   Max.   :8                     
#>        n                dbh               h            state          
#>  Min.   :  5.093   Min.   :  7.50   Min.   : 1.40   Length:33682      
#>  1st Qu.: 14.147   1st Qu.: 14.20   1st Qu.: 7.80   Class :character  
#>  Median : 31.831   Median : 20.40   Median :10.70   Mode  :character  
#>  Mean   : 36.773   Mean   : 22.03   Mean   :11.24                     
#>  3rd Qu.: 31.831   3rd Qu.: 27.45   3rd Qu.:13.90                     
#>  Max.   :127.324   Max.   :106.60   Max.   :39.70
```

``` r
available_indicators(plant_dynamic_input = x)
#>  [1] "cut_tree_basal_area"          "cut_tree_density"            
#>  [3] "dead_tree_basal_area"         "dead_tree_density"           
#>  [5] "density_dead_wood"            "dominant_tree_diameter"      
#>  [7] "dominant_tree_height"         "hart_becking_index"          
#>  [9] "live_tree_basal_area"         "live_tree_biomass_stock"     
#> [11] "live_tree_carbon_stock"       "live_tree_density"           
#> [13] "mean_tree_height"             "quadratic_mean_tree_diameter"
#> [15] "timber_harvest"
```

``` r
estimate_indicators(c("live_tree_density", 
                      "live_tree_basal_area",
                      "mean_tree_height",
                      "dominant_tree_height", 
                      "dominant_tree_diameter",
                      "quadratic_mean_tree_diameter",
                      "hart_becking_index"), 
                    plant_dynamic_input = x, 
                    verbose = FALSE)
#> # A tibble: 1,568 × 9
#>    id_stand   date       live_tree_density live_tree_basal_area mean_tree_height
#>    <chr>      <date>                 <dbl>                <dbl>            <dbl>
#>  1 08_0001_N… 2015-01-01              638.                 30.5             9.99
#>  2 08_0002_N… 2014-01-01              162.                 16.3            14.1 
#>  3 08_0003_N… 2015-01-01              827.                 26.0             8.91
#>  4 08_0004_N… 2014-01-01             1924.                 18.5             7.41
#>  5 08_0005_N… 2014-01-01              732.                 18.1             7.00
#>  6 08_0006_N… 2014-01-01              387.                 33.2            11.8 
#>  7 08_0009_x… 2016-01-01             1625.                 32.0             7.42
#>  8 08_0014_N… 2015-01-01              679.                 21.1            13.2 
#>  9 08_0016_x… 2014-01-01             1187.                 41.7            14.2 
#> 10 08_0020_N… 2015-01-01             2088.                 61.6             9.95
#> # ℹ 1,558 more rows
#> # ℹ 4 more variables: dominant_tree_height <dbl>, dominant_tree_diameter <dbl>,
#> #   quadratic_mean_tree_diameter <dbl>, hart_becking_index <dbl>
```
