indicator_definition <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                       sheet="indicators"), stringsAsFactors=FALSE)

variable_definition <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                      sheet="variables"), stringsAsFactors=FALSE)

additional_parameters <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                      sheet="additional_parameters"), stringsAsFactors=FALSE)

# Check that variables cited in indicator definition are actually defined in variable definition
.check_var<-function(varname, input) {
  if(!(varname %in% variable_definition$variable)) cli::cli_abort(paste0("Variable '",varname,"' of ", input ," not found in variable definition!"))
  type <- variable_definition$type[variable_definition$variable == varname]
  if(!(type %in% c("numeric", "character", "logical")))  cli::cli_abort(paste0("Variable '",varname,"' of ", input ," does not have a recongizable type!"))
}
for(i in 1:nrow(indicator_definition)) {
  if(!is.na(indicator_definition$stand_static_variables[i])) {
    stand_static_variables <- strsplit(indicator_definition$stand_static_variables[i], ", ")[[1]]
    for(var in stand_static_variables) .check_var(var, "stand_static_input")
  }
  if(!is.na(indicator_definition$stand_dynamic_variables[i])) {
    stand_dynamic_variables <- strsplit(indicator_definition$stand_dynamic_variables[i], ", ")[[1]]
    for(var in stand_dynamic_variables) .check_var(var, "stand_dynamic_input")
  }
  if(!is.na(indicator_definition$plant_static_variables[i])) {
    plant_static_variables <- strsplit(indicator_definition$plant_static_variables[i], ", ")[[1]]
    for(var in plant_static_variables) .check_var(var, "plant_static_input")
  }
  if(!is.na(indicator_definition$plant_dynamic_variables[i])) {
    plant_dynamic_variables <- strsplit(indicator_definition$plant_dynamic_variables[i], ", ")[[1]]
    for(var in plant_dynamic_variables) .check_var(var, "plant_dynamic_input")
  }
}

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
