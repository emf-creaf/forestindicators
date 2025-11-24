#' Describe an individual indicator
#'
#' Prompts information in to the console regarding the definition, units and data requirements for a given
#' forest indicator.
#'
#' @param indicator Character string of the indicator to be described.
#'
#' @returns The function returns console output only.
#' @seealso \code{\link{available_indicators}}, \code{\link{estimate_indicators}}
#'
#' @export
#'
#' @examples
#' show_information("timber_harvest_volume")
show_information <- function(indicator) {
  indicator <- match.arg(indicator, indicator_definition$indicator)
  row <- which(indicator_definition$indicator == indicator)

  cat("A) DEFINITION\n\n")
  cat(paste("   Name: ", indicator,"\n"))
  cat(paste("   Estimation: ", indicator_definition$estimation_method[row],"\n"))
  cat(paste("   Interpretation: ", indicator_definition$interpretation[row],"\n"))
  cat(paste("   Output units: ", indicator_definition$output_units[row],"\n"))
  cat("\n\n")
  cat("B) DATA INPUTS\n\n")
  stand_static_variable_string <- indicator_definition$stand_static_variables[row]
  if(!is.na(stand_static_variable_string)) {
    cat(paste("B.1) Stand-level static data:\n\n"))
    stand_static_variables <- strsplit(stand_static_variable_string, ", ")[[1]]
    print(variable_definition[variable_definition$variable %in% stand_static_variables, c("variable", "type", "units", "description")],
          row.names = FALSE)
  } else {
    cat(paste("B.1) Stand-level static data: <NONE>\n"))
  }
  stand_dynamic_variable_string <- indicator_definition$stand_dynamic_variables[row]
  if(!is.na(stand_dynamic_variable_string)) {
    cat(paste("B.2) Stand-level dynamic data:\n\n"))
    stand_dynamic_variables <- strsplit(stand_dynamic_variable_string, ", ")[[1]]
    print(variable_definition[variable_definition$variable %in% stand_dynamic_variables, c("variable", "type", "units", "description")],
          row.names = FALSE)
  } else {
    cat(paste("B.2) Stand-level dynamic data: <NONE>\n"))
  }
  plant_static_variable_string <- indicator_definition$plant_static_variables[row]
  if(!is.na(plant_static_variable_string)) {
    cat(paste("B.3) Plant-level static data:\n\n"))
    plant_static_variables <- strsplit(plant_static_variable_string, ", ")[[1]]
    print(variable_definition[variable_definition$variable %in% plant_static_variables, c("variable", "type", "units", "description")],
          row.names = FALSE)
  } else {
    cat(paste("B.3) Plant-level static data: <NONE>\n"))
  }
  plant_dynamic_variable_string <- indicator_definition$plant_dynamic_variables[row]
  if(!is.na(plant_dynamic_variable_string)) {
    cat(paste("B.4) Plant-level dynamic data:\n\n"))
    plant_dynamic_variables <- strsplit(plant_dynamic_variable_string, ", ")[[1]]
    print(variable_definition[variable_definition$variable %in% plant_dynamic_variables, c("variable", "type", "units", "description")],
          row.names = FALSE)
  } else {
    cat(paste("B.4) Plant-level dynamic data: <NONE>\n"))
  }
  cat("\n\n")
  cat("C) ADDITIONAL PARAMETERS\n\n")
  print(additional_parameters[additional_parameters$indicator == indicator, c("parameter", "default_value", "description")],
        row.names = FALSE)
  cat("\n\n")
}
