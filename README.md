
# Indicators of forest stands

## Introduction

Package **forestindicators** is meant to assist the estimation of
indicators (metrics) for forest stands, either derived from forest
inventory data or forest model simulations. Most often, those indicators
will estimate the provision of forest ecosystem services, but the
package can be understood more generally as a platform to estimate
forest metrics.

## Package installation

Package **forestindicators** can be installed from GitHub using:

``` r
remotes::install_github("emf-creaf/forestindicators")
```

## Documentation and training

Two *vignettes* are included
[here](https://emf-creaf.github.io/forestindicators/articles/)
illustrate: (1) how to use the R package to estimate indicators; and (2)
how to define new indicators.

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
