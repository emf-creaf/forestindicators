#' Indicator definition and requirements
#'
#' A data frame of implemented indicator metrics and their requirements
#'
#' @name indicator_definition
#' @aliases indicator_definition
#'
#' @docType data
#'
#' @format
#' A data frame with parameters in rows and columns:
#' \itemize{
#'   \item{\code{indicator_name}: String with indicator name. Should not contain spaces (use underscore for multiple word separation).}
#'   \item{\code{stand_static_variables}: .}
#'   \item{\code{stand_dynamic_input}: .}
#'   \item{\code{stand_dynamic_variables}: .}
#'   \item{\code{plant_static_input}: .}
#'   \item{\code{plant_static_variables}: .}
#'   \item{\code{plant_dynamic_input}: .}
#'   \item{\code{plant_dynamic_variables}: .}
#'   \item{\code{output_units}: .}
#'   \item{\code{estimation_method}: .}
#'   \item{\code{interpretation}: .}
#'   \item{\code{implementation_responsible}: .}
#' }
#'
#' @examples
#' data(indicator_definition)
#' @keywords data
#' @seealso variable_definition
NULL

#' Input variable definitions
#'
#' A data frame of variable definitions and units, as used in indicator estimation
#'
#' @name variable_definition
#' @aliases variable_definition
#'
#' @docType data
#'
#' @format
#' A data frame with parameters in rows and columns:
#' \itemize{
#'   \item{\code{variable_name}: String with variable name. Should not contain spaces (use underscore for multiple word separation).}
#'   \item{\code{level}: .}
#'   \item{\code{units}: .}
#'   \item{\code{description}: .}
#' }
#'
#' @examples
#' data(variable_definition)
#' @keywords data
#' @seealso indicator_definition
NULL
