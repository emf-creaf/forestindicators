
indicator_definition <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                       sheet="indicators"), stringsAsFactors=FALSE) |>
  dplyr::arrange(indicator)

variable_definition <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                      sheet="variables"), stringsAsFactors=FALSE) |>
  dplyr::arrange(variable)

additional_parameters <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                      sheet="additional_parameters"), stringsAsFactors=FALSE) |>
  dplyr::arrange(indicator)

# Check that functions exist
for(i in 1:length(indicator_definition$indicator)) {
  indicator  <- indicator_definition$indicator[i]
  indicator_function_name <- paste0(".", indicator)
  if(!exists(indicator_function_name, envir = getNamespace("forestindicators"))) cli::cli_abort(paste0("Function '", indicator_function_name," not found!"))
}

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

# Check that function additional parameters match data of additional_parameters  --------
for(i in 1:length(indicator_definition$indicator)) {
  indicator  <- indicator_definition$indicator[i]
  indicator_function_name <- paste0(".", indicator)
  f <- get(indicator_function_name, envir = getNamespace("forestindicators"))
  additional_f <- names(formals(f))
  additional_f <- additional_f[!(additional_f %in% c("stand_static_input", "stand_dynamic_input",
                                                     "plant_static_input", "plant_dynamic_input",
                                                     "timber_volume_function", "plant_biomass_function",
                                                     "..."))]
  additional_data <- additional_parameters$parameter[additional_parameters$indicator==indicator]
  if(!all(additional_f %in% additional_data)) {
    cli::cli_abort(paste0("Some additional parameters of '", indicator_function_name,"' not found in documentation"))
  }
  if(!all(additional_data %in% additional_f)) {
    cli::cli_abort(paste0("Some additional documented parameters of '", indicator_function_name,"' not found in function definition"))
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
