# Indicator definition and requirements

A data frame of implemented indicator metrics and their requirements

## Format

A data frame with indicators in rows and columns:

- `indicator_name`: String with indicator name. Should not contain
  spaces (use underscore for multiple word separation).

- `stand_static_variables`: String with *stand static variables* (e.g.
  slope) separated by commas. Variable names should not contain spaces
  (use underscore for multiple word separation).

- `stand_dynamic_variables`: String with *stand dynamic variables* (e.g.
  canopy cover, stand leaf area index) separated by commas. Variable
  names should not contain spaces (use underscore for multiple word
  separation).

- `plant_static_variables`: String with *plant static variables*
  separated by commas. Variable names should not contain spaces (use
  underscore for multiple word separation).

- `plant_dynamic_variables`: String with *plant dynamic variables* (e.g.
  dbh, height, cover) separated by commas. Variable names should not
  contain spaces (use underscore for multiple word separation).

- `output_units`: String describing the units of the indicator metric
  (e.g. Mg/ha).

- `estimation_method`: String describing the procedure for indicator
  estimation.

- `interpretation`: String describing how the indicator should be
  interpreted and common usage.

- `implementation_responsible`: Name of the person responsible for the
  definition and implementation of the indicator within the package.

## See also

[`variable_definition`](https://emf-creaf.github.io/forestindicators/reference/variable_definition.md),
[`additional_parameters`](https://emf-creaf.github.io/forestindicators/reference/additional_parameters.md)

## Examples

``` r
data(indicator_definition)
```
