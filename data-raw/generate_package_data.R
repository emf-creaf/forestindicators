
indicator_definition <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                       sheet="indicators"), stringsAsFactors=FALSE) |>
  dplyr::arrange(indicator)

variable_definition <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                      sheet="variables"), stringsAsFactors=FALSE) |>
  dplyr::arrange(variable)

additional_parameters <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                      sheet="additional_parameters"), stringsAsFactors=FALSE) |>
  dplyr::arrange(indicator)


usethis::use_data(indicator_definition, overwrite = TRUE)
usethis::use_data(variable_definition, overwrite = TRUE)
usethis::use_data(additional_parameters, overwrite = TRUE)

# Example datasets --------------------------------------------------------
example_stand_static_input <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_example_input.xlsx",
                                                             sheet="stand_static_input"), stringsAsFactors=FALSE)
usethis::use_data(example_stand_static_input, overwrite = TRUE)

example_stand_dynamic_input <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_example_input.xlsx",
                                                             sheet="stand_dynamic_input"), stringsAsFactors=FALSE)|>
  dplyr::mutate(date = as.Date(date))
usethis::use_data(example_stand_dynamic_input, overwrite = TRUE)

example_plant_static_input <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_example_input.xlsx",
                                                             sheet="plant_static_input"), stringsAsFactors=FALSE)
usethis::use_data(example_plant_static_input, overwrite = TRUE)

example_plant_dynamic_input <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_example_input.xlsx",
                                                              sheet="plant_dynamic_input"), stringsAsFactors=FALSE)|>
  dplyr::mutate(date = as.Date(date))
usethis::use_data(example_plant_dynamic_input, overwrite = TRUE)

