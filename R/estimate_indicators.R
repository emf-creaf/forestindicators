#' Estimate forest indicators
#'
#' Estimates forest indicators for a given set of forest stands during a given set of dates of evaluation.
#'
#' @param indicators A character vector containing the indicators to be estimated.
#' @param stand_static_input A data frame (or \code{\link[sf]{sf}} object) containing static stand variables. Minimum required column are \code{id_stand} (character).
#' @param stand_dynamic_input Optional data frame containing dynamic stand variables. Minimum required columns are \code{id_stand} (character) and \code{date} (\code{\link{Date}}).
#' @param plant_static_input Optional data frame containing static plant variables. Minimum required columns are \code{id_stand} (character) and \code{plant_entity} (character).
#' @param plant_dynamic_input Optional data frame containing dynamic plant variables. Minimum required columns are \code{id_stand} (character), \code{plant_entity} (character) and \code{date} (\code{\link{Date}}).
#' @param timber_volume_function Optional function supplied for timber volume calculation.
#' @param plant_biomass_function Optional function supplied for whole-plant biomass calculation.
#' @param additional_params Optional named list where each element is in turn a list of additional parameters required for internal indicator functions.
#' @param verbose A logical flag to provide information on progress
#'
#' @returns A data frame with the following columns:
#'   \itemize{
#'     \item{\code{id_stand} - Stand identifier.}
#'     \item{\code{date} - Date of indicator assessment.}
#'     \item{\code{...} - Additional columns with names equal to strings given in \code{indicators}.}
#'   }
#'
#' @details
#' Additional details...
#'
#' @export
#'
estimate_indicators <- function(indicators,
                                stand_static_input = NULL,
                                stand_dynamic_input = NULL,
                                plant_static_input = NULL,
                                plant_dynamic_input = NULL,
                                timber_volume_function = NULL,
                                plant_biomass_function = NULL,
                                additional_params = list(),
                                verbose = TRUE) {
  # Check indicator string against available indicators
  indicators <- match.arg(indicators, indicator_definition$indicator, several.ok = TRUE)
  if(verbose) cli::cli_progress_step("Checking overall inputs")
  # Check inputs (general structure)
  if(!is.null(stand_static_input)) {
    if(!inherits(stand_static_input, "data.frame")) cli::cli_abort("'stand_static_input' should be a data frame")
    if(!("id_stand" %in% names(stand_static_input))) cli::cli_abort("'stand_static_input' should contain a character column called 'id_stand'")
    if(!is.character(stand_static_input$id_stand)) cli::cli_abort("'id_stand' of 'stand_static_input' should contain character values")
  }

  if(!is.null(stand_dynamic_input)) {
    if(!inherits(stand_dynamic_input, "data.frame")) cli::cli_abort("'stand_dynamic_input' should be a data frame")
    if(!("id_stand" %in% names(stand_dynamic_input))) cli::cli_abort("'stand_dynamic_input' should contain a character column called 'id_stand'")
    if(!is.character(stand_dynamic_input$id_stand)) cli::cli_abort("'id_stand' of 'stand_dynamic_input' should contain character values")
    if(!("date" %in% names(stand_dynamic_input))) cli::cli_abort("'stand_dynamic_input' should contain a Date column called 'date'")
    if(!inherits(stand_dynamic_input$date, "Date")) cli::cli_abort("'date' of 'stand_dynamic_input' should contain 'Date' values")
  }
  if(!is.null(plant_static_input)) {
    if(!inherits(plant_static_input, "data.frame")) cli::cli_abort("'plant_static_input' should be a data frame")
    if(!("id_stand" %in% names(plant_static_input))) cli::cli_abort("'plant_static_input' should contain a character column called 'id_stand'")
    if(!is.character(plant_static_input$id_stand)) cli::cli_abort("'id_stand' of 'plant_static_input' should contain character values")
    if(!("plant_entity" %in% names(plant_static_input))) cli::cli_abort("'plant_static_input' should contain a character column called 'plant_entity'")
    if(!is.character(plant_static_input$plant_entity)) cli::cli_abort("'plant_entity' of 'plant_static_input' should contain character values")
  }
  if(!is.null(plant_dynamic_input)) {
    if(!inherits(plant_dynamic_input, "data.frame")) cli::cli_abort("'plant_dynamic_input' should be a data frame")
    if(!("id_stand" %in% names(plant_dynamic_input))) cli::cli_abort("'plant_dynamic_input' should contain a character column called 'id_stand'")
    if(!is.character(plant_dynamic_input$id_stand)) cli::cli_abort("'id_stand' of 'plant_dynamic_input' should contain character values")
    if(!("plant_entity" %in% names(plant_dynamic_input))) cli::cli_abort("'plant_dynamic_input' should contain a character column called 'plant_entity'")
    if(!is.character(plant_dynamic_input$plant_entity)) cli::cli_abort("'plant_entity' of 'plant_dynamic_input' should contain character values")
    if(!("date" %in% names(plant_dynamic_input))) cli::cli_abort("'plant_dynamic_input' should contain a Date column called 'date'")
    if(!inherits(plant_dynamic_input$date, "Date")) cli::cli_abort("'date' of 'plant_dynamic_input' should contain 'Date' values")
  }
  if(!is.null(additional_params)) {
    if(!inherits(additional_params, "list")) cli::cli_abort("'additional_params' should be a named list")
  }


  # For each indicator
  for(i in 1:length(indicators)) {
    indicator  <- indicators[i]
    row <- which(indicator_definition$indicator == indicator)
    indicator_function_name <- paste0(".", indicator)
    if(!exists(indicator_function_name)) cli::cli_abort(paste0("Function '", indicator_function_name," not found!"))
    indicator_function <- get(indicator_function_name)

    if(verbose) cli::cli_progress_step(paste0("Checking inputs for '", indicator,"'."))
    .check_var_type<-function(varname, vector, input) {
      if(!(varname %in% variable_definition$variable)) cli::cli_abort(paste0("Variable '",varname,"' of ", input, " not found in variable definition!"))
      type <- variable_definition$type[variable_definition$variable == varname]
      if(type =="numeric") if(!is.numeric(vector)) cli::cli_abort(paste0("Variable '",varname,"' in ", input, " should be numeric"))
      if(type =="character") if(!is.character(vector)) cli::cli_abort(paste0("Variable '",varname,"' in ", input, " should be character"))
      if(type =="logical") if(!is.logical(vector)) cli::cli_abort(paste0("Variable '",varname,"' in ", input, " should be logical"))
    }
    stand_static_variable_string <- indicator_definition$stand_static_variables[row]
    if(!is.na(stand_static_variable_string)) {
      if(is.null(stand_static_input)) cli::cli_abort(paste0("Stand static input is needed to estimate ", indicator))
      stand_static_variables <- strsplit(stand_static_variable_string, ", ")[[1]]
      for(var in stand_static_variables) {
        if(!(var %in% names(stand_static_input))) cli::cli_abort(paste0("Variable '", var,"' not found in stand_static_input"))
        .check_var_type(var, stand_static_input[[var]], "stand_static_input")
      }
    }
    stand_dynamic_variable_string <- indicator_definition$stand_dynamic_variables[row]
    if(!is.na(stand_dynamic_variable_string)) {
      if(is.null(stand_dynamic_input)) cli::cli_abort(paste0("Stand dynamic input is needed to estimate ", indicator))
      stand_dynamic_variables <- strsplit(stand_dynamic_variable_string, ", ")[[1]]
      for(var in stand_dynamic_variables) {
        if(!(var %in% names(stand_dynamic_input))) cli::cli_abort(paste0("Variable '", var,"' not found in stand_dynamic_input"))
        .check_var_type(var, stand_dynamic_input[[var]], "stand_dynamic_input")
      }
    }
    plant_static_variable_string <- indicator_definition$plant_static_variables[row]
    if(!is.na(plant_static_variable_string)) {
      if(is.null(plant_static_input)) cli::cli_abort(paste0("Plant static input is needed to estimate ", indicator))
      plant_static_variables <- strsplit(plant_static_variable_string, ", ")[[1]]
      for(var in plant_static_variables) {
        if(!(var %in% names(plant_static_input))) cli::cli_abort(paste0("Variable '", var,"' not found in plant_static_input"))
        .check_var_type(var, plant_static_input[[var]], "plant_static_input")
      }
    }
    plant_dynamic_variable_string <- indicator_definition$plant_dynamic_variables[row]
    if(!is.na(plant_dynamic_variable_string)) {
      if(is.null(plant_dynamic_input)) cli::cli_abort(paste0("Plant dynamic input is needed to estimate ", indicator))
      plant_dynamic_variables <- strsplit(plant_dynamic_variable_string, ", ")[[1]]
      for(var in plant_dynamic_variables) {
        if(!(var %in% names(plant_dynamic_input))) cli::cli_abort(paste0("Variable '", var,"' not found in plant_dynamic_input"))
        .check_var_type(var, plant_dynamic_input[[var]], "plant_dynamic_input")
      }
    }

    if(verbose) cli::cli_progress_step(paste0("Processing '", indicator,"'."))
    argList <- list(stand_static_input = stand_static_input,
                    stand_dynamic_input = stand_dynamic_input,
                    plant_static_input = plant_static_input,
                    plant_dynamic_input = plant_dynamic_input,
                    timber_volume_function = timber_volume_function,
                    plant_biomass_function = plant_biomass_function)

    if(indicator %in% names(additional_params)) argList = c(argList, additional_params[[indicator]])
    indicator_table <- do.call(indicator_function, args=argList) |>
      tibble::as_tibble()
    if(i==1) {
      result <- indicator_table
    } else {
      result <- result |>
        dplyr::full_join(indicator_table, by=c("id_stand", "date"))
    }
  }
  if(verbose) cli::cli_progress_done()
  return(result)
}
