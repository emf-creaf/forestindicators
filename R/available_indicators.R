#' Available indicators
#'
#' Provides the set of indicators available for the supplied input data
#'
#' @param stand_static_input A data frame (or \code{\link[sf]{sf}} object) containing static stand variables. Minimum required column are \code{id_stand} (character).
#' @param stand_dynamic_input Optional data frame containing dynamic stand variables. Minimum required columns are \code{id_stand} (character) and \code{date} (\code{\link{Date}}).
#' @param plant_static_input Optional data frame containing static plant variables. Minimum required columns are \code{id_stand} (character) and \code{plant_entity} (character).
#' @param plant_dynamic_input Optional data frame containing dynamic plant variables. Minimum required columns are \code{id_stand} (character), \code{plant_entity} (character) and \code{date} (\code{\link{Date}}).
#'
#' @returns A character string with the set of indicators that can be estimated given the supplied input data.
#' @seealso \code{\link{show_information}}, \code{\link{estimate_indicators}}
#' @export
#' @examples
#' available_indicators(plant_dynamic_input = example_plant_dynamic_input)
available_indicators<-function(stand_static_input = NULL,
                               stand_dynamic_input = NULL,
                               plant_static_input = NULL,
                               plant_dynamic_input = NULL) {
  .check_data_inputs(stand_static_input,
                     stand_dynamic_input,
                     plant_static_input,
                     plant_dynamic_input)

  indicators <- indicator_definition$indicator
  allowed <- rep(TRUE, length(indicators))
  for(i in 1:length(indicators)) {
    allowed[i] <- .is_estimable(indicators[i],
                                stand_static_input,
                                stand_dynamic_input,
                                plant_static_input,
                                plant_dynamic_input,
                                verbose = FALSE,
                                estimation = FALSE)
  }
  return(indicators[allowed])
}

.check_data_inputs <- function(stand_static_input = NULL,
                               stand_dynamic_input = NULL,
                               plant_static_input = NULL,
                               plant_dynamic_input = NULL) {
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
}

.check_var_type<-function(varname, vector, input, estimation = FALSE) {
  if(!(varname %in% variable_definition$variable)) {
    if(estimation) {
      cli::cli_abort(paste0("Variable '",varname,"' of ", input, " not found in variable definition!"))
    } else {
      return(FALSE)
    }
  }
  type <- variable_definition$type[variable_definition$variable == varname]
  if(type =="numeric") if(!is.numeric(vector)) {
    if(estimation) {
      cli::cli_abort(paste0("Variable '",varname,"' in ", input, " should be numeric"))
    } else {
      return(FALSE)
    }
  }
  if(type =="character") if(!is.character(vector)) {
    if(estimation) {
      cli::cli_abort(paste0("Variable '",varname,"' in ", input, " should be character"))
    } else {
      return(FALSE)
    }
  }
  if(type =="logical") if(!is.logical(vector)) {
    if(estimation) {
      cli::cli_abort(paste0("Variable '",varname,"' in ", input, " should be logical"))
    }     else {
      return(FALSE)
    }
  }
  return(TRUE)
}

.get_output_units<-function(indicator) {
  row <- which(indicator_definition$indicator == indicator)
  if(length(row)==1) return(indicator_definition$output_units[row])
  cli::cli_abort("Indicator not found")
}

.is_estimable<-function(indicator,
                        stand_static_input = NULL,
                        stand_dynamic_input = NULL,
                        plant_static_input = NULL,
                        plant_dynamic_input = NULL,
                        verbose = FALSE,
                        estimation = TRUE) {

  row <- which(indicator_definition$indicator == indicator)

  # Check structure of indicators
  if(verbose) cli::cli_progress_step(paste0("Checking inputs for '", indicator,"'."))
  stand_static_variable_string <- indicator_definition$stand_static_variables[row]
  if(!is.na(stand_static_variable_string)) {
    if(is.null(stand_static_input)) {
      if(estimation) {
        cli::cli_abort(paste0("Stand static input is needed to estimate ", indicator))
      } else {
        return(FALSE)
      }
    }
    stand_static_variables <- strsplit(stand_static_variable_string, ", ")[[1]]
    for(var in stand_static_variables) {
      if(!(var %in% names(stand_static_input))) {
        if(estimation) {
          cli::cli_abort(paste0("Variable '", var,"' not found in stand_static_input"))
        } else {
          return(FALSE)
        }
      }
      allowed_var <- .check_var_type(var, stand_static_input[[var]], "stand_static_input", estimation)
      if(!allowed_var) return(FALSE)
    }
  }
  stand_dynamic_variable_string <- indicator_definition$stand_dynamic_variables[row]
  if(!is.na(stand_dynamic_variable_string)) {
    if(is.null(stand_dynamic_input)) {
      if(estimation) {
        cli::cli_abort(paste0("Stand dynamic input is needed to estimate ", indicator))
      } else {
        return(FALSE)
      }
    }
    stand_dynamic_variables <- strsplit(stand_dynamic_variable_string, ", ")[[1]]
    for(var in stand_dynamic_variables) {
      if(!(var %in% names(stand_dynamic_input))) {
        if(estimation) {
          cli::cli_abort(paste0("Variable '", var,"' not found in stand_dynamic_input"))
        } else {
          return(FALSE)
        }
      }
      allowed_var <- .check_var_type(var, stand_dynamic_input[[var]], "stand_dynamic_input", estimation)
      if(!allowed_var) return(FALSE)
    }
  }
  plant_static_variable_string <- indicator_definition$plant_static_variables[row]
  if(!is.na(plant_static_variable_string)) {
    if(is.null(plant_static_input)) {
      if(estimation) {
        cli::cli_abort(paste0("Plant static input is needed to estimate ", indicator))
      } else {
        return(FALSE)
      }
    }
    plant_static_variables <- strsplit(plant_static_variable_string, ", ")[[1]]
    for(var in plant_static_variables) {
      if(!(var %in% names(plant_static_input))) {
        if(estimation) {
          cli::cli_abort(paste0("Variable '", var,"' not found in plant_static_input"))
        } else {
          return(FALSE)
        }
      }
      allowed_var <- .check_var_type(var, plant_static_input[[var]], "plant_static_input", estimation)
      if(!allowed_var) return(FALSE)
    }
  }
  plant_dynamic_variable_string <- indicator_definition$plant_dynamic_variables[row]
  if(!is.na(plant_dynamic_variable_string)) {
    if(is.null(plant_dynamic_input)) {
      if(estimation) {
        cli::cli_abort(paste0("Plant dynamic input is needed to estimate ", indicator))
      } else {
        return(FALSE)
      }
    }
    plant_dynamic_variables <- strsplit(plant_dynamic_variable_string, ", ")[[1]]
    for(var in plant_dynamic_variables) {
      if(!(var %in% names(plant_dynamic_input))) {
        if(estimation) {
          cli::cli_abort(paste0("Variable '", var,"' not found in plant_dynamic_input"))
        } else {
          return(FALSE)
        }
      }
      allowed_var <- .check_var_type(var, plant_dynamic_input[[var]], "plant_dynamic_input", estimation)
      if(!allowed_var) return(FALSE)
    }
  }
  return(TRUE)
}
