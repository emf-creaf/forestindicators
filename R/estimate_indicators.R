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
                                stand_static_input,
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
  if(!inherits(stand_static_input, "data.frame")) cli::cli_abort("'stand_static_input' should be a data frame")
  if(!is.null(stand_dynamic_input)) {
    if(!inherits(stand_dynamic_input, "data.frame")) cli::cli_abort("'stand_dynamic_input' should be a data frame")
  }
  if(!is.null(plant_static_input)) {
    if(!inherits(plant_static_input, "data.frame")) cli::cli_abort("'plant_static_input' should be a data frame")
  }
  if(!is.null(plant_dynamic_input)) {
    if(!inherits(plant_dynamic_input, "data.frame")) cli::cli_abort("'plant_dynamic_input' should be a data frame")
  }
  if(!is.null(additional_params)) {
    if(!inherits(additional_params, "list")) cli::cli_abort("'additional_params' should be a named list")
  }

  # For each indicator
  indicator_table <- vector("list", length(indicators))
  for(indicator in indicators) {
    if(verbose) cli::cli_progress_step(paste0("Checking inputs for '", indicator,"'."))

    if(verbose) cli::cli_progress_step(paste0("Processing '", indicator,"'."))
  }
  if(verbose) cli::cli_progress_step("Assembling results")
  result <- dplyr::bind_cols(indicator_table)
  if(verbose) cli::cli_progress_done()
  return(result)
}

