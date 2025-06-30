indicator_definition <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                       sheet="indicators"), stringsAsFactors=FALSE) |>
  dplyr::mutate(stand_dynamic_input = as.logical(stand_dynamic_input),
                plant_static_input = as.logical(plant_static_input),
                plant_dynamic_input = as.logical(plant_dynamic_input))

variable_definition <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                      sheet="variables"), stringsAsFactors=FALSE)

# TODO: Check that variables cited in indicator definition are actually defined in variable definition


usethis::use_data(indicator_definition, overwrite = TRUE)
usethis::use_data(variable_definition, overwrite = TRUE)
