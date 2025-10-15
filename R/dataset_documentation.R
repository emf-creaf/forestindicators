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
#' A data frame with indicators in rows and columns:
#' \itemize{
#'   \item{\code{indicator_name}: String with indicator name. Should not contain spaces (use underscore for multiple word separation).}
#'   \item{\code{stand_static_variables}: String with \emph{stand static variables} (e.g. slope) separated by commas. Variable names should not contain spaces (use underscore for multiple word separation).}
#'   \item{\code{stand_dynamic_variables}: String with \emph{stand dynamic variables} (e.g. canopy cover, stand leaf area index) separated by commas. Variable names should not contain spaces (use underscore for multiple word separation).}
#'   \item{\code{plant_static_variables}: String with \emph{plant static variables} separated by commas. Variable names should not contain spaces (use underscore for multiple word separation).}
#'   \item{\code{plant_dynamic_variables}: String with \emph{plant dynamic variables} (e.g. dbh, height, cover) separated by commas. Variable names should not contain spaces (use underscore for multiple word separation).}
#'   \item{\code{output_units}: String describing the units of the indicator metric (e.g. Mg/ha).}
#'   \item{\code{estimation_method}: String describing the procedure for indicator estimation.}
#'   \item{\code{interpretation}: String describing how the indicator should be interpreted and common usage.}
#'   \item{\code{implementation_responsible}: Name of the person responsible for the definition and implementation of the indicator within the package.}
#' }
#'
#' @examples
#' data(indicator_definition)
#' @keywords data
#' @seealso \code{\link{variable_definition}}, \code{\link{additional_parameters}}
NULL

#' Additional parameters for indicators
#'
#' A data frame with the description of additional parameters for indicator functions
#'
#' @name additional_parameters
#' @aliases additional_parameters
#'
#' @docType data
#'
#' @format
#' A data frame with indicator additional parameters in rows and columns:
#' \itemize{
#'   \item{\code{indicator_name}: String with indicator name. Should not contain spaces (use underscore for multiple word separation).}
#'   \item{\code{parameter}: String with parameter name, as defined in the indicator function.}
#'   \item{\code{default_value}: Default value for the parameter.}
#'   \item{\code{description}: String describing the function parameter.}
#' }
#'
#' @examples
#' data(additional_parameters)
#' @keywords data
#' @seealso \code{\link{indicator_definition}}, \code{\link{variable_definition}}
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
#' A data frame with variables in rows and columns:
#' \itemize{
#'   \item{\code{variable_name}: String with variable name. Should not contain spaces (use underscore for multiple word separation).}
#'   \item{\code{level}: String describing the level (scale) to which the variable applies, either 'stand' or 'plant'.}
#'   \item{\code{type}: String with variable type, either 'character' or 'numeric'.}
#'   \item{\code{units}: String indicating the variable units.}
#'   \item{\code{description}: String with the verbal description of the variable.}
#' }
#'
#' @examples
#' data(variable_definition)
#' @keywords data
#' @seealso \code{\link{indicator_definition}}, \code{\link{additional_parameters}}
NULL

#' Example datasets
#'
#' Example datasets for package function testing and documentation
#'
#' @name example_datasets
#' @aliases example_stand_static_input
#' @aliases example_stand_dynamic_input
#' @aliases example_plant_static_input
#' @aliases example_plant_dynamic_input
#'
#' @docType data
#'
#' @examples
#' data(example_stand_static_input)
#' @keywords data
#' @seealso indicator_definition
NULL
