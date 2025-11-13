# Additional parameters for indicators

A data frame with the description of additional parameters for indicator
functions

## Format

A data frame with indicator additional parameters in rows and columns:

- `indicator_name`: String with indicator name. Should not contain
  spaces (use underscore for multiple word separation).

- `parameter`: String with parameter name, as defined in the indicator
  function.

- `default_value`: Default value for the parameter.

- `description`: String describing the function parameter.

## See also

[`indicator_definition`](https://emf-creaf.github.io/forestindicators/reference/indicator_definition.md),
[`variable_definition`](https://emf-creaf.github.io/forestindicators/reference/variable_definition.md)

## Examples

``` r
data(additional_parameters)
```
