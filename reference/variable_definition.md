# Input variable definitions

A data frame of variable definitions and units, as used in indicator
estimation

## Format

A data frame with variables in rows and columns:

- `variable_name`: String with variable name. Should not contain spaces
  (use underscore for multiple word separation).

- `level`: String describing the level (scale) to which the variable
  applies, either 'stand' or 'plant'.

- `type`: String with variable type, either 'character' or 'numeric'.

- `units`: String indicating the variable units.

- `description`: String with the verbal description of the variable.

## See also

[`indicator_definition`](https://emf-creaf.github.io/forestindicators/reference/indicator_definition.md),
[`additional_parameters`](https://emf-creaf.github.io/forestindicators/reference/additional_parameters.md)

## Examples

``` r
data(variable_definition)
```
