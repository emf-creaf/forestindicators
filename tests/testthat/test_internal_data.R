
test_that("variable definition units", {
  for(i in 1:length(variable_definition$units)) {
    u  <- variable_definition$units[i]
    if(!is.na(u)) {
      expect_s3_class(units::as_units(u, check_is_valid = TRUE), "units")
    }
  }
})

test_that("indicator functions exist", {
  for(i in 1:length(indicator_definition$indicator)) {
    indicator  <- indicator_definition$indicator[i]
    indicator_function_name <- paste0(".", indicator)
    expect_true(exists(indicator_function_name, envir = getNamespace("forestindicators")),
                info = paste0("Function '", indicator_function_name," not found!"))
  }
})

test_that("indicator definition units", {
  for(i in 1:length(indicator_definition$indicator)) {
    u  <- indicator_definition$output_units[i]
    if(!is.na(u)) {
      expect_s3_class(units::as_units(u, check_is_valid = TRUE), "units")
    }
  }
})

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

# Check that function additional parameters match data of additional_parameters
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
    print(additional_f[!(additional_f %in% additional_data)])
    cli::cli_abort(paste0("Some additional parameters of '", indicator_function_name,"' not found in documentation"))
  }
  if(!all(additional_data %in% additional_f)) {
    cli::cli_abort(paste0("Some additional documented parameters of '", indicator_function_name,"' not found in function definition"))
  }
}



