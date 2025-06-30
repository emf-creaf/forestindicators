#' Estimate forest indicators
#'
#' Estimates available forest indicators for a given set of forest stands
#'
#' @param indicators A character vector containing the indicators to be estimated.
#' @param stand_static_input A data frame (or \code{\link{sf}} object) containing static stand variables. Minimum required column are \code{id_stand} (character).
#' @param stand_dynamic_input Optional data frame containing dynamic stand variables. Minimum required columns are \code{id_stand} (character) and \code{date} (\code{\link{Date}}).
#' @param plant_static_input Optional data frame containing static plant variables. Minimum required columns are \code{id_stand} (character) and \code{plant_entity} (character).
#' @param plant_dynamic_input Optional data frame containing dynamic plant variables. Minimum required columns are \code{id_stand} (character), \code{plant_entity} (character) and \code{date} (\code{\link{Date}}).
#' @param timber_volume_function Optional function supplied for timber volume calculation.
#' @param plant_biomass_function Optional function supplied for whole-plant biomass calculation.
#' @param additional_params Optional named list where each element is in turn a list of additional parameters required for internal indicator functions.
#' @param verbose A logical flag to provide information on progress
#'
#' @returns
#' @export
#'
estimate_indicators <- function(indicators,
                                stand_static_input,
                                stand_dynamic_input = NA,
                                plant_static_input = NA,
                                plant_dynamic_input = NA,
                                timber_volume_function = NA,
                                plant_biomass_function = NA,
                                additional_params = list(),
                                verbose = TRUE) {
  # Check indicator string against available indicators
  indicators <- match.arg(indicators, available_indicators(), several.ok = TRUE)
  if(verbose) cli::cli_progress_step("Checking overall inputs")
  # Check inputs (general structure)

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

