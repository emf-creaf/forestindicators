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
#' @param additional_params Optional named list where each element is in turn a list of additional parameters required for internal indicator functions. The additional parameters of each indicator are found in table \code{\link{additional_parameters}}.
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
#' @seealso \code{\link{available_indicators}}, \code{\link{show_information}}
#' @examples
#' ## Use functions show_information() and available_indicators() to learn
#' ## the requested inputs
#'
#' ## Named lists with additional parameters needed for each indicator
#' add_params <- list(density_dead_wood = list(max_tree_dbh = 20))
#'
#' ## Call indicator estimation
#' estimate_indicators(c("live_basal_area", "density_dead_wood"),
#'                     plant_dynamic_input = example_plant_dynamic_input,
#'                     additional_params = add_params,
#'                     verbose = TRUE)
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
  .check_data_inputs(stand_static_input,
                     stand_dynamic_input,
                     plant_static_input,
                     plant_dynamic_input)

  if(!is.null(additional_params)) {
    if(!inherits(additional_params, "list")) cli::cli_abort("'additional_params' should be a named list")
  }


  # For each indicator
  for(i in 1:length(indicators)) {
    indicator  <- indicators[i]
    .is_estimable(indicator,
                  stand_static_input,
                  stand_dynamic_input,
                  plant_static_input,
                  plant_dynamic_input,
                  verbose = verbose,
                  estimation = TRUE)

    indicator_function_name <- paste0(".", indicator)
    if(!exists(indicator_function_name)) cli::cli_abort(paste0("Function '", indicator_function_name," not found!"))
    indicator_function <- get(indicator_function_name)

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
    # browser()
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
